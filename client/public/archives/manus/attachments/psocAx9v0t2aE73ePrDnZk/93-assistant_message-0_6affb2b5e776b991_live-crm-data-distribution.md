# Lead Command — Live CRM Data Distribution

## Executive summary

The **Live CRM Command** page is a supervisor-only, **read-only** control view layered on top of Apartment Corp’s CRM. It does not replace the CRM, edit a lead, send a message, or claim that a manager made a telephone call when the source system only provides documented CRM activity. Its purpose is to bring the most time-sensitive signals—new leads without a documented touch, active leads that have gone stale, inbox threads that are quiet, building coverage, and available evidence of team activity—into one operating screen.

The data is pulled from the CRM on the server, normalized into a small operational model, and then sent to the browser only as the fields needed to manage follow-up. The API credential never reaches the browser.

> **Important interpretation rule:** the portal measures **documented CRM touch activity** and inbox activity. It does not currently receive a separate phone-system call log, so it cannot verify that a phone call occurred unless the CRM activity itself provides that evidence.

## 1. Source systems and read-only permissions

The live layer uses the Apartment Corp CRM API at `https://aptcorp.netlify.app/api/v1`. The credential is bound to the Apartment Corp organization, limited to **120 requests per minute**, and has no write capability.

| CRM data area | Read-only use in Lead Command | Exposed in the portal |
|---|---|---|
| Leads | Determines stage, received date, latest activity, source, score, property, and documented-note count. | Lead name, property, stage, wait time, exception signal, source-level context. |
| Buildings | Supplies property name and timezone. | Property cards and business-hours calculations. |
| People | Matches visible note authors and message senders to known CRM people when possible. | A person’s displayed name only when source attribution is available. |
| Building staffing | Identifies managers and chatters assigned to a property. | Property coverage card and team-coverage context. |
| Conversations | Identifies channel, status, message timing, inbound count, contact name, and property. | Inbox-pressure panel and open-thread indicators. |
| Lead notes | Supplies visible author and timestamp for the newest reviewed note. | “Latest CRM note by …” evidence; note text is not displayed or retained. |
| Conversation messages | Supplies direction, sender ID, and timestamp for the newest reviewed message. | “Last CRM responder” only when the latest message is outbound and sender identity matches a CRM person. |
| Audit log | Provides recent documented operational events. | Aggregate documented-action count and team-activity context. |

The page does **not** retain phone numbers, email addresses, note text, or message text. It displays names only where that is necessary to make the exception queue actionable.

## 2. How the server creates the live supervisor snapshot

The first snapshot is intentionally split into a **fast command view** and slower supporting evidence. This keeps the page usable even when the CRM needs extra time to return every building’s staffing detail.

| Snapshot layer | CRM calls | What it creates | Why it is separated |
|---|---|---|---|
| Fast command snapshot | Buildings, newest 200 leads, newest 200 conversations, recent audit events. | Top cards, lead exception list, inbox-pressure list, property signal counts. | This is the information a supervisor needs first. |
| Staffing coverage | Buildings, people, audit events, and staffing for each building. | Manager and chatter names on property cards; property-to-team context. | This can require one extra CRM lookup per building, so it loads independently. |
| Attention attribution | People plus notes for up to 12 lead exceptions and messages for up to 16 inbox exceptions. | Latest note author and last outbound responder where source evidence supports it. | It is evidence enrichment, not a reason to block the main command screen. |

The server keeps a short-lived **two-minute snapshot cache**. Reopening the page normally uses that current snapshot instead of forcing the browser to wait for every CRM call again. The **Refresh live data** button intentionally bypasses the cache and asks for a fresh snapshot.

## 3. Lead calculations and exception classification

The server translates CRM leads into a small operating record containing property, stage, received time, latest CRM activity time, documented-note count, source, score, and calculated business-hours wait time.

| Portal signal | Source fields | Rule applied | Management meaning |
|---|---|---|---|
| **Unworked new lead** | CRM `stage`, `applied_at` / `created_at`, `last_activity_at`. | The lead is `new`, has no latest CRM activity, and has exceeded four business hours. | No documented first touch is visible in the CRM. |
| **Stale active lead** | CRM `stage`, `last_activity_at`. | The lead is active, not new, not final, and has exceeded 24 business hours without activity. | The follow-up cadence appears stalled. |
| **Clear property** | Aggregated lead and inbox signals by building. | No current sampled first-touch, stale-follow-up, or inbox-attention signal. | No immediate exception appears in the current live sample. |

The business-hours policy is calculated in the property’s CRM timezone using the operating schedule of **Monday through Friday, 9:00 AM–5:00 PM**. Weekends and off-hours do not count toward the four-hour first-touch or 24-hour stale-follow-up thresholds.

## 4. Inbox calculations and last-responder evidence

The inbox view is deliberately framed as **inbox pressure**, not a final judgment of who owns a conversation.

| Portal signal | Source fields | Rule applied | What it proves | What it does not prove |
|---|---|---|---|---|
| Open inbox thread | Conversation `status`. | Status is not closed, archived, or resolved. | The thread remains open in the CRM. | Which person has permanent ownership. |
| Inbox attention | Conversation `last_message_at` / `created_at`. | An open thread has been quiet for at least four business hours. | The thread needs review. | That a particular manager failed to respond. |
| Last CRM responder | Latest message `direction`, `sender_user_id`, `created_at`. | Shown only when latest direction is outbound and sender maps to a CRM person. | Who sent the latest attributable outbound CRM message. | That person owns the conversation going forward. |

The CRM provides the last message sender, but not a durable conversation-owner field. The portal therefore never converts “last responder” into “owner.” This is a deliberate guardrail against misattributing responsibility.

## 5. What appears on the Live CRM Command page

| Portal area | Data distributed there | Intended use |
|---|---|---|
| Connection strip | Read-only connection state, snapshot time, and rate limit. | Confirms that the page is live and not using editable CRM access. |
| Coverage banner | Number of lead and conversation records represented versus total available CRM records. | Makes the sampling window visible rather than implying full-history coverage. |
| Four metric cards | Unworked new leads, stale active leads, open inbox threads, documented audit actions. | Rapid operating triage. |
| Follow-up watch | Up to 50 high-priority lead exceptions with property, stage, wait time, last activity, and latest-note author evidence when available. | Manager follow-up review. |
| Inbox pressure panel | Up to 50 quiet open threads, with a compact display of the first six, including channel, property, inbound count, last activity, and last-responder evidence when supported. | Inbox capacity and escalation review. |
| Property teams and live workload signals | One card per active building with current sampled lead/inbox signals and staffing names when the secondary coverage query has returned. | Identifies which property team should receive an escalation. |
| Property staffing and documented CRM activity | Staff assignment context plus available audit evidence. | Context for coaching and coverage—not a verified call-performance score. |

## 6. Sampling and refresh behavior

The CRM currently contains more records than should be fetched in a single interactive page request. To keep the portal responsive, the fast command snapshot uses the CRM’s most recent **200 leads** and **200 conversations**. The portal visibly states the sample count and the total accessible count in the banner.

This means the Live CRM Command page is designed for **current operational triage**, not full historical reporting. If a supervisor needs older records beyond the live sample, they should use the CRM’s own search and history views.

## 7. Access boundaries

| User type | Portal access |
|---|---|
| Supervisor / admin | Can open **Live CRM Command** and see company-wide live CRM monitoring. |
| Property manager / freelance caller | Does not receive the company-wide Live CRM Command route. They continue to see their scoped Lead Command queue and activity tools. |
| CRM API key | Exists only on the server and has read-only permissions. It is never sent to client code or shown in the portal. |

## 8. Current limitations and the correct way to use the page

The live command page should be treated as an **early-warning and coaching tool**. It is strongest at identifying a lead with no documented CRM touch, an active lead with no recent CRM activity, or an inbox thread that needs review.

It is not yet a direct telephone-quality system because the CRM API does not expose a dedicated phone-system call log. It also cannot assign permanent inbox ownership because the CRM does not expose that field. The interface says this explicitly so that managers are not judged based on data the CRM does not actually provide.

If a call provider, call-disposition system, or durable inbox-ownership field is added to the CRM later, the next enhancement can join those records to the existing property/staffing model and create a true per-person call-compliance scorecard.
