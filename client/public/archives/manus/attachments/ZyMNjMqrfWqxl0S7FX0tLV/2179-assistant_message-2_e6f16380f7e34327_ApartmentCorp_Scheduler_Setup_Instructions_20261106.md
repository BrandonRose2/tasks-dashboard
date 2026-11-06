# Apartment Corp — Exact Scheduler Handoff

## Paste this request into the receiving Manus task

Restore the scheduling for the transferred Vacancy Report application using the attached scheduler bundle and the full `ApartmentCorp_Report_Transfer_20261105.zip`. Work inside the destination’s existing imported app; do not create an extra app or a second daily job. This is configuration for a destination-owned replacement, not permission to change the original source account or to send an immediate test email. If the other task operates the SAME existing project rather than a transferred deployment, reuse the four existing jobs and bindings; do not recreate them. New UIDs are required only for a different destination project/owner.

Use application-owned, server-side HTTP Heartbeat jobs. Do not replace these with scheduled AI-agent tasks, Monday-only scrapes, Railway cron, in-process timers, `setInterval`, or `node-cron`. Preserve the original local times and all existing callback logic, freshness checks, financial calculations, HTML templates, and recipient routing.

### The exact four jobs

| Registered job name | Reports / local schedule | Six-field UTC cron | POST callback path |
| --- | --- | --- | --- |
| `daily-vacancy-report` | Two separate emails: Daily Vacancy at **10:00 AM Pacific**, Daily Collections at **1:00 PM Pacific**, daily | `0 0 17,18,20,21 * * *` | `/api/scheduled/daily-vacancy` |
| `weekly-vacancy` | Weekly Vacancy Summary, **Saturday 9:00 AM Eastern** | `0 0 13,14 * * 6` | `/api/scheduled/weekly-vacancy` |
| `eviction-reminders` | Missing-amount reminders, **1st and 15th at 9:00 AM Eastern** | `0 0 13,14 1,15 * *` | `/api/scheduled/eviction-reminders` |
| `monthly-net-cash-flow` | Monthly Net Cash Flow, **12th at 1:00 PM Pacific**, for the previous completed calendar month | `0 0 20,21 12 * *` | `/api/scheduled/monthly-net-cash-flow` |

Cron fields are **seconds, minutes, hours, day of month, month, day of week**. These expressions are UTC candidate times, not multiple intended sends. The accompanying application policies use `America/Los_Angeles` or `America/New_York` to select only the appropriate daylight-saving/local-time slot. Off-time candidates must return without fetching or sending. Do not remove the timezone gates or substitute a fixed UTC offset. All callbacks use POST; the body can be `{}`. Dates, recipients, and business-row identity must not be controlled by the callback body.

### Sender and recipient requirements

Use only the configured Gmail SMTP relay, with From `"Apartment Corp Reports" <apartmentcorp44@gmail.com>` and Reply-To `ethan@apartmentcorp.com`. Obtain credentials from the authorized private encrypted archive in the transfer package, never from public code or a prompt. Destination-owned Manus app keys, owner identity, database connection, and cron authentication must be provisioned in the destination; source platform identity is not transferable authorization.

Daily Vacancy and Daily Collections each send to `ethan@apartmentcorp.com` and `mam@22.bz` only. Monthly uses the same two recipients, in that order. Weekly retains the exported active weekly list with Brandon replaced by Ethan: `ethan@apartmentcorp.com`, `mam@22.bz`, `Myles@menowitz.com`, and `Todd@menowitz.com`. Preserve the actual exported active-recipient configuration and scoped deduplication. Eviction messages keep their property-manager To and mapped regional/Ethan/Marc CC from `server/evictionReminderContacts.ts` and `server/scopedReportRecipients.ts`; do not turn these into one generic mass email or alter the body signature.

### Prepare the destination before registering anything

Restore the full application and review the private database snapshot. Preserve job IDs, relationships, historical runs, frozen message plans, and duplicate-send ledgers. Never reset `sent`, `sending`, or `unknown` to force a retry. Import destination schedule rows as disabled and unbound, not as active source-account rows. Use the private export’s `database/schedule-rows-disabled-for-destination.json` as reviewed preparation data. The bundle’s `scheduler-source/` files are reference copies, not a standalone runnable application.

Ensure the deployed destination contains these mounted handlers before the SPA fallback:

- `/api/scheduled/daily-vacancy` — `server/dailyVacancyScheduled.ts`.
- `/api/scheduled/weekly-vacancy` and `/api/scheduled/eviction-reminders` — `server/auxiliaryEmailScheduled.ts`.
- `/api/scheduled/monthly-net-cash-flow` — `server/monthlyEmailScheduled.ts`.

Each handler must authenticate through `sdk.authenticateRequest(req)`, require `user.isCron` and `user.taskUid`, and look up the matching durable business row by that NEW task UID. Retain the two-minute-safe execution behavior, CAS claims, immutable plans, and fail-closed ambiguous SMTP handling. Verify the deployed routes reject unauthorized POSTs with controlled JSON rather than falling through to an HTML page.

Run tests, TypeScript, and production build. Save a checkpoint and obtain destination publication confirmation before any registration. Update all public dashboard links and account-dependent assets for the destination. Previews are permitted, but no email test is authorized by this instruction; obtain a named recipient and explicit permission before any test send.

### Register four destination-owned jobs, not copies of source identities

Read the destination’s current `manus-heartbeat create --help`, `update --help`, and `list` output first. Check for matching jobs already registered in that destination; reuse exact matches rather than create duplicates. Never run registration from the source project’s environment.

The verified creation interface does **not** expose an `--enable=false` flag. Keep the destination business rows disabled/unbound during creation so callbacks cannot send; then pause each newly created platform job immediately using the current documented update/pause interface. `enable: false` in `schedulers.json` is the desired preparation state, not a CLI creation flag. If a future SDK supports creating disabled jobs, use that documented capability.

For new registrations only, these are the exact creation commands for the **destination task’s execution environment**, to be run by the receiving agent after the prerequisites above. The human recipient need not run them:

```bash
manus-heartbeat create --name daily-vacancy-report --cron '0 0 17,18,20,21 * * *' --path /api/scheduled/daily-vacancy --method POST --payload '{}' --description 'Daily Vacancy 10 AM Pacific; separate Daily Collections 1 PM Pacific; one job, DST-gated, durable per-report ledger.'

manus-heartbeat create --name weekly-vacancy --cron '0 0 13,14 * * 6' --path /api/scheduled/weekly-vacancy --method POST --payload '{}' --description 'Weekly Vacancy Summary Saturday 9 AM America/New_York; DST-gated, frozen plan, duplicate protection.'

manus-heartbeat create --name eviction-reminders --cron '0 0 13,14 1,15 * *' --path /api/scheduled/eviction-reminders --method POST --payload '{}' --description 'Eviction missing-amount reminders 1st/15th 9 AM America/New_York; existing manager/regional routing; durable per-manager protection.'

manus-heartbeat create --name monthly-net-cash-flow --cron '0 0 20,21 12 * *' --path /api/scheduled/monthly-net-cash-flow --method POST --payload '{}' --description 'Monthly Net Cash Flow 12th 1 PM America/Los_Angeles; previous completed month; Ethan and Marc; durable reporting-period protection.'
```

Record each returned NEW `task_uid` and pause that new platform job before proceeding. The source IDs in `source-job-reference.json` are audit references only: do not reuse them or pause/update/delete them from the destination.

### Binding and activation details that must not be skipped

| Job | Destination business-row binding | Existing helpers / cautions |
| --- | --- | --- |
| Daily shared | `daily_vacancy_jobs`, `schedule_key = daily-vacancy`, `schedule_cron_task_uid = NEW daily UID` | `ensureDailyVacancyJob()` provisions missing rows only. `activateDailyVacancyJob(newUid)` binds AND enables the business row, so call only at the approved cutover while the platform job is still paused. Explicitly restore approved `collections_approved = true` through the reviewed approval path; otherwise Collections does not send. `confirmDailyReportsDelivery(newUid)` enables both and updates activation boundaries; do not call it on every startup or scheduled run. |
| Weekly | `auxiliary_email_jobs`, `report_type = weekly_vacancy`, `schedule_key = weekly-vacancy` | `ensureAuxiliaryEmailJobsDisabled()`, then `bindAuxiliaryEmailJobTaskUid('weekly_vacancy', newUid)`. At cutover, `activateAuxiliaryEmailJobByTaskUid(newUid)`. |
| Eviction | `auxiliary_email_jobs`, `report_type = eviction_reminders`, `schedule_key = eviction-reminders` | `ensureAuxiliaryEmailJobsDisabled()`, then `bindAuxiliaryEmailJobTaskUid('eviction_reminders', newUid)`. At cutover, `activateAuxiliaryEmailJobByTaskUid(newUid)`. |
| Monthly | `monthly_email_jobs`, `schedule_key = monthly-net-cash-flow` | `provisionMonthlyEmailJob()`, then `bindMonthlyEmailHeartbeat(jobId, newUid)`. At cutover, `activateMonthlyEmailJob(jobId, new Date())`. Keep the explicit JSON casts in recipient equality checks; they are required for correct MySQL/TiDB binding. |

Review actual helper definitions rather than assuming provisioning resets imported rows: it does not. Existing source-bound or activated rows require a deliberate destination-only migration and no history deletion. Do not copy past activation timestamps as a new-account start boundary without review.

### Cut over only with separate approval

Until approved, the original four jobs remain running and every destination platform job/business row remains paused or disabled. For the cutover, confirm old senders are stopped, reconcile in-flight/uncertain sends, capture a final fresh snapshot, and update the destination’s preserved ledgers. Then bind/activate the destination business rows and enable its four platform jobs. Do not run both production systems at once. Do not trigger Run Now or backfill on activation.

Finally read back the four destination job names, crons, callback paths, enabled flags, NEW UID bindings, local time policies, recipients, daily Collections approval, and first eligible send dates. Report precisely what is prepared versus activated. A cron-only import is not proof that authentication, live source data, SMTP, or destination delivery works.

## Bundle contents and verification

`schedulers.json` contains portable registration settings and intended disabled state. `source-job-reference.json` contains source UIDs and enabled state for audit only. `scheduler-source/` contains byte-identical policy, callback, storage, and test references from the existing app. `manifest.json` records source-file hashes. The full transfer ZIP is required for schema, auth SDK, source fetching, email rendering, recipient mapping, database data, and credentials.

Export prepared November 5 Pacific / November 6 UTC, 2026. Preparing these files creates no new jobs, changes no live schedules, sends no emails, and performs no cutover.
