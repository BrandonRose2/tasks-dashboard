# ApartmentCorp Monthly Fresh Rent-Comps Report

## Schedule and delivery

Run on the 10th of every month at 8:00 AM in America/Los_Angeles. Use **apartmentcorp44@gmail.com** only. Send the completed monthly Excel workbook and review-checklist PDF to **ethan@apartmentcorp.com** and **mam@22.bz**. For an explicitly requested test, send only to **ethan@apartmentcorp.com**, with `TEST` prefixed to the subject. Preserve the existing timing; this playbook replaces only the obsolete 42-property HUD/ClickUp instructions.

This is a fresh-source soft refresh of the approved workbook's existing conventional market-rate comparable rows. Do not research subject rent rolls, treat affordable rents/AMI/FMR limits as market rents, silently replace comps, sync ClickUp, or automatically publish to SharePoint/API/GitHub. Discover current property and comp counts instead of assuming 41 properties or six comps forever.

## Recover code and establish the approved source

Obtain **ApartmentCorp_Monthly_RentComps_Recovery.zip** from this Reports project's shared files or a user-authorized task attachment. Extract its `recurring-rentcomps` directory to `/home/ubuntu/recurring-rentcomps`. Never assume a previous sandbox still has the files. Install `requirements.txt` and run `python3 -m unittest discover -s tests -v`. The bundle contains the unchanged historical approved August baseline under `baselines/` and the validated November repair-test verification, not preverified future rents.

Check for the latest approved formatted workbook in project files, the portal or the existing SharePoint source: https://aptrents-my.sharepoint.com/:x:/g/personal/brandon_apartmentcorp_com/IQBxPIWZYShLSK-SEUj_0rXcARaMnh4vgEL0eoVz94TfE7g?e=tYlt2H. Establish that it is the approved source, not a differently formatted generated API export or an unapproved research draft. If source approval cannot be established, stop and notify the user in Manus. An old approved workbook may supply formatting and comp identities, but disclose its age and never email its unchanged rents as newly researched.

Set the current run date in America/Los_Angeles, a unique run ID and a new run directory. Calculate and retain the baseline checksum. Example commands, from the extracted directory:

```bash
RUN_DATE=$(python3 -c 'from datetime import datetime; from zoneinfo import ZoneInfo; print(datetime.now(ZoneInfo("America/Los_Angeles")).date())')
RUN_ID="monthly-$RUN_DATE"
BASELINE="/path/to/latest-approved-formatted-workbook.xlsx"
RUN_DIR="reports/$RUN_DATE"
python3 pipeline.py extract --workbook "$BASELINE" --output-dir "$RUN_DIR/extract" --run-id "$RUN_ID" --run-date "$RUN_DATE"
python3 prepare_research.py --workbook "$BASELINE" --output-dir "$RUN_DIR/inputs" --run-id "$RUN_ID" --run-date "$RUN_DATE"
python3 make_workflow.py --inputs "$RUN_DIR/inputs/research-inputs.json" --output "$RUN_DIR/workflow.js"
```

## Fresh comparable research

Read the current research guidance before searching. The parent task must submit the generated workflow through the workflow tool; generating JavaScript does not execute it. Use one dedicated isolated agent per subject property, with its explicit declared input files and `research_prompt.txt` contract. Obtain any required workflow-budget approval. Do not bypass approval gates or pretend the research ran when approval is pending.

Each agent must actually search/open the current comparable source pages, match identity by name/address, verify conventional eligibility, and record fresh price/bedroom evidence. Apartments.com and the official property availability/floor-plan pages are primary; Zillow or another identity-matched actual page may resolve gaps. Do not rely on search snippets or old workbook prices. Use the lowest currently advertised monthly **BASE rent for an actual matching whole-unit bedroom type**, excluding concessions, estimates, fees, per-person/student rates and bedroom proxies. Numeric availability schedules do not guarantee immediate vacancy. Every requested field needs a freshly verified amount, `Phone Verify`, or explicitly evidence-supported `Not Offered`. Missing availability or blocked pages are not proof of Not Offered.

Save the structured workflow result as `$RUN_DIR/research-original.json`, keeping its run/date/checksum envelope. Preserve successful work. Recover only failed/incomplete properties; every declared row and bedroom must be returned. Even a completely unresolved property must have complete Phone Verify observations and truthful attempted-source/identity context, not an empty comp array. Never invent a fetch, quotation, price, phone call or eligibility claim.

## Validate and conservatively review

Run `integrate_results.py` against the canonical manifest and completed workflow result. It accepts only exact canonical IDs or declared sheet aliases and reports missing/extra row/bedroom identities without inventing observations:

```bash
python3 integrate_results.py --manifest "$RUN_DIR/extract/manifest.json" --results "$RUN_DIR/research-complete.json" --output "$RUN_DIR/observations-canonical.json"
```

For a run without failures, `research-complete.json` can be an unchanged copy of `research-original.json`. When recovering results, save a separate complete file and preserve the original. Do not weaken the full-coverage gate to build a partial portfolio.

Review concrete eligibility and price-evidence conflicts. Unverified/ineligible comps may only become Phone Verify; Not Offered and numeric amounts on those rows are not admitted. Individual houses/duplexes or other thin-market supplements remain excluded unless the user has explicitly approved their comparability. Estimated amounts and uncertain BASE/total-price semantics are Phone Verify. Do not turn “no restriction found” into affirmative eligibility evidence or silently add replacement comps.

Use `apply_review.py` with explicit reviewer decisions when an exclusion is needed. Comp decisions contain buildingId, row, eligibility `unverified`/`ineligible`, and reason. Cell decisions contain buildingId, row, bedType, status `phone_verify`, and reason. The script can only exclude questionable observations; it cannot invent/promote prices. It preserves original source findings in a separate review audit. Save an empty decision list if no exclusions apply.

```bash
python3 apply_review.py --observations "$RUN_DIR/observations-canonical.json" --decisions "$RUN_DIR/reviewer-decisions.json" --output "$RUN_DIR/observations-reviewed.json"
python3 pipeline.py build --workbook "$BASELINE" --manifest "$RUN_DIR/extract/manifest.json" --observations "$RUN_DIR/observations-reviewed.json" --output-dir "$RUN_DIR/output"
python3 verify_report.py --baseline "$BASELINE" --manifest "$RUN_DIR/extract/manifest.json" --build-dir "$RUN_DIR/output"
python3 render_review_checklist.py --audit "$RUN_DIR/output/audit.json" --output "$RUN_DIR/review-checklist.md"
manus-md-to-pdf "$RUN_DIR/review-checklist.md" "$RUN_DIR/review-checklist.pdf"
```

Do not use `--test-mode` for an actual emailed report. It is exclusively synthetic structural proof. The real build fails closed on missing/stale/unsupported observations, wrong checksums, unsafe writes and completely zero-numeric research. Review coverage warnings; a successful report can still have substantial Phone Verify gaps and is not all-rents-verified.

The workbook updater preserves original formatting, subject/affordable data and unapproved cell values. It updates only market Actual rents/evidence and permitted Market Average benchmarks/labeled visible summaries. Averages use current accepted numeric rents only; no numeric coverage means Phone Verify. Duplicates are flagged, not silently removed, and averages remain row-weighted. Unlabeled orphan summaries remain historical baseline and must not be characterized as fresh.

Verify that the output workbook and PDF exist and include every property. Inspect PDF readability and market-average dollar amounts; review all missing-coverage/eligibility warnings. Original Difference/recommendation formula caches are preserved and can be stale or error when averages are Phone Verify. Disclose that users must open and recalculate/review in Excel before pricing decisions. Preserve the input unchanged and do not promote the research draft as approved master data.

## Email and receipt

Verify the active Gmail address is **apartmentcorp44@gmail.com** before sending. Never fall back to another account. Use the current Gmail send tool and any required Send confirmation. Subject: `ApartmentCorp Rent Comps — Monthly Fresh Refresh [Month YYYY]` or `TEST — ApartmentCorp Rent Comps — Monthly Fresh Refresh [Month YYYY]` for an explicitly requested test. Attach the dated validated Excel workbook and complete checklist PDF; optionally include a compact audit ZIP retaining source evidence/review exclusions/change log. Summarize verified, Phone Verify and Not Offered counts, uncovered property/bedroom groups, historical subject-data age and the Excel recalculation caveat. Do not email only an old workbook or portray uncertain data as fully verified.

Normal recipients are exactly Ethan and Marc at the addresses above. Tests go only to Ethan. Search Sent afterward and verify actual sender, recipients, subject and attachments. Save the message ID and report-file checksums in a run-specific delivery receipt. Gmail acceptance or a sent copy does not guarantee inbox delivery. On ambiguous failure, inspect Sent before retrying to avoid duplicate emails.

If source approval, research, workflow approval, validation, account binding or sending fails, preserve successful artifacts and state the exact blocker in Manus. Do not claim recurring activation or delivery from local-file edits alone. Schedule `ask_user` execution, workflow budget and Gmail Send approvals are separate platform gates; do not promise fully unattended delivery unless the owner has explicitly configured and verified those settings.
