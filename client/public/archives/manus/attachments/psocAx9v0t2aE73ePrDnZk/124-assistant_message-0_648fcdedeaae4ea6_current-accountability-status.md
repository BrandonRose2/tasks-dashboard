# Lead Command — Current Accountability Status

## Snapshot

The existing **Live CRM Command** and **Daily Digest** are operating from a secure, server-side, read-only CRM connection. The new **Quick Find** search bar and Daily Digest **property selector** are implemented in the development preview and have passed type checks and automated tests; they are awaiting the next published checkpoint.

| Workstream | Current state | What it delivers now | Remaining dependency |
|---|---|---|---|
| Live CRM dashboard | Live and connected | Current lead-response risk, stale activity, inbox pressure, staffing context, note-author evidence, and last-responder evidence. | The interactive snapshot intentionally represents the newest CRM sample, not the full historic database. |
| Quick Find search | Implemented in development | Filters loaded lead names, properties, stages, inbox contacts, staffing names, latest note authors, and latest responders. It does not search note or message bodies. | Publish the next checkpoint after final interaction validation. |
| Daily Digest property filter | Implemented in development | Filters the live CRM exception digest to one selected property while leaving the manual Lead Command digest visible. | Publish the next checkpoint after final interaction validation. |
| Verified call completion | Deferred | No verified phone-call claim is currently shown; the dashboard accurately uses documented CRM activity. | ConnectUC administrator/API or export access, when you choose to proceed. |
| Durable inbox ownership | Not available from CRM | The dashboard shows last responder only when source evidence supports it and never treats it as permanent ownership. | A CRM conversation-owner field or supported write endpoint. |
| Scheduled supervisor digest | Not yet implemented | The in-app Daily Digest is available on demand. | Confirm delivery channel and schedule details before a production heartbeat job is created. |

## Validated search and filter behavior

The live Quick Find control was exercised against the current CRM snapshot. Searching **Ashley Patterson** narrowed the Follow-up watch from three records to one matching record and showed targeted empty states for unrelated inbox, property, and staffing sections. The Daily Digest property selector renders the full active-property list and uses a tested property-group filter helper; browser automation could not programmatically set the native select control, but the UI wiring, helper tests, desktop rendering, and type checks are complete.

## Scheduling decision still needed

Before creating scheduled digests, we need to confirm the intended destination. The recommended default is two **in-app refreshes with an owner notification**: once at the start of the operating day and once before close. If you instead want email, SMS, Slack, or a specific report recipient list, the scheduled workflow needs the appropriate approved delivery integration and recipients.
