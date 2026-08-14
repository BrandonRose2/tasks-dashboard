# Lead Monitoring Assessment — Initial CRM Review

## Access and scope

The review was performed from an administrator session in the protected Apartment Corp Operations Console. Only non-destructive viewing was used. No lead stages, notes, assignments, communications, or account settings were changed.

## Observed lead-list capabilities

The **Leads** page lists both applicants and prospects across properties. It reports the total lead count, applicant/prospect counts, and a prominent count of leads new since the administrator's last visit. The current view showed 20,467 leads overall, including 18,767 prospects and 3,001 new since the last visit.

Each visible row includes the lead type; a New marker when applicable; property; bedroom need; stated budget; desired move timing; recent activity age; current pipeline stage; and direct phone/email links. Available list filters include property, type, bedroom count, pipeline stage, housing-voucher flag, and sync time. Bulk selection is also available.

The pipeline stages exposed in the interface are New, Contacted, Toured, Applied, Approved, Leased, and Lost. Stage is editable directly from each row, so the present interface does not itself establish a verifiable contact attempt or require a rationale for progression.

## Observed record-detail capabilities

Opening a record reveals the contact methods plus these fields: applied date, desired move timing, last active time, renter score, household, voucher indicator, status, bedroom count, source, and free-form notes. A notes area exists, but the sample record had no notes and no visible ownership, assignment, next-action date, contact-attempt history, or manager-activity audit trail.

## Implication for monitoring design

The existing page can identify leads that remain New and can segment them by property, source, age, and fit. However, an accountability system that fairly evaluates individual managers will require either (a) an existing but not-yet-located assignment/activity data source or (b) modest additions such as owner, assigned-at, first-contact-at, last-contact-at, next-action-at, outcome/reason, and an immutable activity log.

## Next discovery item

Review the administration area for manager/property assignments and any existing reporting, routing, or audit capabilities before proposing the final architecture.

## Administration dashboard observations

The administration overview provides company-wide metrics for a selectable 7-, 30-, 90-day, or custom period. The current dashboard displayed aggregate leads, applications, leases, replies sent, buildings, conversation volume, channel mix, conversation status, performance by named personnel, and inquiries by property. It identified 943 replies sent in the last 30 days, but the dashboard’s performance view currently shows total messages and lacks a lead-level, owner-level first-response, aging, or conversion accountability measure.

The overview is valuable as a leadership summary, but it should not be used as the sole manager scorecard: message volume can include conversations unrelated to new leads, does not prove a reply reached a lead, and does not reflect follow-up quality or outcome.

## Next discovery item

Review the People section to determine whether managers, roles, and property responsibility are already represented in the product.

## People and ownership observations

The People section confirms that the platform already separates admins, managers, and chatters. At the time of review it showed two admins, ten active managers, and no chatters. Each manager is assigned to one or more buildings through an explicit building-assignment control. This gives the monitoring system a usable responsibility model: lead accountability can be attributed to the manager responsible for the lead’s property without creating an additional organizational directory.

The manager roster is not copied here because the plan does not need personal contact information. The important operational finding is that the CRM already contains active manager accounts and property-to-manager relationships, including at least one manager responsible for more than one building.

## Design consequence

The initial scorecard should roll leads up by property and then by the current property manager, while preserving a historical owner snapshot at the time of assignment. The snapshot avoids retroactively penalizing or crediting a manager after properties are reassigned.
