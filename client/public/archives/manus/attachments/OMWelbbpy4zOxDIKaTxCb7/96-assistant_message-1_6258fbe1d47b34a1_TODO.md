# Delivery Checklist

- [x] **Build an evidence-first underwriting control workspace.**
  - Saved reports appear in a persistent rail with active state, a new-report action, and report details that never imply a manually entered value was extracted.
  - The UI shows `Saving review state…`, `Saved in this browser`, or a browser-storage failure state. Changes restore after a browser reload.
  - Rename and delete actions are available with intentional confirmation behavior.

- [x] **Add real OM and seller-file intake.**
  - Allow a user to drag/drop or select one offering memorandum PDF and multiple seller files in `.xlsx`, `.xls`, or `.csv` formats.
  - Validate filename, content signature, archive bounds, type, size, category, per-owner source count, and per-owner byte quota before source bytes are staged. Store accepted bytes in durable project storage through the server without exposing service credentials, storage keys, or signed URLs to the browser.
  - Show each accepted source’s category, source label, size, staged/extracting/extracted/error status, owner-checked source-review link, and a removal action that revokes workspace access.
  - Extract OM facts from PDF and seller-file previews from CSV/XLSX into review-labeled property fields, unit mix, operating lines, and flags. A legacy `.xls` file must remain staged but clearly flag that conversion is required before parsing.
  - Preserve original source labels through extracted fields and Scenario 4 rows; never present an AI-derived item as verified. A manual edit must continue to mark that item `Typed in`, and extraction must preserve manual Scenario 4 rows while it locks conflicting edits.

- [x] **Generate automated valuation summaries from parsed underwriting evidence.**
  - Classify each successfully parsed source as offering memorandum, rent roll, T-12, financial statement, payroll, or unknown and retain annual/trailing-12/monthly/unknown period context.
  - Calculate only source-traceable metrics: units, asking price, price per unit, annual in-place rent, annual net-LIHTC potential, reported annual NOI, and implied cap rate. Annual rent metrics require a parsed, explicit monthly rent/utility basis for every contributing unit set.
  - Withhold unavailable, non-annual, or unknown-basis figures instead of guessing; flag unit-count conflicts and incomplete evidence; and show every contributing source file without silently truncating provenance.
  - Removing a source must revoke its access and clear all AI-derived fields, unit rows, flags, operating lines, and valuation figures until the remaining source set is explicitly re-extracted. Manual entries remain intact.
  - Present the result as a review-required valuation snapshot—not an appraisal, valuation opinion, approved underwriting output, or investment recommendation.

- [x] **Add a deterministic MTSP-based LIHTC county rent lookup.**
  - Parse the supplied FY2025/FY2026 HUD MTSP workbooks by their actual `stusps`, `County_Name`, regular/HERA 50%/60% annual-income-limit fields—not as a fabricated precomputed rent table.
  - Select HERA Special limits only when the row’s HERA designation and all required special fields are present; otherwise use regular MTSP limits. Derive the 0–5 bedroom monthly gross rent as annual income limit × 30% ÷ 12, with imputed household sizes of 1, 1.5, 3, 4.5, 6, and 7.5 persons. Preserve cents; utility allowance remains a separate Scenario 4 deduction.
  - Drive State → County → Year → AMI dropdown options only from the 77,496 derived records in the supplied workbooks, then return matching bedroom caps with regular/HERA provenance. A real FY2026 Autauga, AL 60% lookup returned $933 / $999.75 / $1,200 / $1,386 / $1,546.50 / $1,706.25; a Baldwin, AL lookup exercised the HERA Special path.
  - Apply matching monthly gross rent caps only to non-manual Scenario 4 rows, preserve all existing utility allowances, and record catalog/version/geography/year/AMI provenance. Reference fixtures remain immutable; a local new report permits scenario testing without the Cloudflare-blocked sign-in. Never relabel HUD FMR/SAFMR data as LIHTC rent limits.

- [x] **Flag proposed rents that exceed imported HERA Special maxima.**
  - Preserve the imported HERA Special cap and its source context on each matching unit row so a later manual cap edit cannot silently erase the compliance baseline.
  - Treat `Scenario 1 proposed net rent + utility allowance` as the proposed gross rent for this gross-rent compliance check. Generate a visible warning only when it is greater than the row’s imported HERA Special maximum; do not flag regular-MTSP rows or rows without an imported HERA Special cap.
  - Show the affected unit set, proposed gross rent, maximum allowed HERA Special rent, and exact monthly overage in both a summary warning and the relevant Scenario 4 row. Flags update immediately as proposed rent or utility allowance changes.
  - Warnings are review-required compliance controls: they must not modify inputs, change Scenario 4 logic, or represent a legal determination of LIHTC compliance.
  - Browser validation: FY2026 Baldwin, AL at 60% AMI applied a $1,691.25 3BR HERA Special cap. A proposed net rent of $1,700 plus $150 utility displayed a $1,850.00 gross proposal and a $158.75/month warning; reducing the proposal to $1,500 cleared the warning immediately. Editing the visible cap to $2,000 did not erase the warning baseline.

- [x] **Make manual review and field provenance first-class.**
  - Property/underwriting fields show source, confidence, review status, and editable values.
  - A field override produces one `Typed in` marker and a concise audit entry; continued typing does not create duplicate audit events.
  - A Scenario 4 row override is marked `Typed in` and receives its own audit event.
  - Cypress Cove, Springfield Crossing, and Bluffs at Evergreen are the only immutable fixtures shown in the regression lane, even if a saved report is deleted.

- [x] **Expose Scenario 4 as a reviewable underwriting decision.**
  - The UI explains and calculates `MAX(net LIHTC, Scenario 1)` whenever gross maximum LIHTC exists; otherwise it retains current rent.
  - The same gross-max-LIHTC predicate is used in the generated workbook.
  - Every Scenario 4 UI result carries an explicit reconciliation gate before investment use.

- [x] **Produce an auditable GPC Model Template v5.**
  - Scenario 4 appears directly after Scenario 3 with its own Unit Mix block, own annual output column, and workbook references.
  - Formula validation confirms there are no stale Scenario 3 self-references in Scenario 4, including the principal/balance schedules.
  - All worksheets use normal view and no stored row/column page breaks, eliminating the `Page 1` Page Break Preview overlay.
  - The v5 workbook opens successfully in LibreOffice and is served as a downloadable asset.

- [ ] **Validate and hand off the completed intake flow.**
  - `pnpm check`, production build, additive migration, unauthenticated upload guard, responsive intake layout, and browser-local report restoration must pass. A signed-in browser session is required for the final live PDF/CSV/XLSX upload-and-extraction exercise.
  - Explicitly disclose the distinction between durable, owner-bound source-file storage and the current browser-local report index, including the platform runtime’s access-revocation rather than physical-delete limit.
