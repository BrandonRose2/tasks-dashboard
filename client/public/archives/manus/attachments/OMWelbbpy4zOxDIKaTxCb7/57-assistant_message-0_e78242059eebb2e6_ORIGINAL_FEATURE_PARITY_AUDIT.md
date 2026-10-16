# Original Portal Feature-Parity Audit

**Purpose.** This is an evidence-only inventory of the original portal’s documented/reported behavior, the present replacement position, and the work and supplied data required before a feature can be called parity.

## Evidence boundary and interpretation rules

- **Reported original behavior** below means behavior explicitly described in the supplied original-portal transcript. The transcript reports several local tests and also says the live site was not click-tested from that environment; it is not treated as independently live-verified.
- **Replacement status** is limited to the supplied audit material. The companion/control-center replacement is described as browser-local, fixture-seeded, and not a production replacement for the authenticated extractor/report service. A source-tree listing confirms file paths, not runtime behavior or workbook formulas.
- **Planned/required** items in the status memo or project summary are not existing original capabilities. In particular, rent-roll automation, formal review, public-data connections, and various Phase 2/3 items are not promoted to parity facts.
- **Unsupported** means the permitted evidence does not establish the behavior. It does not prove that the behavior never existed.
- No claim below infers file-acceptance rules, OCR behavior, extraction confidence, page/cell citations, sharing model, approval workflow, workbook revision history, or user-administration mechanics where the audit did not establish them.

> **Non-negotiable data rule — FY2026 FMR/SAFMR files are not LIHTC rent-limit tables.** The repository tree contains files named `FY26_FMRs_revised copy.xlsx` and `fy2026_safmrs_revised copy.xlsx`, but the audit does not establish their contents, portal usage, selection logic, or any link to LIHTC limits. They **must not** be represented, labeled, or substituted as maximum LIHTC-rent tables. LIHTC maximum rents require a distinct, versioned tax-credit limit source together with the applicable property/unit/program/effective-date inputs.

---

## 1. Current replacement status by capability

### Current companion-build reconciliation — October 15, 2026

The domain audit intentionally used only the documented original behavior and the repository evidence; it did not inspect the latest companion source. The following reconciliation keeps this report from understating work completed after the older repository snapshot:

- **Implemented but not parity-complete:** authenticated owner-bound source staging; PDF/CSV/XLSX extraction; browser-local report recovery; typed-value provenance; a review-only Scenario 4 calculator; source-linked valuation snapshot; a downloadable v5 workbook artifact; and a private LIHTC Excel-catalog importer with State → County → Year → AMI lookup and application to non-manual Scenario 4 rows.
- **Still P0 gaps:** report identity/lifecycle remains browser-local rather than durable/shared; source files are not tied to a durable report entity; copy-on-first-edit and owner/admin report controls are not server-enforced; the 49-category T-12 mapper, formula-preserving report-specific workbook generation, and approved reference regressions are absent.
- **Still missing:** an authoritative LIHTC catalog upload/data activation, utility-allowance governance, HOME/rent-roll/voucher rule pipeline, and an approved Scenario 1 formula. The repository’s FY2026 FMR/SAFMR files remain excluded from LIHTC use.

The matrix below is retained as the original-evidence parity baseline. “Absent” means absent from the permitted original-evidence comparison at audit time; it is not a denial of the companion features listed above.

| Capability area | Evidenced original portal baseline | Current replacement status from the audit | Parity status / boundary |
|---|---|---|---|
| **Identity and role boundary** | Sign-in was required. A report owner could Open/Rename/Delete that owner’s report; an admin could do so for any report. | **Not established as production capability.** The companion is browser-local; the audit does not establish authenticated shared persistence or owner/admin enforcement there. | **P0 gap.** Preserve only the evidenced owner/admin actions. Sign-in method, provisioning, session handling, other roles, and user administration remain unsupported. |
| **Non-owner access and copy-on-first-edit** | Opening another person’s report did not alter the original; the opener’s first edit created a separate copy, preserving the original. | **Not established.** No shared server-side report/lineage implementation is evidenced for the replacement. | **P0 gap.** The allowed evidence does not say which non-owners may open a report; that read/open policy must be decided before production sensitive-file access. Do not infer sharing links, collaborators, or live co-editing. |
| **Report creation, identity, and status** | Uploading an OM or seller files began property work, created a Saved reports record, and initially showed it as **in progress**. | **Absent as verified production workflow.** The companion has local review state and seeded fixtures, not the documented server-backed report lifecycle. | **P0 gap.** Require durable report identity, ownership, timestamps, in-progress/deletion state, and uploaded-source association. |
| **Autosave and resume** | Later reported behavior removed an explicit Save report action; edits autosaved within a couple of seconds with saving/saved text and timestamp. Browser backup reportedly restored the same report after refresh or close, with “Picked up where you left off.” | **Absent as verified production workflow.** Browser-local companion state does not establish the original’s authenticated report autosave/recovery behavior. | **P0 gap.** Implement durable debounced autosave, visible state/time, restoration, and a scoped browser recovery copy only if retaining the reported continuity behavior. |
| **Report names and manual-name precedence** | Default name was `PropertyName_MM-DD-YYYY`. A manually entered Property-section correction could update naming and underwriting. A manual report name persisted through autosave; older automatically named reports were reportedly updated on next edit unless manually renamed. | **Not established end-to-end.** The companion’s local audit/calculator controls do not prove report naming, persistence, or workbook propagation. | **P0 gap.** Retain default-name inputs, manual-name flag/value, correction propagation, and legacy-on-next-edit rule if migrating legacy reports. |
| **Open/Rename/Delete and deletion effect** | Owners had Open/Rename/Delete on their reports; admins had the same on any report. Delete reportedly removed the report and disabled further autosave. | **Not established as durable multi-user behavior.** | **P0 gap.** Deletion must prevent late/debounced autosaves from recreating or changing a deleted report. |
| **OM/seller-file intake** | Browser-side OM and seller-file intake with Claude-based extraction is documented at a high level; property work began through such upload. | **Absent.** The replacement/control center has no evidenced OM/seller upload, parser, Claude extraction, or authenticated server workflow. | **P0 gap.** The original accepted formats, MIME/content checks, size limits, duplicate behavior, encrypted/malformed-file handling, and messages/retries are **not specified** by the evidence and must be recovered/defined, not invented as parity. |
| **Extraction provenance and property correction** | A missed **Property-section** field could be typed manually; the value was marked `typed in`, persisted, and fed name, underwriting, and autosave. | **Partial/local-only evidence.** The companion has local manual-audit/override concepts, but not proven full model/report propagation. | **P0 gap.** Preserve typed provenance and prior-source/audit retention for the evidenced Property-section path. Do not claim a broader field-level review/approval surface. |
| **T-12 reader and NOI reconciliation** | The seller operating-statement reader classified lines into 49 model categories. For Cambridge Court, it handled 78 lines, tied seller NOI to **$986,818.73**, and surfaced a **$352 Paymode Rebates** line omitted by the reference model. General rules matched 74 of 75 of Abraham’s assignments. | **Not established in a readable replacement implementation.** The production source is described as an opaque compressed loader; no regression suite is evidenced. | **P0 gap.** Rebuild/characterize line-level mapping, provenance, exceptions, and seller-NOI tie-out. Cambridge is a reference case, not proof of general accuracy. |
| **Rent-roll parsing and voucher/subsidy aggregation** | Only downstream Scenario 4 rules are reported. Rent-roll grouping, tenant-plus-subsidy aggregation, AMI tagging, unit-code decoding, and voucher parsing are documented as Phase 2 requirements/questions. | **Absent as proven parity.** | **P1 gap.** Implement only after rules and keys are supplied; do not describe it as shipped legacy behavior. |
| **Payroll intake/modeling** | Payroll workbooks appear in the tree, but no payroll parsing, mapping, reconciliation, or model treatment is evidenced. | **Absent as proven parity.** | **P2 gap.** Business rules and private-data handling must be supplied before implementation. |
| **Scenario 0–4 scope** | The portal/model was reported to cover labels/output scope for Scenarios 0–4; a scenario-summary download was reported as `Scenarios 0-4.xlsx`. | **Not established as formula-parity in the replacement.** Fixture values/review rules are not approved automated regressions. | **P0 gap.** Scenario 1 remains unresolved: `Max Current Vouchers` was reported as matching Scenario 0, possibly due to a missing formula. Do not assume or silently invent its rule. |
| **Scenario 4 worksheet and decision chain** | `Max Net LIHTC` was reportedly an independent tab immediately after Scenario 3, using Scenario 4 Unit Mix inputs in AK–AP. When a maximum LIHTC rent exists, it uses maximum LIHTC rent less utility allowance; a voucher unit uses the higher of that result or its Scenario 1 rent; without a maximum LIHTC rent, it falls back to current rent. It appears only after maximum LIHTC rents are filled. | **Not verified from the replacement tree or companion.** A companion review rule is not a substitute for workbook/source verification. | **P0 gap.** Implement and formula-test the exact stated chain as an independent sheet. The transcript-reported local recalculation is not a broad regression certification. |
| **LIHTC, utility, HOME, FMR/SAFMR, county/ZIP lookup** | The evidence confirms Scenario 4 consumes prefilled LIHTC maximum rents and utility allowance. It does **not** establish county/ZIP selectors, normalization, FMR/SAFMR read/use, automated LIHTC lookup, utility source workflow, HOME lookup, or location matching. | **Unverified candidate assets only.** The FY2026 FMR/SAFMR filenames do not prove content or usage. | **P0 design/data gap; P1 automation gap.** Keep manual/fallback behavior until a versioned lookup contract and data sources are supplied and verified. |
| **Filled workbook generation and refresh** | A report’s filled Excel model reportedly refreshed automatically as numbers changed, no less frequently than the stated 20-second ceiling. A typed Property-section value reportedly flowed into underwriting. | **Not established.** The allowed tree cannot prove workbook formulas, input mapping, sheet order, or runtime generation. | **P0 gap.** Populate the authoritative mapped v5 template while preserving formulas, layout, formatting, and sheet order. |
| **Template map and workbook versions** | Status memo reports a completed mapping of 99 input cells to source and fill rule. Tree contains v4/v5 template artifacts and a `GPC Template Input Map.xlsx`; transcript separately references `GPC Template Input Map 2.xlsx`. | **Assets exist by name; authoritative pair is unresolved.** | **P0 prerequisite.** Reconcile the exact authoritative editable template and input-map version before generation. No workbook revision/restore history is evidenced. |
| **Downloads and workbook presentation** | Filled-model download existed; scenario-summary download was reported as `Scenarios 0-4.xlsx`. The user reported visible “Page 1” markings on most filled-workbook sheets; no supplied source confirms a fix. | **Not verified.** | **P0 gap.** Refresh from saved inputs before both downloads and inspect exported files; do not mark the “Page 1” defect fixed without inspection. |
| **Dashboard/summary Scenario 4 consumption** | Transcript says the v5 Dashboard and summary tabs did not yet pull Scenario 4. | **No contrary verified replacement evidence.** | **Known limitation.** If full parity is intended, complete downstream consumption separately; do not represent it as already working. |
| **Review navigation, approvals, and queues** | Supported evidence is limited to Saved reports Open and non-mutating cross-user opening/copy-on-edit. Status memo calls a formal review screen a Phase 3 plan. | **Companion offers local review fixtures/audit entries, not a production formal review workflow.** | **Not an original parity claim.** Do not scope folders, search, filters, sort, queues, assignment, approvals, or sign-off as legacy parity without a separate specification. |
| **Audit trail and provenance ledger** | `typed in` marker and report-copy behavior are evidenced; no immutable, server-persisted, queryable/exportable ledger is established. | **Local seeded audit entries/override markers only; not a production audit trail.** | **Critical replacement control.** Add actor, UTC time, before/after, source location, extraction/model version, confidence, and reconciliation/approval state as a new specified control—not a claim of original behavior. |
| **Regression coverage and operational readiness** | Cambridge is the only documented completed validation. The original source/deployment is not readable from the allowed material; no regression suite is evidenced. | **No release-quality regression program.** Cypress is partial/illustrative; Springfield needs an approved expected output; Bluffs is conditional on future approval. | **Critical gap.** Establish reproducible source-to-workbook tests, approved expected output, deployment/secret/migration/rollback procedures, and live authenticated smoke tests before production changes. |

---

## 2. Strictly ordered implementation backlog

**Sequencing rule:** complete the acceptance criteria for an item before treating the next item as parity-ready. Later work may be designed in parallel, but it must not be released as a parity feature ahead of its prerequisite. “Recover” below means obtain authorized readable source/configuration and characterize it; it does not license undocumented behavior to be invented.

### P0 — blocking sequence

1. **Freeze the evidence boundary and recover the readable original implementation contract.**
   - Obtain authorized readable/decompressed original Bun application source and the Railway/runtime configuration described as missing/opaque in the audit.
   - Inventory actual intake validation, report schema, extraction calls, workbook generation, persistence, and deployment dependencies where recoverable.
   - Record every item still not recoverable as a new product decision rather than an original-parity claim.

2. **Reconcile authoritative workbook inputs before generating any replacement workbook.**
   - Identify the authoritative editable v5 template and authoritative 99-cell input map; reconcile the tree’s `GPC Template Input Map.xlsx` with the transcript’s referenced `GPC Template Input Map 2.xlsx`.
   - Preserve a version identifier for the chosen template and map. Do not infer formulas or mapping fidelity from filenames.

3. **Specify the security and access contract for sensitive source files.**
   - Bind every report action to a stable authenticated identity.
   - Implement the evidenced owner/admin action boundary for Open/Rename/Delete.
   - Decide and document the currently unspecified non-owner read/open policy before tenant-name rent rolls or employee-pay payroll files are handled.
   - Define authorization for upload, download/export, copy, rename, delete, and source-file read; do not invent sharing roles or links as legacy behavior.

4. **Build durable report identity, lifecycle, and safe access isolation.**
   - Persist report ID, owner, creation/update times, in-progress state, display name, manual-name state, deletion state, and source-file association.
   - Implement automatic report creation on first property work, owner/admin Open/Rename/Delete, and copy-on-first-edit for an authorized non-owner opener.
   - Make deletion transactional with autosave cancellation/tombstone handling so a pending save cannot revive the deleted report.

5. **Implement report autosave, recovery, and name precedence.**
   - Add debounced durable autosave with visible saving/saved state and timestamp.
   - Restore a saved report after refresh/close; scope browser backup to the reported continuity use case and do not let it bypass authorization.
   - Apply `PropertyName_MM-DD-YYYY`, update an automatic name from corrected property data, preserve a manual name, and apply legacy-on-next-edit renaming only if legacy migration is in scope.

6. **Rebuild secure source intake and evidence lineage.**
   - Add authorized OM/seller-file intake, private object storage, report association, document role, ownership, extraction run/version, model/input-map version, and field-level source lineage.
   - Recover or explicitly specify—rather than assume—format matrix, content/type validation, limits, unreadable-file handling, retries, and duplicate semantics.
   - Treat page/table/cell citation and confidence-threshold behavior as replacement specifications unless recovered from source; the existing parity evidence establishes only the `typed in` marker.

7. **Restore the evidenced Property-section correction path end to end.**
   - Permit a missed Property-section value to be typed in, visibly mark it `typed in`, preserve the prior extracted/source value in audit data, and propagate it to report naming, underwriting, autosave, and workbook refresh.
   - Do not present seller-line correction, generic field correction, or reviewer sign-off as existing parity unless separately specified.

8. **Rebuild and validate the T-12 mapper/reconciler.**
   - Preserve original seller lines and map to all 49 model categories with source-line traceability.
   - Reproduce seller-NOI reconciliation and visible unmapped/ambiguous-line exceptions; use Cambridge Court as a documented reference case, including its 78 lines, $986,818.73 seller NOI, and $352 Paymode Rebates exception.
   - Do not treat 74/75 assignment agreement or the single Cambridge tie-out as a general acceptance suite.

9. **Implement formula-preserving v5 workbook generation and the reported Scenario 4 behavior.**
   - Populate mapped cells without replacing template layout, sheet order, formatting, or formulas.
   - Create Scenario 4 as an independent `Max Net LIHTC` sheet immediately after Scenario 3, use its own AK–AP Unit Mix inputs, and test that it does not retain Scenario 3 labels/references.
   - Apply only the evidenced Scenario 4 decision chain: maximum LIHTC rent minus utility allowance; voucher comparison to Scenario 1; current-rent fallback if no maximum LIHTC rent; visibility after maximum LIHTC rents are populated.
   - Keep Scenario 1 formula work blocked until an approved formula/specification resolves the documented uncertainty.

10. **Complete output/download acceptance and release gates.**
    - Produce both the current filled model and `Scenarios 0-4.xlsx` from current persisted inputs.
    - Inspect exports for the reported “Page 1” artifact; do not close it based solely on code change or assertion.
    - Establish cell/formula/reference tests, source-to-output reconciliation tests, schema/file-ingestion tests, authenticated smoke tests, and a documented deployment, migration, backup/recovery, readiness, rollback, secret, and storage-index procedure.

11. **Create approved reference baselines and enforce release-blocking regressions.**
    - Convert Cypress Cove, Springfield Crossing, and Bluffs at Evergreen into tests only after signed-off completed model outputs, expected exceptions, source-to-cell maps, tolerance rules, and applicable rule data are supplied.
    - Keep Cypress explicitly partial until its missing/reconciled facts are approved; keep Springfield disabled for automated variance testing until its approved model is supplied; keep Bluffs conditional until its outputs are approved.
    - Expand toward the requested 5–10 diverse completed deals before generalizing extraction or workbook parity.

### P1 — after the P0 chain is accepted

12. **Implement rent-roll normalization and unit-level auditability.**
    - Aggregate tenant-paid and subsidy-paid charge lines by unit; map management-system-specific unit codes, unit types, AMI/income level, current rent, and voucher context.
    - Add validation and exception states for missing/ambiguous mappings instead of silently selecting an income/rent rule.

13. **Build governed affordable-housing inputs and lookups.**
    - Ingest versioned LIHTC maximum-rent data, utility allowances, property location/program/effective-date inputs, and placed-in-service data only after the source contracts are supplied.
    - Add HOME applicability and current high/low tables only after supplied; implement the stated lower-limit rule where applicable.
    - Do not claim county/ZIP selector, FMR/SAFMR selector, FMR lookup, SAFMR lookup, or automated LIHTC lookup as restored parity unless verified under the recovered contract.

14. **Make voucher and LIHTC decisioning reviewable per unit.**
    - Show input values, source/provenance, selected rule, fallback, and exception status for each unit.
    - This is necessary for reliable Scenario 4 and a future automated rent-roll workflow, but voucher parsing itself was not established as an existing original portal feature.

15. **Complete Scenario 4 downstream summary/dashboard consumption if required.**
    - The audit identifies non-consumption in the v5 Dashboard/summary as a limitation; add it only after independent Scenario 4 workbook results are validated.

16. **Specify and build an actual reviewer workflow only as new, approved scope.**
    - Define reference-model baselines, calculation-level tolerances, exception disposition, sign-off roles, and retention/export rules.
    - Do not name folders, filters, queues, assignment, approvals, or broad saved-report navigation as original parity without evidence.

### P2 — separately specified work, not current proven parity

17. **Define payroll model rules and build payroll handling.**
    - Obtain the payroll-to-model and any payroll-to-T-12/NOI reconciliation rules before ingestion/mapping.
    - Apply strict private-data authorization because payroll schedules contain employee compensation.

18. **Decide non-evidenced administrative and versioning capabilities.**
    - User lifecycle, role assignment, ownership transfer, invitation/share/revocation, immutable audit exports, workbook revision history, prior-workbook restore, and immutable versioned downloads require explicit product/security decisions.

---

## 3. Required assets and decisions absent from the repository evidence

The tree contains useful candidate files and sample deal packages, but the following materials are absent, incomplete, or not established by the permitted evidence. They must be **supplied, authorized, and versioned** rather than fabricated from filenames, examples, or assumptions.

| Asset, decision, or authority to supply | Why it is required | Evidence boundary / handling requirement |
|---|---|---|
| **Readable original Bun source and readable Railway/runtime/deployment configuration** | Needed to characterize implementation-level intake, extraction, report persistence, workbook, and operational behavior. | The audit says production implementation is archived in a compressed loader and no human-readable deployment source is available. |
| **Authoritative editable v5 workbook and authoritative 99-cell input map** | Required for formula-preserving generation and source/fill-rule fidelity. | Reconcile `GPC Template Input Map.xlsx` with the transcript reference to `GPC Template Input Map 2.xlsx`; filenames alone do not establish authority or formula behavior. |
| **Approved finished models / cell-level expected output for Cypress, Springfield, and Bluffs** | Needed for deterministic regressions and variance acceptance. | Existing repository packages are not approved output baselines. Springfield explicitly awaits an approved expected-output model; Bluffs is conditional. |
| **Five to ten diverse completed deal packages with signed-off models** | Needed to test cross-deal, cross-management-system, and model-rule behavior beyond Cambridge. | Cambridge alone is a documented T-12-focused reference, not general certification. |
| **Per-deal source-to-output map and tolerance/exception rules** | Needed to establish traceability, expected missing/ambiguous values, and pass/fail criteria. | Must identify source document/page/sheet/cell where available, model/template version, approved assumptions, and expected exceptions. |
| **Original intake validation contract or approved replacement specification** | Required for allowed file formats/content validation, size limits, password/encryption/malformed-file behavior, error/retry, and duplicate handling. | None of these details is supported by the current audit; they must not be invented as historical parity. |
| **Persistent user/admin identity source and authorization policy** | Required for owner/admin actions, report attribution, copy-on-edit, and sensitive-file controls. | Sign-in and owner/admin actions are reported; credential flow, non-owner read scope, user lifecycle, sharing, and roles beyond admin are not. |
| **Explicit non-owner report-read/open policy** | Required before permitting access to reports with tenant and employee-pay information. | Original copy-on-edit behavior does not identify which non-owners may open a report. |
| **Private storage, report/file metadata, and recovery/retention policy** | Required for durable uploads, extraction/version linkage, auditability, autosave, backup, and secure deletion behavior. | Browser-local companion state cannot substitute for authenticated server-backed persistence. |
| **Current, applicable LIHTC maximum-rent tables** | Required for Scenario 4's maximum-LIHTC branch and any later automated lookup. | Must be a dedicated tax-credit source with jurisdiction, program, unit/AMI, effective date, and version—not FY2026 FMR/SAFMR files. |
| **Property-level utility-allowance source/value and governance** | Required to calculate net LIHTC rent. | The net-rent arithmetic is reported, but utility source/collection/geography/update process is not. |
| **Property restrictions and affordable-housing rule inputs** | Needed to determine LIHTC/HOME applicability, AMI, unit treatment, and date-sensitive restrictions. | Include property location, program applicability, effective date, current rent, voucher status, and Scenario 1 rent where used. |
| **Current HOME high/low rent tables and property applicability** | Needed for the stated lower-HOME-limit rule. | HOME limits are explicitly a known gap; the audit does not prove they were implemented. |
| **Placed-in-service date plus approved fallback source** | Needed for restriction/rent-limit applicability where the OM omits it. | Documented as needed operating data, not established automation. |
| **Management-system-specific unit-code keys and AMI/income-level mapping** | Needed to connect rent-roll units to limits across Yardi, OneSite, and other formats. | Unit codes vary by management system; do not extrapolate a mapping from samples. |
| **Rent-roll charge-line data and approved tenant/subsidy aggregation rule** | Needed for voucher/subsidy normalization and unit-level scenario calculations. | Treat multiple tenant/subsidy charge lines as a supplied rule requirement, not confirmed completed original behavior. |
| **Authorized CoStar export or licensed/API-backed access** | Needed if market-rent data are incorporated. | The audit says CoStar requires login and warns that automated regular-account access may violate terms. |
| **Payroll-to-model/business-rule specification** | Needed before payroll parsing, mapping, or reconciliation can be built. | Payroll files exist in the tree, but no supported payroll behavior/rule exists; employee-pay data requires private handling. |
| **Approved Scenario 1 formula/specification** | Required because Scenario 1 reportedly matched Scenario 0 and may have a missing formula. | No assumed voucher formula should be promoted to parity. |
| **Resolution of remaining model questions** | Required for credible formula regression and output sign-off. | The audit notes unresolved decisions including conflicting GP equity shares, unspent rehab budget, and an assumable-loan option. These are not approved logic to copy. |
| **Location/FMR/SAFMR selection contract, if desired** | Needed before adding any county/ZIP normalization or FMR/SAFMR lookup. | No existing selector/mapping/lookup is evidenced. The presence of FY2026-named workbooks establishes neither contents nor portal use. |

---

## 4. Explicit non-claims that protect parity accuracy

The replacement must **not** represent the following as existing original behavior unless new, authorized source evidence establishes them:

1. Accepted/rejected extensions or MIME types; upload limits; OCR; password/encryption handling; duplicate semantics; extraction confidence scores; or field-to-page/table/cell citations.
2. County/ZIP selectors, county-to-ZIP mapping, FMR/SAFMR selection, FMR/SAFMR lookup, automated LIHTC maximum-rent lookup, utility-allowance lookup, or any claim that FY2026 FMR/SAFMR workbooks are LIHTC tables.
3. Automated rent-roll grouping, voucher/subsidy parsing, AMI tagging, unit-code decoding, HOME-limit application, or placed-in-service fallback as shipped original portal functionality.
4. Payroll ingestion/mapping/reconciliation or payroll-driven underwriting.
5. Search, filters, folders, sorting, assignment, queues, approval/sign-off, formal reviewer navigation, direct invitations, sharing links, collaborator roles, ownership transfer, user lifecycle administration, or live co-editing.
6. Immutable/report-history audit ledgers, export-version history, restore of prior workbooks, or immutable versioned downloads.
7. A fixed Scenario 1 formula. The documented Scenario 1 behavior is unresolved and must receive an approved specification.
8. A production-ready authenticated replacement merely because local fixtures, browser persistence, source-tree assets, or companion audit controls exist.

---

## 5. Acceptance standard for a truthful parity claim

A capability may be described as **replacement parity** only when all applicable conditions are met:

1. Its original behavior is directly supported by the supplied evidence or recovered authorized source—not inferred from a plan, filename, fixture, or desired workflow.
2. It has passed the access, persistence, lineage, and deletion/copy behavior applicable to that capability.
3. It has test evidence against approved source packages and signed-off expected workbook outputs, with known exceptions recorded.
4. It retains required provenance and marks human-entered values as human-entered rather than extracted fact.
5. For sensitive documents, authorized users only can access the source, report, and exported workbook.
6. For any affordable-housing calculation, the exact versioned data source and eligibility inputs are available; **FMR/SAFMR data is never relabeled as LIHTC maximum-rent data.**

## Audit source set used

This report synthesizes only the provided audit results: `deal-workspace-reports-autosave-audit`; `source-intake-document-extraction`; `lihtc-county-utility-fmr-safmr`; `scenario-subsidy-rent-logic`; `financial-seller-files-parsing-and-reconciliation`; `excel-underwriting-export-lifecycle`; `auth-users-sharing-administration`; and `reference-testing-audit-operational-readiness`.
