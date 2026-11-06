# Activate the repaired ApartmentCorp monthly report

The fresh-rent report engine is repaired and its November 4, 2026 workbook has passed readback validation. The existing recurring schedule has **not** been switched to the repaired engine: its saved instructions still reference missing 42-property HUD/ClickUp scripts. Editing that schedule from this shared task was rejected with “Collaboration sessions are not allowed to modify schedule via manus-config schedule.” Local code and a successful test email cannot resolve or bypass that permission restriction.

## Apply from the schedule owner's account

Open Manus scheduled tasks and edit **ApartmentCorp Monthly Rent Comp Report**, associated with task `9Ap8dG4ztrNsH94FP2Q6UC`. Preserve **the 10th of every month at 8:00 AM, America/Los_Angeles**. Its six-field cron is `0 0 8 10 * *`.

Keep Gmail bound only to **apartmentcorp44@gmail.com**. Regular recipients are **ethan@apartmentcorp.com** and **mam@22.bz**. Do not bind a personal Gmail account or add recipients. Replace the obsolete task instructions and playbook with the complete **MONTHLY_RUN_PLAYBOOK.md** supplied inside **ApartmentCorp_Monthly_RentComps_Recovery.zip**. That playbook researches existing market-rate comps from current public sources, uses the latest approved workbook, validates all requested rent fields and market averages, then emails the dated workbook and review-checklist PDF. It does not sync ClickUp, research subject rent rolls, use HUD limits as market rents, or automatically publish data to SharePoint/API/GitHub.

Upload the delivered **ApartmentCorp_Monthly_RentComps_Recovery.zip** to the Reports project's shared files from the owner's account. Saving shared project files from this collaboration task was also rejected; the bundle is available as a task download, but permanent project storage has not been confirmed. It contains the tested code, requirements, tests, execution playbook, and unchanged approved August baseline. Future runs must first check for a newer approved workbook. An old approved baseline may provide formatting and comp identities, but its prices must not be sent unchanged as new research.

After saving, inspect the schedule to verify its active status, unchanged timezone/cadence, new fresh-rent instructions, and selected Gmail account. The current schedule's mode is **ask_user**, and source-workflow budget and Gmail Send confirmations can still require approval. Do not assume fully unattended research or delivery until those platform execution settings are confirmed. The next scheduled occurrence is November 10, 2026 at 8:00 AM Pacific Time; report completion is later than the trigger time and depends on research and approvals.

If the owner is also blocked, contact [Manus Support](https://help.manus.im) with the task ID and exact permission error. Do not create a duplicate schedule or replace the existing schedule with an ad-hoc background process.

## November repair-test result

The real-source test covers **41 properties, 190 existing market-rate rows and 499 requested rent fields**: **146 source-supported numeric rents**, **297 Phone Verify**, and **56 evidence-supported Not Offered**. Every requested rent field has a value or explicit status. Numeric averages exclude questionable eligibility, house/duplex supplements lacking approved comparability, and estimated prices. The report is a review draft, not all-rents-verified.

The baseline remained unchanged. Formatting and all unapproved cell values were preserved; 234 benchmark/visible-summary tie-outs passed. Subject/affordable/FMR data remain the historical baseline. Open and recalculate in Excel before using unchanged Difference/recommendation formulas, whose preserved caches may be stale or show errors.

The full report test is authorized only for **ethan@apartmentcorp.com**, from **apartmentcorp44@gmail.com**. Its sent-mail verification receipt is stored with the November run after Gmail confirms sending. A Gmail acceptance or sent copy is not an inbox-delivery guarantee.
