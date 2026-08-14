# Lead Follow-up Monitoring — Decision Brief

## What the current CRM can already support

The CRM already contains a strong starting point for a lead-discipline program. It records lead age, property, source, desired move timing, budget, bedroom need, voucher indicator, and pipeline stage. It also has an active manager roster with each manager assigned to one or more buildings. That means we can measure the **lead queue by manager/property** without building a separate personnel list.

However, the current record view does **not visibly capture** the information needed to prove that a manager actually worked a lead: an individual lead owner, assignment timestamp, first-contact timestamp, contact-attempt history, next promised action, and activity audit trail. A dropdown change from **New** to **Contacted** should not be treated as reliable evidence by itself.

## Recommended accountability standard

The goal should be **fast, documented, appropriate follow-up**—not simply high message volume. Every new lead needs a responsible manager, a first meaningful contact attempt, a dated next action, and a clear resolution or active nurture path.

| Measure | Suggested starting standard | What it prevents | Management use |
|---|---:|---|---|
| Lead assignment | Owner assigned immediately from the property-manager mapping | Orphaned leads | Identifies routing failures |
| First response | First documented call, text, or email within 15 minutes during business hours; within 60 minutes during agreed coverage hours | Fresh leads going cold | Primary urgency metric |
| Same-day coverage | 100% of business-hour leads receive a first documented attempt before end of day | Leads left overnight | Daily exception queue |
| New-lead aging | No lead remains **New** beyond 4 business hours without an approved exception | Silent pipeline backlog | Escalation trigger |
| Follow-up cadence | Every active lead has a dated next action; no active lead sits without activity for more than 24 business hours | One-touch-and-forget behavior | Daily manager queue |
| Stage hygiene | Moving a lead to Contacted, Toured, Applied, Lost, or Leased requires an activity/result record; Lost requires a reason | Artificial stage updates | Quality and conversion analysis |
| Conversion | Track New → Contacted → Toured → Applied → Leased by manager and property | Activity without outcomes | Weekly coaching and operating insight |

> The response-time thresholds above are a sensible starting point, not a policy to impose blindly. They should be calibrated to your real leasing-office hours, lead source quality, and staffing coverage.

## Manager scorecard

Each manager should see a simple weekly scorecard with five measures: percentage of assigned leads receiving a timely first response; number of aged uncontacted leads; percentage of active leads with a future next action; stage progression/conversion; and required-exception count. The administrator view should rank neither people nor properties based on raw lead volume alone. It should show **workload, compliance, and outcomes together**, so that a manager with a very high inbound volume is evaluated fairly.

## Escalation design

The escalation system should be supportive and specific. The first notification goes only to the responsible manager, listing the exact lead(s) that need attention. If an item remains unresolved after a short grace period, it goes to the regional supervisor or designated administrator. A daily digest summarizes unresolved exceptions by property; a weekly scorecard is for coaching and performance management, not real-time firefighting.

| Alert level | Trigger | Recipient | Expected action |
|---|---|---|---|
| Reminder | Lead nearing first-response deadline or next action due | Assigned manager | Contact/update and document outcome |
| At-risk | Lead exceeds deadline, or active lead has no next action | Manager and designated supervisor | Resolve, reassign, or record a valid exception |
| Daily exception digest | Any still-open at-risk lead at the end of the operating day | Manager, supervisor, administrator | Review queue and ownership |
| Weekly scorecard | Trend in timely responses, aged leads, stage movement, and conversion | Manager and leadership | Coaching, staffing, and process changes |

## Implementation choices

| Approach | What it does | Tradeoffs | Cost | Setup complexity |
|---|---|---|---|---|
| **Daily operating report** | Produces a once- or twice-daily manager/property exception report from exported CRM data or a read-only feed. | Fastest way to begin; less immediate and more manual than live monitoring. | Low ongoing cost; depends on the export/feed method. | Low to moderate. |
| **Embedded accountability dashboard** | Adds owner/activity/next-action fields and a leadership dashboard directly to the CRM, with automatic background checks and alerts. | Best long-term experience and most reliable audit trail; requires development access to the CRM’s data layer. | Low recurring running cost; one-time development effort. | Moderate. |
| **Real-time lead-response monitor** | Watches new leads continuously, sends immediate reminders/escalations, and maintains the scorecard automatically. | Fastest intervention; needs a stable source of lead events or a reliable read-only data endpoint. | Low to moderate recurring hosting cost only if continuous monitoring is required. | Moderate to high. |

## Four decisions needed from you

1. **Coverage commitment:** What are the real leasing-office hours, including weekends? Is a 15-minute first response practical during those hours, or should we start at 30 minutes?
2. **Ownership rule:** Is the manager assigned to the property always the person responsible for first contact, or are leads sometimes handled by a centralized leasing/chatter team?
3. **Management approach:** Should the first version be a daily exception report for you to review, or should it immediately notify managers and escalate missed leads?
4. **Build access:** Can we get read-only access to the CRM’s underlying data/database or an export/API from the company that built it? This determines whether the monitor can be accurate and automatic rather than based on screen-level activity.

## Recommended starting point

Start with the **daily operating report** for two weeks, using the thresholds above as a pilot. In parallel, add the missing accountability fields and activity logging. After the pilot establishes realistic workload and response benchmarks, move to the embedded dashboard and automatic notifications. This sequence protects good leads immediately without locking the organization into arbitrary targets or a brittle workaround.
