# GPC Underwriting Control Center — Implementation Plan

## Product scope

The supplied repository confirms that the existing OM Intake Desk is a working, substantial prototype. It implements browser-side OM/seller-file ingestion, Claude extraction, LIHTC/FMR data services, report autosave, workbook storage/versioning, user administration, and a Scenario 0–4 workflow. Its production source is archived in a compressed Bun loader rather than maintained as readable application files, and the repository contains no regression suite or human-readable deployment source.

This project delivers a **companion control center with a working intake lane**, not a misleading reimplementation of the existing source archive. It makes the underwriting workflow more transparent and easier to operate by providing:

- a saved-report workspace with automatic browser persistence, rename, delete, and new-report actions;
- explicit field provenance, confidence, validation status, and manual-override indicators;
- a Scenario 4 review calculator that shows the exact stated decision rule before it is used in the model;
- a reference-regression lane focused only on Cypress Cove, Springfield Crossing, and Bluffs at Evergreen;
- a downloadable, audited `GPC Underwriting Model Template v5` built from the supplied v4 template with Scenario 4 after Scenario 3 and page-break-preview artifacts removed;
- actual offering-memorandum and seller-file drop zones, durable project-storage staging, and AI-assisted source extraction into the evidence register.
- an automated **valuation snapshot** that converts only extracted, source-linked underwriting facts into price/unit, in-place rent potential, net-LIHTC potential, reported-NOI, and implied-cap-rate metrics—while withholding any metric whose evidence is incomplete.
- an **MTSP-derived LIHTC rent engine** that reads the supplied FY2025/FY2026 HUD MTSP income-limit workbooks, derives monthly gross maximum rents from the applicable annual 50%/60% income limit, exposes State → County → Year → AMI selectors, and applies the selected limits only to non-overridden matching unit sets.
- automatic **HERA Special compliance flags** that compare each Scenario 1 proposed net rent plus its utility allowance against the imported HERA Special gross maximum, disclose the amount over cap and the precise source context, and never change a proposed rent or model formula on the user’s behalf.

The portal will not claim to calculate a final investment decision. Intake results are always presented as **review-required evidence**, with source-file labels and manual-override markers. Uploaded source bytes are sent only to project storage and the project LLM service for the requested extraction; this increment does not create a shared multi-user report index.

## Design direction

### Candidate styles

1. **Institutional deal room** (chosen, 0.07): sober, review-first interface inspired by investment-committee workpapers.
2. **Spreadsheet-native utility** (0.05): compact grid with minimal chrome and formula-forward controls.
3. **Broker operations console** (0.08): higher-density workflow board with document queues and alerts.

### Chosen: institutional deal room

- **Design movement:** Financial workpaper editorial — dark ink, warm paper surfaces, precise table geometry, and carefully weighted typography.
- **Core principles:** Evidence before confidence; no hidden model decisions; direct editability; progression from source document to reviewed output.
- **Color philosophy:** Deep navy carries authority, muted stone keeps dense figures readable, teal denotes verified data, amber denotes operator attention, and red is reserved for blocking exceptions.
- **Layout paradigm:** A persistent report rail leads into a two-column operating workspace, with evidence/audit material available alongside—not buried behind—calculations.
- **Signature elements:** Provenance badges, compact audit timeline, and a scenario-rule ribbon that exposes each formula decision.
- **Interaction philosophy:** Every user edit is immediately marked as a manual override and autosaved locally after a short debounce. Rename and delete require intentional, reversible-in-context actions.
- **Animation:** Only subtle opacity/position transitions for save state and selected report changes; reduced-motion users receive the final state immediately.
- **Typography:** `Georgia` for sectional hierarchy and `Inter, ui-sans-serif, system-ui` for tabular interface work.
- **Brand essence:** An evidence-first control surface for multifamily underwriting—not another opaque extraction demo.
- **Personality:** Exacting, calm, transparent.
- **Brand voice:** “Show the source before the number.” / “Ready for review—not ready to assume.”
- **Wordmark:** `GPC / Control` with a small offset divider, suggesting a spreadsheet rule and an approval boundary.
- **Signature brand color:** `#0D3B4C` (deep blue-teal).

## Architecture

- **Client:** React 19 + TypeScript + Tailwind, a self-contained operator workspace using `localStorage` for browser-local report state. The browser receives source IDs and metadata only—never project storage keys or signed download URLs.
- **Server/storage/AI/database:** Express authenticates every private source action, validates content signatures, stores bytes through the platform’s presigned object-storage service, indexes source ownership in MySQL, and issues owner-checked short-lived downloads through an application route. XLSX preview parsing is server-side with bounded archive limits; CSV is decoded as UTF-8; legacy XLS files are staged but flagged for conversion. The LIHTC engine parses the bundled HUD MTSP workbooks, selects regular or HERA Special 50%/60% annual income-limit fields, applies the 0–5 bedroom imputed-household-size convention, and calculates monthly gross rent as annual limit × 30% ÷ 12. The supplied FY2025/FY2026 datasets are part of the server bundle as a project reference catalog; an authenticated owner can also import an updated private MTSP workbook into protected storage. Extraction classifies financial sources (OM, rent roll, T-12/financial statement, payroll, or unknown), retains their period, calculates deterministic valuation metrics from source-linked evidence, locks conflicting report edits, preserves manual Scenario 4 rows, and calls the built-in LLM only with source material authorized for the signed-in user.
- **Workbook:** A reproducible Python/openpyxl script upgrades the supplied GPC v4 file. It adds an independent Scenario 4 sheet and Unit Mix section, updates visible scenario references to 0–4, and returns worksheets to normal workbook view to remove Excel’s Page 1 overlays.
- **Reference suite:** Cypress Cove, Springfield Crossing, and Bluffs at Evergreen are registered as review fixtures only; their seller files and OMs are not loaded into browser storage or exposed in the web application.

## Project structure

| Path | Responsibility |
| --- | --- |
| `client/src/pages/Home.tsx` | Control-center interface, autosave interaction, scenario review controls, report management |
| `client/src/data/referenceDeals.ts` | Non-sensitive fixture metadata, report seed values, stored LIHTC cap provenance, and deterministic HERA Special compliance checks |
| `server/intake.ts` | Validated source-file staging, XLSX/CSV preview parsing, PDF/spreadsheet extraction, and response normalization |
| `server/lihtcCatalog.ts` | HUD MTSP import, regular/HERA annual-limit handling, derived rent calculation, and State/County/rent lookup routes |
| `client/src/components/LihtcRentPanel.tsx` | LIHTC catalog upload, State → County → Year → AMI selector, rent results, cap application, and HERA Special compliance flags |
| `client/src/components/ValuationSummary.tsx` | Evidence-backed valuation snapshot with source labels, completeness state, and explicit non-appraisal boundary |
| `drizzle/schema.ts` / `server/db.ts` | Owner-bound intake source index, quotas, access checks, and revocation metadata |
| `client/src/index.css` | Application theme, responsive layout, print and accessibility details |
| `client/public/manus-routes.json` | Route manifest for the Preview runtime |
| `scripts/upgrade_workbook.py` | Repeatable v4 → v5 workbook upgrade with assertions |
| `client/public/GPC_Underwriting_Model_Template_v5.xlsx` | Generated workbook ready for download and model review |
| `TODO.md` | Delivery outcomes and concrete acceptance clauses |

## Key interaction contracts

| Interaction | Observable behavior |
| --- | --- |
| Autosave | A field change immediately becomes a draft in the UI, persists to browser storage after a short debounce, and shows `Saving…` until the local write completes. Reloading restores the latest saved data. |
| Manual override | Editing a seeded/extracted field adds a `Typed in` marker, preserves the previous source in the audit timeline, and never silently presents the new value as extracted. |
| Rename | The prompt starts with the current report name. A blank/cancelled value leaves the committed name unchanged. A successful rename persists and is reflected in the report rail. |
| Delete | Deleting asks for confirmation, removes only the selected browser-stored report, and selects a safe remaining report or creates a blank workspace. |
| Source intake | One PDF OM and one or more XLSX/XLS/CSV seller files can be dropped or selected after Manus sign-in. Accepted bytes are signature-validated, quota-bound, owner-indexed, and staged in project storage. The browser retains only source IDs; `Open source for review` passes through an owner-checked endpoint. Each file shows a source/status badge, and extraction results are review-labeled before they update the register. |
| Valuation snapshot | The server classifies each source and computes only traceable underwriting metrics: extracted units, asking price, price/unit, annual in-place rent, net-LIHTC potential, annual reported NOI, and implied cap rate. A metric stays unavailable when its prerequisites or annual period are not evidenced; this panel never presents an appraisal or approved investment conclusion. |
| LIHTC rent lookup | The included HUD MTSP FY2025/FY2026 workbooks drive State, County, tax year, and AMI options. The server selects the applicable regular or HERA Special annual limit and derives each 0–5 BR monthly gross maximum rent as annual income limit × 30% ÷ 12, using the LIHTC imputed-household-size convention. Applying limits updates only non-manual matching Scenario 4 rows and records the source, geography, year, and AMI in provenance. SAFMR/FMR workbooks are never relabeled as LIHTC rent limits. |
| HERA Special compliance flags | When an imported HERA Special cap is associated with a unit row, the portal tests `Scenario 1 proposed net rent + utility allowance` against the imported gross cap. An overage renders an immediate, accessible warning in the lookup panel and alongside the affected scenario row, showing the proposed gross rent, HERA Special maximum, and variance. A flag is informational and audit-visible only: it does not overwrite rent, utility, cap, or Scenario 4 inputs. |
| Scenario 4 | The control surface calculates `max(net LIHTC, Scenario 1 voucher outcome)` when a maximum LIHTC rent exists; otherwise it retains current rent. It labels the result as operator-review-only until reconciliation is complete. |

## Material limits and next integration

The existing live portal includes several capabilities that should be retained rather than casually duplicated: server-backed reports, tenant/employee PII minimization, a base workbook version history, and HUD lookup services. The control center now has owner-bound source storage and extraction, but report-to-file mapping remains browser-local and platform runtime storage supports access revocation rather than physical object deletion. The next production increment should add authenticated shared reports, scheduled lifecycle cleanup where an object-delete API is available, and approved Cypress/Springfield/Bluffs expected output values. No production deployment is claimed or authorized by this validation build.
