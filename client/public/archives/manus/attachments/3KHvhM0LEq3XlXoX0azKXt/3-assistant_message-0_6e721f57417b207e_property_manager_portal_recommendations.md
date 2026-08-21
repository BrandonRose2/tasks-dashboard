# Recommendation: Resident Qualification & Leasing Approval Portal

**Prepared for:** You and Leslie  
**Source:** Recorded discussion, with the most relevant segment approximately 02:32–11:07  
**Purpose:** Reduce preventable early delinquency and improve the consistency, documentation, and speed of leasing decisions.

## Important Scope Clarification

Although your note refers to “hiring new employees,” the substantive conversation in the recording is about **screening and approving prospective residents**, not recruiting property-management staff. Leslie’s concern is that site teams are driven to fill vacancies quickly and may approve applicants without completing meaningful verification. The resulting cost can be far greater than a short vacancy: delinquent rent, eviction expenses, additional turn work, damage, and lost operating time.

> “It’s costing us less to let that unit sit there for a month … than it is for us to rent it and try to get them out.” — Leslie, approximately 06:27–06:41

I would frame the product as a **resident qualification and leasing-approval portal**, rather than another credit-screening tool. Its job is to make the right verification steps easy, evidence-based, consistently applied, and auditable.

## The Core Product Idea

Create a portal—working name **LeaseGuard** or **Resident Approval Desk**—that gives a leasing manager a guided approval workflow for every applicant. Instead of a manager reviewing a credit report and making an undocumented judgment, the portal collects required evidence, records verification attempts, applies the property’s approved criteria, calculates a transparent risk/quality indicator, and routes exceptions for review.

The portal should **not autonomously approve or deny applicants**. It should standardize the file, identify missing information and approval-policy exceptions, and provide a documented recommendation for an authorized human decision-maker. This is a safer operating model for housing compliance and easier to implement with existing property-management systems.

| Current pain point heard in recording | Portal response | Result |
|---|---|---|
| “Rent, rent, rent” pressure drives weak files | A required approval checklist and exception workflow | Fewer rushed, unsupported approvals |
| Credit is treated as the primary signal | A multi-factor file review centered on income, rental behavior, and employment stability | More meaningful review of ability and likelihood to pay rent |
| Managers say verification was done, but proof is absent or unreliable | Verification logs, source-document uploads, time stamps, and approval attestations | Audit-ready accountability |
| Teams manage HUD, LIHTC, voucher, and conventional units differently | Rulesets and checklists selected by property/program type | Correct workflow for each community |
| A vacancy decision ignores downstream cost | A visible “vacancy versus bad-approval” decision panel | Better operational tradeoffs |

## Recommended Applicant Workflow

The workflow should be deliberately simple. A leasing manager opens an applicant record, selects the property and program type, and completes a guided set of verification tasks. The system should display an **Application Ready** status only when the configured evidence has been collected or an approved exception has been recorded.

| Step | What the portal captures | Automation and control |
|---|---|---|
| 1. Intake | Applicant/household information, unit, rent amount, desired move-in date, subsidy or voucher context | Pull basic data from the property-management system or import it from application files |
| 2. Program ruleset | Conventional, HUD, LIHTC, Section 8/voucher, or property-specific requirements | Dynamically show the correct checklist, notices, and document requirements |
| 3. Income review | Documented household income, income-to-rent calculation, and source documents | Auto-calculate the configured threshold, such as 2.5× or 3.0× rent; flag missing or inconsistent figures |
| 4. Employment stability | Current employer, start date, prior employer(s), unexplained employment gaps, verification outcome | Apply transparent tenure bands and prompt staff to log each verification attempt |
| 5. Rental history | Prior landlords, residency dates, rent/payment history, verification outcome, and supporting notes | Require a standardized contact log; distinguish “verified,” “unable to verify,” and “exception approved” |
| 6. Screening input | Approved screening results and policy-defined considerations | Treat this as one controlled input—not the sole decision driver |
| 7. Risk/quality summary | Objective criteria results, open issues, exceptions, and a clear file-completeness status | Produce a manager-readable summary and route exceptions to regional/compliance review |
| 8. Decision and audit record | Authorized approver, decision, rationale, time stamp, forms, and required notices | Lock the record after finalization while preserving an exportable audit trail |

## Scoring: Useful as a File-Quality Indicator, Not a Black-Box Decision Engine

Leslie specifically discussed a scoring approach, including different weights for six- and twelve-month job tenure. That is a good idea **if the score is transparent, configurable, and never substitutes for the written screening policy or human review**. I would call it a **Lease File Readiness Index** rather than a “tenant score.”

The primary display should show each factor, its status, the evidence behind it, and the applicable policy. For example, “Current income documented,” “Current employment verified,” “Prior landlord response received,” “Payment history documented,” and “Program documents complete.” A score can summarize completeness and policy alignment, but every score must be explainable on screen.

| Example factor | Example status bands | Portal behavior |
|---|---|---|
| Current-job tenure | Under 6 months; 6–12 months; over 12 months | Flag lower-tenure files for additional review based on the written property policy |
| Employment continuity | No gap; documented gap; unexplained gap | Require notes and supporting documentation where policy calls for it |
| Income-to-rent | Meets threshold; near threshold; below threshold | Calculate consistently from documented income and configured rent threshold |
| Rental verification | Completed; attempted but unavailable; incomplete | Prevent completion until evidence or an approved exception is logged |
| Prior payment pattern | Favorable; concern; insufficient evidence | Capture standardized responses rather than free-form recollection |
| Compliance file | Complete; exception pending; incomplete | Prevent automatic progression where critical documents are absent |

## Most Valuable Automations

The first release should prioritize **workflow enforcement and visibility**, not complicated artificial intelligence. The earlier candidate-ranking system you described was technically capable but apparently was not adopted. That is a strong signal that success depends on fitting the daily leasing workflow and taking fewer—not more—clicks.

| Automation | How it works | Why it matters |
|---|---|---|
| Missing-item chaser | Automatically sends internal reminders for uncompleted employment/rental verification tasks | Keeps incomplete files from quietly becoming approvals |
| Verification call/text templates | Generates property-approved scripts and logs the contact attempt | Makes compliance easier than improvisation |
| Document checklist generator | Builds the checklist from property/program type | Reduces errors across HUD, LIHTC, voucher, and conventional communities |
| Exception routing | Sends a file that falls outside policy to the correct regional/compliance approver | Stops site-level pressure from bypassing policy invisibly |
| Decision packet | Produces a concise, timestamped packet with evidence, checklist, notes, and approval | Supports file review, MOR preparation, and training |
| Vacancy-versus-risk panel | Shows vacancy age alongside a standardized record of approval exceptions and subsequent performance | Changes the conversation from “fill it now” to “approve a supportable file” |
| Portfolio dashboard | Shows application volume, incomplete files, exception rates, early delinquency, and outcomes by property | Identifies training and operating issues early |

## Management Dashboard: The Proof That It Is Working

The executive view should measure whether the organization is trading short-term occupancy for long-term loss. It should not be a surveillance dashboard; it should be a decision-quality dashboard.

| Dashboard area | Recommended measures |
|---|---|
| File quality | Percentage of files complete at approval, average time to completion, missing-document rate, verification completion rate |
| Exceptions | Exceptions by property, manager, criteria type, approver, and time-to-resolution |
| Leasing outcomes | Early delinquency at 30/60/90 days, repayment arrangements, eviction filing rate, and unit return-to-ready time |
| Operating tradeoff | Vacancy days compared with avoidable loss indicators, presented as trend analysis rather than a single causal metric |
| Compliance | Audit-ready files, required forms completed, outstanding review items, and policy-version history |

The most compelling long-term feature is a feedback loop. After move-in, the portal can associate the original file’s **policy-aligned factors and documented exceptions** with later outcomes such as early delinquency. This should be used to evaluate the organization’s written criteria and staff training, never to create hidden or unreviewed decision rules.

## Recommended MVP

A focused MVP can be deployed without attempting a risky “AI approval” project. Start with one conventional property and one regulated/affordable property so the workflow proves it can handle meaningful differences.

| MVP component | Include now | Defer until the workflow is proven |
|---|---|---|
| Applicant record | Intake, property selection, household basics, document uploads | Full two-way synchronization with every property-management platform |
| Checklist | Configurable income, employment, rental, and compliance requirements | Highly granular, enterprise-wide policy-engine customization |
| Verification logs | Standardized call/email/text records with required outcomes | Automated third-party verification integrations |
| Review summary | Evidence, missing items, flags, exception routing, approval attestations | Predictive risk models or automated recommendations |
| Reporting | File completion, exceptions, turnaround, and early-performance trends | Complex financial attribution and benchmarking models |

## Implementation Sequence

The correct first step is a working session with Leslie, operations, compliance, and one or two high-performing site managers. The group should decide what must be verified, what counts as acceptable evidence, who can authorize an exception, and which differences are required by property/program type. Those decisions become the portal’s version-controlled rulesets.

| Phase | Outcome | Practical deliverable |
|---|---|---|
| 1. Policy and workflow mapping | One agreed process for an applicant file | Written checklist, roles, exceptions, and evidence standards |
| 2. Clickable prototype | Validate that managers can complete a file quickly | Simple portal screens and a test approval packet |
| 3. Pilot | Test behavior at two contrasting properties | Weekly review of adoption, incomplete files, and exceptions |
| 4. Integration | Reduce duplicate data entry | Targeted data exchange with the existing property-management/application stack |
| 5. Outcome review | Prove whether procedures and training improve | 30/60/90-day trend dashboard and policy refinement process |

## Guardrails That Should Be Designed In From Day One

The portal has to be built as a **consistent-process and documentation system**, not as a tool to evade rules or make undocumented subjective decisions. Rules must be approved by qualified housing counsel and compliance leadership; applied consistently; configurable by jurisdiction, property, and subsidy/program requirements; and accompanied by appropriate notices, document retention, access controls, and review paths. Any use of consumer-reporting, credit, or screening data should be implemented only through approved vendors and policies.

It should also be clear in the interface that the tool provides a structured review and highlights policy exceptions; it does not replace authorized human judgment or make legally binding approval/denial decisions on its own.

## If Leslie Actually Meant Hiring Employees

The same portal architecture can be reused for **new-hire recruiting and onboarding**, but the fields should be completely different: requisition, job description, résumé/application intake, license/certification verification, interview scorecards, background-check consent/status, offer approvals, onboarding forms, training assignments, and HR approval gates. In that version, the feature that mirrors this conversation is not resident screening—it is a **transparent, auditable candidate-readiness workflow** that prevents a rushed manager from bypassing required steps.

## Bottom Line

The opportunity is not merely an applicant-ranking tool. It is a **leasing decision-control system** that makes it faster for good managers to assemble a complete file, harder for rushed teams to skip essential verification, and easier for leadership to see whether vacancy pressure is creating costly resident outcomes. Start with the checklist, evidence trail, exception workflow, and simple dashboard; let later integrations and analytics earn their place through real usage.

---

## Source Note

This brief is grounded in the supplied recording. The relevant discussion focuses on resident screening, rental history, employment history, income-to-rent, manager verification behavior, HUD/MOR documentation, and the operational cost of poor leasing decisions.
