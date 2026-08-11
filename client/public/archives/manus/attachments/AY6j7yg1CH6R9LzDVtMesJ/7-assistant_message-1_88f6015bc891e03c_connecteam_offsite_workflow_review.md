# Connecteam Off-Site-Time Workflow Review

## User objective
Produce an auditable per-day report for employee **Sandra Crump** covering **2026-01-01 through 2026-08-10**, identifying time spent clocked in but outside all configured Connecteam geofences. The report must show the daily clocked-in span(s), each validated off-site interval, total off-site time per day, and a period total.

## What the provided transcript establishes
The initial manual workflow locates an employee in **Time Clock > Map**, inspects an example day (2026-06-11), treats white tracking dots outside green geofence circles as off-site, and requires totals across the entire period. The prior proposed solution claims a Connecteam Breadcrumbs API offers coordinates and geofence enter/exit events, with a browser/network-capture fallback.

## Preliminary audit findings
1. The objective is feasible only with verified authorized access to the employer’s Connecteam data and must respect employee-location data governance.
2. A raw coordinate stream and the actual geofence definitions are both necessary; a map screenshot or visual dot counting is not sufficient for an auditable calculation.
3. An API-first method is preferred if the API is available to the account and exposes the required historical GPS/breadcrumb and shift data. This must be confirmed against current official documentation and the user’s plan/permissions.
4. The calculation needs explicit policies for tracking cadence, GPS gaps, clocked-out intervals, manual location events, geofence overlap, boundary accuracy, and timestamp/time-zone treatment. A simplistic fixed 300-second return-to-site assumption is not defensible unless it matches documented tracking cadence and is disclosed.
5. Browser use can be a fallback for export or authorized data retrieval, but should not depend on fragile visual interpretation. Any network-derived data must be validated against visible shift and geofence records.

## Next step
Verify current official Connecteam API and data-export options, then define an auditable interval-classification method before requesting the minimum authorized access needed to run the report.

## Data-access status
No Connecteam credentials, API key, export, or authenticated browser session have been supplied in this conversation.

## Scope caveat
The endpoint name, eligibility, payload shape, and access-plan assertion made in the transcript have not yet been independently verified.

## Internal classification
The task requires a phased approach: research and validation, calculation design, authorized data acquisition, and delivery.

## Verified official API findings (reviewed 2026-08-10)

### API eligibility and authorization
Connecteam’s official API-access guide states that API access requires an Expert plan or higher, and that Time Clock endpoints belong to the Operations hub. Authentication may use a secret API key in the `X-API-KEY` header or OAuth 2.0; the Breadcrumbs guide specifically requires the `time_clock.read` OAuth scope. No Connecteam connector is currently configured in this session.

### Breadcrumbs endpoint
The prior proposal correctly identified an API-first route, but it omitted significant operating details. `POST /time-clock/breadcrumbs/v1/report` accepts **one company-timezone calendar date at a time** and initiates an asynchronous report. The client must poll `GET /time-clock/breadcrumbs/v1/report/{fileId}` until completed, then make an authenticated `GET /time-clock/breadcrumbs/v1/report/{fileId}/download` request. The downloaded JSON contains records grouped by `timeActivityId`, `userId`, and `timeClockId` and includes chronological `motion`, `geoFence` ENTER/EXIT, and `providerChange` events. GPS payloads include latitude, longitude, recorded timestamp, received timestamp, and accuracy where available.

### Important data limitations
Only shifts with breadcrumb data appear in a Breadcrumbs file; activity without tracks is omitted. The export is company-wide for one date, so the processor must filter to Sandra’s Connecteam user ID after downloading. Connecteam requires Breadcrumbs to have been enabled in Time Clock settings before export. Its documentation says task metadata is retained approximately two hours and generated report files are tagged with a one-day TTL, so the job must poll and save each completed daily JSON promptly. There is no multi-day range request: 222 daily dates are required for 2026-01-01 through 2026-08-10 inclusive.

### Geofence data
`GET /time-clock/v1/time-clocks/{timeClockId}/geofences` returns the fence ID, enabled status, center latitude/longitude, radius in meters (`fenceSize`), optional job association, and configured exit action. Geofences are scoped to time clocks, so each relevant time clock must be retrieved (including archived clocks when historical activities could exist) and joined by `timeClockId`.

### Assessment of the earlier solution
The earlier API-first recommendation is directionally correct. It is incomplete if it relies on `geoFence` events alone or treats arbitrary fixed time gaps as definite off-site time. A defensible report must join shift time activities, geofence snapshots, raw breadcrumb locations, GPS accuracy, device-provider status, and explicit uncertainty rules. Browser/network capture remains a last-resort retrieval fallback, not an equivalent audit mechanism, because it may be undocumented, session-fragile, and incomplete for historical bulk extraction.

## Sources
1. https://developer.connecteam.com/docs/api-access
2. https://developer.connecteam.com/docs/time-clock-breadcrumbs
3. https://developer.connecteam.com/docs/time-clock-geofences
4. https://developer.connecteam.com/docs/time-clock-getting-time-clocks
5. https://developer.connecteam.com/docs/authentication-1

### Shift and employee matching requirements
The Time Activities endpoint retrieves `shift`, `manual_break`, and `time_off` activities for a time clock, supports a user-ID filter, and identifies each shift by the same `id` that Breadcrumbs exports as `timeActivityId`. It provides exact start/end Unix timestamps, time zone, source, job/sub-job, and auto-clock-out status. Its maximum date range is 92 days, so the full study period must be requested in at least three windows. The Users endpoint can resolve the exact Connecteam `userId` for Sandra Crump; name matching must be performed once and confirmed before any records are filtered.

### Implication for a defensible total
The authoritative working interval is the completed shift record, not the visual map alone. Breadcrumb events must be clipped to each shift’s `[start, end]` time range and linked to the matching `timeActivityId`. Manual-break records must be addressed explicitly: the default report should exclude time outside a work shift and identify any paid/unpaid breaks according to a user-approved policy, rather than treating all clocked time as work time. The timesheet endpoint provides a secondary consistency check of daily totals but cannot replace shift-level review; it has a 45-day maximum request range and aggregates paid/unpaid-break treatment.
