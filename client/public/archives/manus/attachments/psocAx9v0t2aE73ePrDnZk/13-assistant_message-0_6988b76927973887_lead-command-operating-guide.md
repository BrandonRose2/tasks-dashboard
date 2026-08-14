# Lead Command — Operating Guide

## Purpose

**Lead Command** is an internal operating dashboard for ensuring every property inquiry receives timely, documented follow-up. It gives supervisors a company-wide control view while property managers and freelance callers see only the leads assigned to them.

> The default service rules are **4 business hours** to document an initial response and **24 business hours** between follow-up activities for active leads. The application measures business time, not calendar time, using the property’s timezone and Monday–Friday 9:00 AM–5:00 PM default schedule.

## Supervisor setup

Begin in **Team & buildings**. Add each property and select its timezone. Once a manager or freelance caller has signed in at least once, add them to the caller roster, identify them as a **Property manager** or **Freelance caller**, and attach the buildings for which they are responsible. Use the optional team label for the South Africa calling team so leadership can distinguish that coverage group in the roster.

| Setup step | Where to do it | Result |
|---|---|---|
| Add a building | **Team & buildings → Add building** | Creates a property available for routing and reporting. |
| Set up a caller | **Team & buildings → Add or update caller assignment** | Links a signed-in person to their caller type and buildings. |
| Adjust response standards | **Team & buildings → Response policy** | Changes the first-response and inactivity thresholds in business minutes. |
| Load initial inquiries | **Lead intake** | Adds individual leads or imports a validated CSV. |

## Lead workflow for callers

Callers work primarily from **Lead queue**. They should open their assigned record, make the call, text, or email, and immediately log the activity in the expanded row. The log captures channel, outcome, notes, timestamp, and an optional dated next action without leaving the queue. Logging the first activity automatically records the first response and moves a new lead to **Contacted**. Callers should also update the pipeline stage as the lead progresses.

The most useful habit is to enter a specific next action after every contact attempt. This keeps future work visible and prevents active leads from becoming invisible after a single unanswered call.

## Supervisor daily rhythm

> Treat the **Exceptions** page as today’s intervention list and **Daily digest** as the end-of-day handoff list.

The supervisor should open **Exceptions** early in the day and again before close. The **First-response breaches** tab shows leads that have exceeded the response window without a documented contact attempt. The **Overdue follow-up** tab shows active leads without activity beyond the configured business-hours threshold. Use the individual record to confirm activity, prompt the assigned caller, or reassign coverage through the roster when necessary.

The **Command center** provides the coaching view: company totals, property pulse, and per-caller workload, response compliance, first-response breaches, overdue count, and conversion. The **Daily digest** groups unresolved overdue leads by property and caller, making it suitable for a manager review, coverage handoff, or follow-up meeting.

## Lead intake and CSV format

Manual lead entry is appropriate whenever the existing CRM is not yet synchronized. The CSV importer requires `first_name`, `last_name`, and `property`. Optional headers are `phone`, `email`, `caller`, `source`, `budget`, and `move_date`. Property and caller values must match the names that already exist in Lead Command; invalid rows are skipped before import.

## Operational safeguards

The current implementation gives supervisor accounts company-wide visibility and limits non-supervisor callers to the leads assigned to them. Activity records are append-only in normal use, creating a useful accountability history. For best results, add real properties first, have all managers and freelancers sign in once, create their profiles, and then begin routing or importing leads.

