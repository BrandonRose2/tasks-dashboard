# Auditable Connecteam Off-Site-Time Reporting Protocol

**Prepared by Manus AI**  
**Scope:** Sandra Crump; 2026-01-01 through 2026-08-10, inclusive

## Executive assessment

**Yes—the task can be done more reliably than the earlier response proposed.** The earlier recommendation to use the Breadcrumbs API instead of visually counting map dots is correct. However, it is incomplete as a reporting method because it does not establish an evidence-preserving extraction process, an exact definition of “off-site,” a defensible way to handle GPS uncertainty and data gaps, or a reconciliation to the employee’s actual clocked-in shifts.

The recommended solution is an **API-first, read-only, reproducible pipeline**. It would obtain the exact Connecteam user ID for Sandra Crump, retrieve the relevant time clocks and their geofences, download each daily Breadcrumbs export, retrieve the matching shift records, calculate intervals by combining raw motion coordinates with explicit geofence-enter/exit events, and produce a reviewable daily report. The final report must label tracked, inferred, and unobservable periods separately rather than presenting every gap as proven off-site time.

> **Key distinction:** A breadcrumb outside a geofence proves that the recorded location was outside at that timestamp. It does **not** by itself prove the employee was outside for the entire interval until the next record. The report must treat the interval between observations as evidence with a stated confidence rule, not as an unstated assumption.

## Why this approach is better

| Area | Earlier proposal | Improved protocol |
|---|---|---|
| Data collection | Correctly prefers API over map clicks. | Uses a checkpointed, idempotent daily extraction job that archives original JSON and request metadata. |
| Scope matching | Mentions GPS and geofence events. | Resolves Sandra’s immutable user ID, joins records by `timeActivityId`, `userId`, and `timeClockId`, and clips all calculations to each completed shift. |
| Geofence logic | Suggests Haversine calculation and a 300-second example. | Uses the actual enabled geofence radius, explicit ENTER/EXIT events, coordinate-derived distance, GPS accuracy, overlap rules, and a documented ambiguity band. No unsupported fixed five-minute assumption. |
| Data gaps | Not addressed adequately. | Separates verified off-site, inferred off-site, unknown/unobservable, and in-site time. It never silently converts a missing GPS interval into off-site time. |
| Audit trail | Skill package claimed validation, but no specified evidence package. | Preserves raw daily source files, geofence snapshots, shift inputs, hash manifest, calculation version, flags, and reconciliation checks. |
| Browser fallback | Proposes network capture as an equivalent fallback. | Treats browser use only as a controlled export/access fallback. It does not depend on undocumented network calls or map interpretation for the audit calculation. |

## Verified Connecteam data model

Connecteam’s official Breadcrumbs interface exports **one company-timezone date at a time** through an asynchronous three-step job: create a report, poll its status, and download JSON. Each result is grouped by time activity and user, and includes ordered `motion`, `geoFence` ENTER/EXIT, and `providerChange` events. Motion events contain device-recorded timestamps and GPS data, including latitude, longitude, speed, and accuracy when supplied. Only activities that contain breadcrumbs are included in the output.[1]

Geofences are retrieved for each time clock and include the fence ID, enabled status, center coordinates, radius in meters, optional job association, and exit action. Time clocks, including archived ones, can be enumerated; historical time activities can still be retrieved from archived time clocks. Shift records provide the matching shift identifier, start and end timestamps, source, time zone, and auto-clock-out status. The matching key is explicit: Breadcrumbs calls it `timeActivityId`, while Time Activities calls the same shift key `id`.[2] [3] [4]

The API requires an eligible Connecteam plan and Time Clock API access. It supports either an `X-API-KEY` credential or OAuth with `time_clock.read`; credentials must be handled as secrets and never embedded in the report or spreadsheet.[5] [6]

## Required reporting policy

Before calculation, the organization should approve the following policy. I can apply the defaults below, but final values should be confirmed by the responsible manager or HR/legal reviewer before results are used for pay, discipline, or any employment decision.

| Policy element | Recommended default | Reason |
|---|---|---|
| Reporting clock | Account/company timezone; display the shift’s supplied timezone. | Breadcrumb exports are requested by company-timezone calendar date.[1] |
| Scope | Time spent inside completed work shifts only; exclude time before clock-in and after clock-out. | Avoids treating personal time as work time. |
| Daily allocation | Split any overnight shift at local midnight and allocate seconds to each report date. | Gives a true daily total for the requested period. |
| Geofence set | All **enabled** fences belonging to the shift’s time clock, unless a documented job-specific fence rule applies. | Fence definitions are time-clock scoped and may be job-associated.[2] |
| Inside criterion | A coordinate is inside if its distance to any eligible fence center is at or below that fence radius. | Aligns with Connecteam’s circular fence model.[2] |
| GPS accuracy | Classify records in a boundary-uncertainty band as ambiguous: `abs(distance − radius) ≤ reported_accuracy` when accuracy is available. | Prevents overstating precision near the boundary. |
| Event precedence | A `geoFence` ENTER or EXIT event for a known eligible fence overrides coordinate classification at its timestamp; coordinates on either side corroborate it. | Uses the platform’s explicit recorded event while retaining the underlying evidence. |
| Gap handling | Do not classify a long interval from a single endpoint. Mark it **unknown** unless two consecutive reliable points/events support the same state under a documented maximum-gap threshold. | Eliminates the unsupported “300 seconds equals off-site” shortcut. |
| No-data shifts | Show as **GPS data unavailable**, not “on-site” or “off-site.” | Breadcrumb exports omit activities with no breadcrumbs.[1] |
| Employee review | Flag materially adverse or ambiguous intervals for manager/employee review, including source timestamps and map links where permitted. | Supports fair review and data-quality correction. |

## Calculation method

### 1. Define the exact analysis window

Define the study window as `2026-01-01 00:00:00` through `2026-08-10 23:59:59` in the company timezone. Retrieve at least the immediately adjacent calendar dates as a buffer for overnight-shift matching, then clip all results strictly to the study window. The inclusive period contains **222 calendar dates**, so Breadcrumbs requires 222 daily export jobs.[1]

### 2. Acquire source data without altering Connecteam

The pipeline is read-only. It first calls `/users/v1/users` to resolve and confirm the unique user record for **Sandra Crump**. It then obtains every time clock, including archived clocks, and captures every applicable geofence definition at the moment of extraction. It retrieves Sandra’s shift activities in up to 92-day windows because the Time Activities API caps a single range at 92 days.[3] [4]

For each analysis date, the pipeline requests the Breadcrumbs export, polls until the job is completed, then downloads and retains the original JSON promptly. Connecteam’s documentation says report-task metadata is retained for about two hours and generated files carry a one-day TTL tag. The pipeline must therefore download promptly and save a restart checkpoint after each date.[1]

### 3. Normalize and validate records

For each raw file, the pipeline filters to Sandra’s confirmed user ID and joins every breadcrumb activity to a retrieved shift with the same `timeActivityId` and `timeClockId`. It discards events outside the shift interval while retaining them in the raw archive. It verifies the timestamp order, rejects impossible coordinates, records device-versus-server timestamp lag, and identifies `providerChange` periods in which GPS, location services, or network were disabled.[1]

A shift is split at every relevant timestamp: its start/end, every breadcrumb event, every ENTER/EXIT event, midnight boundaries, manual-break boundaries if they are to be excluded, and every transition in data-quality state. This produces small, non-overlapping candidate intervals.

### 4. Classify each candidate interval

For a motion point, calculate great-circle distance to every eligible geofence center. The effective state is **inside** if the point is inside at least one fence; it is **outside** only if it is outside every eligible fence and is not in the accuracy ambiguity band. If two or more fences overlap, inside any eligible fence is on-site.

For every interval between successive timestamps, apply the following hierarchy:

| Evidence condition | Classification | Contribution to off-site total |
|---|---|---|
| Reliable EXIT from all eligible fences followed by reliable outside motion points, then a later ENTER | Verified off-site | Count the interval from the exit event through the subsequent enter event, bounded by the shift and study window. |
| Consecutive reliable outside motion points with no contradicted ENTER event and an interval no longer than the approved maximum gap | Inferred off-site | Count separately and disclose as inferred, not verified. |
| Reliable outside point followed or preceded by an accuracy ambiguity, provider-disabled state, or a long gap | Unknown / review needed | Do not add to the definitive off-site total. Track it in a separate uncertainty column. |
| Inside point or valid ENTER event | On-site | Do not count as off-site. |
| No breadcrumb data for the shift | Unobservable | Do not classify as on-site or off-site. |

The report should show both **Verified Off-Site Time** and **Inferred Off-Site Time**, with a **Strict Total** containing verified time only and a **Review Total** containing verified plus inferred time. Unknown time is never included automatically. This is more credible than a single total that mixes measured, inferred, and unobserved periods.

### 5. Reconcile and quality-control

The pipeline checks that, for every daily shift segment, the sum of on-site, verified off-site, inferred off-site, unknown, and excluded-break time equals the shift duration after the chosen exclusions. It reconciles shift hours to Time Activities and optionally cross-checks day totals against the Timesheet endpoint, which already accounts for automated unpaid breaks but has a 45-day request maximum.[3] [7]

It also flags these conditions for human review: missing shift end, duplicate activities, unmatched breadcrumb activity, disabled or changed geofence configuration, GPS disabled, unusually sparse sampling, boundary-only results, clock punches with an administrative or desktop source, and intervals that materially affect the result.

## Deliverables after authorized access is provided

The final evidence package will contain the following files. Location data is sensitive; the raw archive should be access-controlled and retained only for the authorized period.

| File | Purpose |
|---|---|
| `sandra_crump_offsite_daily_report.xlsx` | A manager-readable daily summary with shift spans, verified/inferred/unknown minutes, total time, and review flags. |
| `sandra_crump_offsite_intervals.csv` | One row per classified interval with start/end, duration, classification, evidence, time clock, geofence/event IDs, and confidence flags. |
| `sandra_crump_offsite_methodology.md` | The calculation policy, assumptions, formulae, source period, and reproducibility instructions. |
| `source_manifest.csv` | File names, source date, request IDs, SHA-256 hashes, extraction timestamps, and API status. |
| `raw/` (restricted) | Unmodified daily Breadcrumb JSON, time-clock/geofence snapshots, and shift responses. |
| `exceptions.csv` | Missing tracks, ambiguity bands, provider-disabled periods, reconciliation differences, and unmatched records. |

The daily spreadsheet will include: date; time clock; shift start/end; paid/work duration; verified off-site duration; inferred off-site duration; unknown location duration; strict total; review total; number of exits/entries; and a concise flag summary. It will not expose more raw route history than needed in the manager-facing sheet.

## Access needed to run the report

The preferred route is a **new, read-only Connecteam API key** restricted as tightly as Connecteam permits, or OAuth authorized with `time_clock.read`. The account must have Time Clock API access and Breadcrumbs must already have been enabled for the relevant historical shifts. A Connecteam administrator can create an API key under **Settings → API Keys**.[5] [6]

If no API access exists, I can evaluate an authorized, authenticated browser export workflow. I will not make hidden-network capture the primary evidence source, and I will clearly label any browser-only limitation. If historical Breadcrumbs were not enabled, a precise retrospective GPS total cannot be reconstructed; the output would instead be a limited report based only on the records the account can lawfully export.

## References

[1]: https://developer.connecteam.com/docs/time-clock-breadcrumbs "Connecteam Developer Documentation — Breadcrumbs"
[2]: https://developer.connecteam.com/docs/time-clock-geofences "Connecteam Developer Documentation — Geofences"
[3]: https://developer.connecteam.com/docs/time-clock-time-activities "Connecteam Developer Documentation — Time Activities"
[4]: https://developer.connecteam.com/docs/time-clock-getting-time-clocks "Connecteam Developer Documentation — Getting Time Clocks"
[5]: https://developer.connecteam.com/docs/api-access "Connecteam Developer Documentation — API Access"
[6]: https://developer.connecteam.com/docs/authentication-1 "Connecteam Developer Documentation — Authentication"
[7]: https://developer.connecteam.com/docs/time-clock-timesheet "Connecteam Developer Documentation — Timesheet Totals"
[8]: https://developer.connecteam.com/docs/rate-limiting-1 "Connecteam Developer Documentation — Rate Limiting"
