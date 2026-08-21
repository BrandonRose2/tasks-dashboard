# LeaseGuard MVP: Property-Manager Dashboard User Stories and Wireframes

**Product framing.** LeaseGuard is a resident-qualification and leasing-approval workspace. It does not make autonomous rental approvals or denials. Instead, it makes policy-defined verification, evidence collection, exception routing, and audit-ready human decisions easier and more consistent.

## 1. Dashboard Users and Permissions

The dashboard should expose only the information and actions needed by each role. Every role sees a traceable record of what has happened to a file, but permissions determine whether the user can edit, approve, override, or administer policy.

| Role | Primary dashboard purpose | Key permissions |
|---|---|---|
| Leasing manager | Work the daily applicant queue and complete verification tasks | Create and update files, upload evidence, log verification attempts, submit exceptions; cannot self-approve policy exceptions |
| Property manager | Keep applications moving and address operational bottlenecks | Monitor property queue, assign tasks, review file readiness, request corrections, approve only within delegated authority |
| Regional manager | Resolve escalated cases consistently across assigned properties | Review exceptions, approve/return files, see exception and completion trends |
| Compliance leader | Maintain policy alignment and audit readiness | Review file packets and audit logs, configure ruleset versions, monitor required documentation |
| Executive/owner | Understand decision quality and operating tradeoffs | Read-only portfolio outcomes, exception trends, early-delinquency trends, and policy-adoption measures |
| System administrator | Manage access and integrations | Administer users, roles, properties, integrations, retention settings, and audit exports; no business approval authority by default |

## 2. MVP User Stories

The MVP focuses on getting a complete, supportable file to the right human decision-maker with minimal friction. Each story below is written to be testable during a pilot.

| ID | User story | Acceptance criteria |
|---|---|---|
| US-01 | As a **leasing manager**, I want a single “My Work” queue so that I know which files need action today. | The default queue prioritizes overdue verification tasks, incomplete applications, and files awaiting a response; it can be filtered by property, status, and program type. |
| US-02 | As a **leasing manager**, I want to select the property and program type at intake so that the correct requirements appear immediately. | Selecting Conventional, HUD, LIHTC, or voucher context loads the approved ruleset version, checklist, and required evidence items. |
| US-03 | As a **leasing manager**, I want the portal to calculate documented income-to-rent so that I do not perform inconsistent math. | The calculation uses recorded rent and approved income inputs; it visibly identifies the configured threshold and flags missing/inconsistent source data. |
| US-04 | As a **leasing manager**, I want to log employment and rental-verification attempts in a structured format so that the file shows what was actually checked. | Each log includes method, contact target, date/time, outcome, user, notes, and attachment option; entries are immutable after a final decision, except through an auditable correction flow. |
| US-05 | As a **leasing manager**, I want clear completion indicators so that I know whether a file is ready for review. | The applicant screen shows completed, pending, blocked, and exception-required items; a file cannot be submitted as complete while critical requirements are unresolved. |
| US-06 | As a **property manager**, I want to see a property-level bottleneck view so that I can coach the team and prevent approvals from stalling. | The dashboard shows queue volume, average age, overdue items, verification completion, and exception volume for the user’s assigned property. |
| US-07 | As a **regional manager**, I want a standardized exception packet so that I can approve or return an exception without reconstructing the file. | The packet includes ruleset version, policy criterion, supplied evidence, missing items, manager rationale, applicant timeline, and an approve/return action with mandatory rationale. |
| US-08 | As a **compliance leader**, I want a tamper-evident activity history so that I can demonstrate how a decision was reached. | The file timeline records actor, action, time, prior/new value where relevant, policy version, and associated evidence identifier. |
| US-09 | As a **compliance leader**, I want to publish a new ruleset without changing files already in progress so that audit review remains reproducible. | A ruleset is versioned, effective-dated, and bound to each application at intake; changes require approval and do not silently rewrite historical evaluations. |
| US-10 | As an **executive**, I want a portfolio view of file quality and outcomes so that we can see whether vacancy pressure is creating costly decisions. | The view aggregates application volume, completion rate, exception rate, queue age, 30/60/90-day early-performance indicators, and property trend comparisons without exposing unnecessary applicant PII. |
| US-11 | As a **property manager**, I want a small-screen friendly queue so that I can resolve a critical exception from my phone without excessive scrolling. | On mobile, the queue shows applicant, property, readiness status, next action, age, and urgency; less critical columns move into the detail view. |
| US-12 | As a **system administrator**, I want role- and property-scoped access so that users only access authorized files. | Every read and update enforces role and property/region scope on the server; a user cannot access a record by changing a browser URL or request identifier. |
| US-13 | As a **leasing manager**, I want approved verification templates so that I can request information consistently. | The system provides administrator-maintained email/SMS/call scripts based on property/program type; sends and manual attempts are logged to the file. |
| US-14 | As a **decision-maker**, I want the portal to show that it is a decision-support tool rather than an automatic approval engine. | Every summary labels its result as “File readiness and policy review,” displays the evidence and policy logic, and requires an authorized human action to finalize the decision. |

## 3. Information Architecture

The sidebar is deliberately compact. Managers should arrive at the queue—not a dense analytics report—and executives should see aggregate information without drilling into personal applicant data.

| Navigation area | Intended content |
|---|---|
| My Work | Personal task queue, overdue tasks, files waiting for the user, quick filters |
| Applications | Searchable records, intake, applicant timelines, evidence, verification activities |
| Exceptions | Files outside policy that await review or require correction |
| Portfolio | Property/region dashboard: completeness, exceptions, aging, and approved outcome trends |
| Reports | Decision packet export, activity logs, policy-completion reports, operational trend extracts |
| Administration | Rulesets, templates, property mappings, integrations, users, roles, and retention settings |

## 4. Wireframe A — Property Manager Command Center

The command center is the daily starting point. The screen’s primary job is to focus the manager on **what needs action next**, while showing whether the property is relying too heavily on exceptions or carrying incomplete files.

```text
┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ LeaseGuard                              [Property: Walnut Grove ▾] [Search applicants...]  [JM ▾] │
├──────────────┬─────────────────────────────────────────────────────────────────────────────────────┤
│ MY WORK      │ Good morning, Jordan                                        Tue, Aug 19              │
│ Applications │ ┌───────────────┐ ┌───────────────┐ ┌───────────────┐ ┌───────────────────────────┐ │
│ Exceptions   │ │  18           │ │  6            │ │  3            │ │  92%                      │ │
│ Portfolio    │ │ Active files  │ │ Need action   │ │ Exceptions    │ │ Verification complete     │ │
│ Reports      │ └───────────────┘ └───────────────┘ └───────────────┘ └───────────────────────────┘ │
│              │                                                                                     │
│              │ Priority queue                                              [Filters ▾] [New file]  │
│              │ ┌─────────────────────────────────────────────────────────────────────────────────┐ │
│              │ │ Applicant      Unit   Ready status       Next action                 Age  Owner  │ │
│              │ │ A. Johnson     204    BLOCKED            Verify prior landlord       3d   Jordan │ │
│              │ │ M. Rivera      118    EXCEPTION REVIEW   Income variance—submit      2d   Kim    │ │
│              │ │ C. Lee         307    IN PROGRESS        Call current employer       1d   Jordan │ │
│              │ │ S. Patel       110    READY FOR REVIEW   Assign decision maker        1d   Kim    │ │
│              │ └─────────────────────────────────────────────────────────────────────────────────┘ │
│              │                                                                                     │
│              │ ┌────────────────────────────────────┐ ┌─────────────────────────────────────────┐ │
│              │ │ Verification health                │ │ Exception snapshot                      │ │
│              │ │ Income       █████████░ 90%         │ │ 2 awaiting regional review              │ │
│              │ │ Employment   ████████░░ 80%         │ │ 1 returned for missing evidence         │ │
│              │ │ Rental       ██████░░░░ 60%         │ │ [Open exception queue →]                │ │
│              │ └────────────────────────────────────┘ └─────────────────────────────────────────┘ │
└──────────────┴─────────────────────────────────────────────────────────────────────────────────────┘
```

**Interaction notes.** The cards should be clickable filters, not passive numbers. “Need action” should open only files owned by the current manager that have an overdue or next-required task. The table should make `ready status` and `next action` visually dominant; avoid crowding the manager with full applicant details on the initial view.

## 5. Wireframe B — Applicant File Review and Readiness

This screen turns an applicant file into a guided workflow. It makes evidence and policy exceptions conspicuous while preserving a chronological record for audit review.

```text
┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ ‹ Back to queue    Applicant: A. Johnson     Walnut Grove · Unit 204 · Conventional                │
│ File status: BLOCKED—rental verification incomplete              [Save] [Submit for review disabled]│
├──────────────┬─────────────────────────────────────────────────────────────────────────────────────┤
│ FILE SUMMARY │ Readiness summary                                                Policy v1.3          │
│ Overview     │ ┌──────────────────────────────┐  ┌────────────────────────────────────────────────┐ │
│ Income       │ │ File readiness: 72%          │  │ Next required action                           │ │
│ Employment   │ │ 5 of 7 checks completed      │  │ Verify prior landlord—attempt 1 logged       │ │
│ Rental       │ │ 1 blocked · 1 attention item │  │ [Log call] [Send template] [Upload evidence] │ │
│ Screening    │ └──────────────────────────────┘  └────────────────────────────────────────────────┘ │
│ Documents    │                                                                                     │
│ Activity     │ Review checklist                                                                  │
│              │ ┌─────────────────────────┬───────────────┬───────────────────┬───────────────────┐ │
│              │ │ Requirement             │ Status        │ Evidence          │ Action            │ │
│              │ │ Income-to-rent ≥ 2.5x   │ COMPLETE      │ 3 pay stubs        │ View              │ │
│              │ │ Current job tenure      │ COMPLETE      │ Employer verified  │ View log          │ │
│              │ │ Prior employment        │ ATTENTION     │ Gap documented     │ Add note          │ │
│              │ │ Prior rental history    │ BLOCKED       │ Attempt #1 logged  │ Log follow-up     │ │
│              │ │ Program documents       │ COMPLETE      │ 4 files            │ View              │ │
│              │ └─────────────────────────┴───────────────┴───────────────────┴───────────────────┘ │
│              │                                                                                     │
│              │ Activity timeline                                                                  │
│              │ 10:42  Jordan uploaded pay stubs             09:20  Jordan logged landlord call    │
└──────────────┴─────────────────────────────────────────────────────────────────────────────────────┘
```

**Interaction notes.** The system must not merely show “score 72.” The manager must see why the file is blocked, the exact next step, the policy version, and the supporting evidence. The `Submit for review` button remains unavailable until all required items are complete or an authorized exception is submitted.

## 6. Wireframe C — Regional Exception Review

Regional and compliance review should be fast, consistent, and document-centered. The approver should not have to call the property manager or search through attachments to understand the question.

```text
┌────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ Exception review · M. Rivera · Walnut Grove · Submitted by Kim · 2 hours ago                       │
├───────────────────────────────────────────────────────────┬────────────────────────────────────────┤
│ Policy exception                                           │ Evidence and activity                 │
│ ┌───────────────────────────────────────────────────────┐ │ ┌────────────────────────────────────┐ │
│ │ Criteria: Documented income-to-rent threshold          │ │ │ Income documents (2)                │ │
│ │ Ruleset version: Conventional v1.3                     │ │ │ Employer-verification log           │ │
│ │ Result: 2.42x vs. configured 2.50x                    │ │ │ Manager rationale                   │ │
│ │ Manager rationale: verified overtime begins next month │ │ │ Prior-landlord response             │ │
│ └───────────────────────────────────────────────────────┘ │ └────────────────────────────────────┘ │
│                                                           │                                        │
│ Required reviewer decision                                │ Timeline                               │
│ [Approve exception] [Return for correction]               │ • 11:32 Submitted by Kim              │
│ Rationale (required) [_______________________________]    │ • 10:18 Income documents uploaded     │
│                                                           │ • 09:42 Employer called                │
│ [Save decision]                                           │                                        │
└───────────────────────────────────────────────────────────┴────────────────────────────────────────┘
```

**Interaction notes.** The decision must capture a reviewer rationale and bind it to the ruleset version and evidence set reviewed. A returned file should create a specific task for the property—not a generic rejection message.

## 7. Mobile Layout Rules

The mobile experience should optimize for urgent queue resolution, not dense reporting. Cards retain the same priority semantics as desktop, while all secondary fields appear only after opening an applicant.

| Element | Desktop behavior | Mobile behavior |
|---|---|---|
| Queue table | Multi-column table with owner and age | Stacked cards: applicant, unit/property, readiness status, next action, age |
| KPI cards | Four-card row | Two-column, then horizontal scroll only if necessary |
| Filters | Persistent toolbar | Bottom-sheet filters with applied-filter count |
| Applicant review | Sidebar plus content panel | Stepper/accordion: Summary, Income, Employment, Rental, Documents, Activity |
| Exception actions | Inline action buttons | Sticky bottom action bar with explicit confirmation and rationale input |

## 8. Design Principles for the Pilot

The pilot should measure whether the design reduces the effort required to assemble a supportable file. For that reason, the interface should default to the next action, use plain-language readiness states, and make “what evidence is missing?” answerable in one glance. The product should avoid opaque predictions, use policy-based wording, and keep an immutable activity timeline visible to authorized reviewers.

The visual direction should feel trustworthy and operational: a calm neutral background, clear status colors with text labels, compact tables, and obvious evidence/action hierarchy. Color cannot be the sole indicator of status, and applicant PII should not appear in management-level dashboards unless the viewer is authorized to open the underlying file.
