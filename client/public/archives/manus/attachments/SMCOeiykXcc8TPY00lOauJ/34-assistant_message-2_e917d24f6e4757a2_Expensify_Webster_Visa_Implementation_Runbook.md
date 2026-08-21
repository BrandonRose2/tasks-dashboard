# Expensify + Webster Visa Commercial Card: Step-by-Step Implementation Runbook

**Objective:** Replace the regional manager’s manual Webster Safari receipt-upload routine with an **iPhone-first Expensify workflow**. The manager photographs a receipt in Expensify; the Webster Visa transaction is delivered through a commercial card feed; Expensify matches the two and routes only exceptions for review.

> **Do not begin with the iPhone app.** The indispensable first step is for Webster to enable a Visa Commercial Format (VCF) feed to Expensify. Without that feed, the app can capture receipts but cannot automatically match them to the existing Webster commercial-card transactions.

## Phase 0 — Decide ownership and the system of record

Before configuring anything, designate one finance owner, one Webster program administrator, one Expensify Workspace Admin, and one Expensify Card Admin. For a small pilot these can be two people, but each responsibility must be explicit.

| Role | Responsibility | Required decision before proceeding |
|---|---|---|
| Finance owner | Owns accounting policy, Property/GL mapping, approval rules, and cutover sign-off | Will Expensify become the routine receipt and coding workflow after the feed is live? |
| Webster program administrator / relationship manager | Owns the bank relationship and Visa-feed enablement request | Is the current Webster Visa program eligible to send a VCF feed to Expensify? |
| Expensify Workspace Admin | Creates the workspace, grants access, configures rules, tags, categories, and approvals | Which users need Administrator, Card Admin, or member access? |
| Expensify Card Admin | Connects the feed, assigns individual cards, and manages card assignments | Which card belongs to which manager, and what should each card’s transaction start date be? |
| Regional manager | Tests the iPhone capture workflow and reports exceptions | Will capture receipts immediately after purchase during the pilot? |

The finance owner must also make the core accounting decision: **do not run two routine receipt systems in parallel**. During the pilot, retain the existing Webster process only as a backup/audit-control step. After the pilot passes and finance approves cutover, Expensify should be the routine expense/receipt workflow; otherwise the manager will simply do duplicate work in two systems.

## Phase 1 — Run the preflight checklist

Complete this checklist before contacting Webster. It prevents the usual failure mode: a feed becomes live before there is a workspace, cardholder assignment, coding map, or clear transaction start date.

| Item | Owner | What to prepare |
|---|---|---|
| Corporate workspace | Expensify Workspace Admin | Create or confirm the company Expensify account and the named Workspace that will hold Webster card transactions. Use a company-controlled email domain—not a manager’s personal account. |
| Subscription entitlement | Finance owner + Expensify admin | Confirm the plan supports the number of commercial-card feeds and the controls required. Expensify states Collect permits one company-card feed per Workspace; Control permits unlimited feeds. Control is the appropriate baseline if dependent Property/GL tags and Workspace Rules are needed.[1] |
| Card roster | Webster program administrator | Spreadsheet with cardholder name, company email, last four digits, and desired transaction start date for every pilot card. |
| Property/GL map | Finance owner | A validated table that identifies each Property, permitted GL account(s), normal expense category, approver, and effective date. Do not use the incomplete portal lookup list as the source of truth. |
| Merchant rule list | Finance owner | A short list of merchants with unambiguous repeated coding. Examples should be precise merchant strings, not broad words that could create false matches. |
| Cutover date | Finance owner | Choose a future date for the first transaction import. Clear or document any older unresolved Webster items separately. |
| Security and record retention | Finance + IT | Approve mobile access, receipt-image retention, user offboarding, and the definitive accounting export/archival location. |

## Phase 2 — Request the Webster Visa commercial feed

The Expensify guide says that Visa commercial feeds are configured by the bank through Visa’s Subscription Management portal. It directs the customer to ask the relationship manager to enable **VCF** delivery to Expensify and to request three identifiers: **Processor ID, Bank/Financial Institution ID, and Company ID**. It also says no test file is needed for bank-side VCF enablement.[1]

Send the following message to the Webster program administrator or relationship manager. Do not send credentials, card numbers, or receipts in this message.

> **Subject:** Enable Visa Commercial Format feed to Expensify for our Webster commercial-card program
>
> We are implementing Expensify as the mobile receipt and expense workflow for our existing Webster Visa commercial-card program. Please confirm that our program is eligible for a **Visa Commercial Format (VCF)** transaction feed to Expensify.
>
> If eligible, please complete the bank-side enablement in Visa’s Subscription Management portal to deliver the VCF feed to Expensify. Expensify states that no test file is required for this enablement.
>
> Please provide the following configuration details to our authorized Expensify Workspace Admin through a secure channel:
>
> 1. Processor ID
> 2. Financial Institution/Bank ID
> 3. Company ID
> 4. Confirmed feed start date and expected delivery cadence
> 5. Whether the feed provides posted transactions only or real-time/pending transaction alerts
> 6. Confirmation that enabling the feed will not change cardholder privileges, payment responsibility, or our existing Webster program terms
>
> Our goal is a mobile-only process: cardholders capture receipts on iPhone, Expensify matches the receipts to the fed transactions, and finance manages review/coding in Expensify. Please include the implementation contact who will coordinate any feed questions with Expensify.

**Go/no-go checkpoint:** Stop here if Webster cannot or will not enable the VCF feed. A standard iPhone Shortcut is not a substitute for the transaction feed. Escalate to Expensify and Webster jointly rather than attempting to automate the logged-in Webster portal.

## Phase 3 — Create and secure the Expensify workspace

The Workspace Admin should create a workspace named something clear and durable, such as **Webster Commercial Card — Expenses**. Add the finance owner and a backup administrator first. Add the pilot manager as a Workspace member using her company email.

Assign the minimum roles necessary. A Workspace Admin can establish the commercial feed. A Card Admin can manage company card feed settings and assign cards. Expensify’s guide says any Workspace Admin can establish a commercial feed connection; Workspace Admins, Card Admins, and their Copilots can assign cards after the feed is connected.[1] [3]

If the **Company Cards** item does not appear in the Workspace, enable it through **Workspace → More Features → Company Cards**.[4] Do not connect a personal card or choose the Expensify-issued card product: this project is specifically for the existing Webster Visa commercial card.

## Phase 4 — Connect the Webster commercial Visa feed in Expensify

After Webster provides the three identifiers, the Expensify Workspace Admin completes the connection:

1. Open **Expensify** and navigate to **Workspaces → [Webster Commercial Card — Expenses] → Company Cards**.
2. Select **Add Cards**.
3. Select **Commercial Feed**.
4. Select **Visa Commercial Cards**.
5. Enter the **Processor ID**, **Bank/Financial Institution ID**, and **Company ID** exactly as supplied by Webster.
6. Submit the connection.
7. Record the connection date, feed name, and Webster case/contact in the implementation tracker.
8. Wait for Expensify’s notification that the feed is connected. Do not tell the manager to start using the new app until that notification arrives.

These are Expensify’s published Visa commercial-feed steps.[1]

Once connected, go to **Workspaces → [Workspace] → Company Cards → [Feed] → Settings** and give the connection a clear internal name, such as **Webster Visa Commercial — VCF**. Workspace Admins manage company-card settings at the workspace level and Card Admins manage the feed/card assignments.[2]

> **Data-protection warning:** Do not remove the feed or unassign a card while there are transactions in Expensify’s Unreported or Draft state. Expensify warns that removing the feed or unassigning a card deletes such imported expenses.[2]

## Phase 5 — Assign the Webster pilot card to the regional manager

A connected feed does not automatically solve visibility; the correct Webster card must be assigned to the correct Expensify Workspace member.

1. Go to **Workspaces → [Workspace] → Company Cards**.
2. Select the **Webster Visa Commercial — VCF** connection.
3. Select **Assign card** next to the manager’s Webster card.
4. Enter the regional manager’s company email address.
5. Set the **Transaction start date** to the pilot cutover date. Choose a future date if the organization wants to keep prior transactions out of the new workflow.
6. Select **Assign card** to finalize.
7. Confirm with the manager that she can see the card/Workspace in the iPhone app before the first live purchase.

Expensify says that assigning a company card links the card to the Workspace member and that posted transactions from that date forward import automatically into that member’s account as expenses.[3]

## Phase 6 — Translate Property and GL coding into rules

This phase determines whether the mobile process is truly automated or merely shifts the manual lookup into a different app. The starting configuration should be conservative: automatic coding only for known, low-risk patterns; visible exceptions for everything else.

### 6A. Configure Property and GL fields

Use **Tags** for Property and, if the accounting structure requires it, a second **dependent Tag** level for GL. Expensify describes Tags as accounting/reporting codes such as cost centers, classes, projects, locations, customers, and jobs.[5]

For this operating model, set up:

| Existing Webster field | Recommended Expensify structure | Design rule |
|---|---|---|
| Property Code | Tag level 1: **Property** | Import the approved property list with the actual user-facing property name/code. |
| GL Code | Tag level 2: **GL Account** or a Category, depending on accounting design | Use a dependent Tag relationship if only certain GL codes are valid for each Property. This keeps invalid combinations out of the user’s choices. |
| Expense type | Category | Use standard categories such as lodging, supplies, travel, or meals; do not overload Category with a property code. |
| Approver | Tag approver / workspace approval flow | Route particular properties or categories to the responsible reviewer only after the core coding works. |

Multi-level Tags are available on Control workspaces. Expensify’s tag documentation says dependent levels filter downstream choices to valid combinations, and tags may be imported from a CSV/TSV template with optional GL codes.[5] Build the Property/GL import file from the finance-approved mapping, not from the manager’s memory.

### 6B. Require visible coding and receipt checks

Enable **Tags**, then set the Workspace to require tags and categories. Expensify says missing required Tags/Categories remain visible as an orange attention indicator to the submitter and approver; do not treat the feature as a hard technical block.[6]

Enable **Workspace Rules** and configure at least the following:

| Rule | Initial recommendation | Reason |
|---|---|---|
| Receipt required amount | Set to the organization’s policy threshold; use $0.01 if every card charge must have an image | Ensures a receipt requirement remains visible in the new workflow. |
| Itemized receipt required | Apply to lodging and any categories finance requires | Hotel folios are a frequent source of incomplete documentation. |
| Merchant-based automation | Start with 5–10 unambiguous recurring merchants | Reduces repetitive coding without risky broad rules. |
| Company card purchases required | Enable after the Webster feed is confirmed live | Flags out-of-pocket items that should have used the corporate card. |
| eReceipts | Optional for eligible low-dollar USD transactions | eReceipts can reduce receipt-chasing, but they do not cover all categories and should not replace receipt policy testing. |

Workspace Merchant Rules can set merchant name, Category, Tag, Description, reimbursable/billable status, and tax. Use **Preview matches** and exact merchant names during the pilot; Expensify warns that broad “contains” rules can apply to unintended merchants.[7] Workspace Rules also support receipt thresholds, merchant-based automation, and company-card rules.[8]

### 6C. Configure export only after the pilot proves the coding model

If finance uses QuickBooks, NetSuite, Xero, or another supported accounting connection, decide whether Webster card expenses export to a **central account** or separate account mappings per card. Expensify provides both central and per-card export options.[2] Do not turn on a production accounting export until the pilot transactions have been reviewed for correct Property/GL mapping.

## Phase 7 — Configure the regional manager’s iPhone

Only after the card is assigned and the feed is confirmed connected, configure the manager’s phone:

1. Install the official **Expensify** iPhone app from the App Store.
2. Sign in with the company account that was added to the Workspace.
3. Confirm the correct Workspace and assigned company card are visible.
4. Allow camera access so the manager can capture receipt images.
5. Allow app notifications during the pilot so she sees any receipt, match, or exception prompts.
6. Take one sample receipt photo inside the app—not in Safari and not in the photo library—then confirm it appears in Expensify.
7. Put the Expensify app in the dock or primary Home Screen position. The capture instruction is simply: **open Expensify, photograph the receipt, and continue working.**

Do not build a separate iPhone Shortcut until the app’s native capture and matching cycle has been tested. The app plus the commercial feed is the automation; a Shortcut should only be considered later if it can open the app reliably without adding steps.

## Phase 8 — Run a controlled 10-receipt pilot

The manager should process ten ordinary Webster card receipts over several days. She should not complete routine receipt uploads in the Webster portal for those pilot items unless the finance owner instructs her to do so as an explicit backup control.

For each purchase, the manager opens Expensify, photographs the receipt, and does not search for the corresponding card transaction. When the Webster card charge posts through the feed, Expensify should import it and match the receipt where the data supports a match. The finance owner reviews each pilot item for receipt image, correct transaction association, Property, GL, category, approval routing, and accounting-export result.

| Pilot test | Pass condition | Owner |
|---|---|---|
| Feed delivery | All ten posted Webster charges reach the correct cardholder’s Expensify account | Card Admin |
| Receipt capture | All ten receipt images are readable in Expensify | Regional manager |
| Receipt-to-charge matching | At least 9 of 10 ordinary receipts are correctly auto-matched or matched with one simple review action | Finance owner |
| Property/GL coding | No incorrect automatic Property/GL result; all exceptions are conspicuous | Finance owner |
| Approval route | Every item reaches the correct approver without manual reassignment | Finance owner |
| Export test | A controlled test export lands in the expected accounting account/fields | Finance + accounting owner |
| Mobile usability | Normal capture takes less than 15 seconds and needs no Webster Safari upload | Regional manager |

The 90% match rate and 15-second capture goal are internal acceptance targets, not vendor promises. Any incorrect auto-coding is more serious than a missed match; correct the rule and retest before expanding the pilot.

## Phase 9 — Cut over safely

Proceed to full rollout only after the finance owner signs off on the pilot evidence. Complete these actions in sequence:

1. Reconcile or document all transactions dated before the agreed Expensify Transaction start date in the existing Webster process.
2. Add all remaining cardholders to the Expensify Workspace.
3. Assign each card and set its Transaction start date.
4. Import the approved Property/GL mapping and carefully tested merchant rules.
5. Turn on the approved receipt requirements, Tag/Category settings, and approvals.
6. Confirm the accounting export configuration with one additional controlled transaction.
7. Communicate a single rule to cardholders: **capture the receipt in Expensify immediately; do not attach routine receipts through Webster Safari.**
8. Keep the Webster portal available for card administration and exceptions, but do not use it as the normal receipt-attachment workflow unless Webster/finance requires it for compliance.
9. Review exceptions daily for the first week and weekly for the first month. Update rules only after reviewing actual exceptions.

## Phase 10 — Handle exceptions without reintroducing the old manual process

The manager should not be forced back to the Webster portal because an occasional receipt does not match. Build a small Expensify exception process instead.

| Exception | Mobile-first resolution |
|---|---|
| Receipt was not captured at purchase | Photograph it later in Expensify or forward a digital receipt through the approved Expensify route. |
| Charge has not yet posted | Leave the receipt in Expensify; do not create a duplicate expense or upload it in Webster. Review after the agreed feed timing. |
| Wrong suggested Property/GL | Correct it in Expensify, notify finance during the pilot, and decide whether a rule should be changed. |
| Similar merchants/amounts create a match concern | Finance reviews rather than allowing an unverified automatic coding rule. |
| Hotel folio | Capture the complete itemized folio; do not rely solely on a low-dollar eReceipt rule. |
| Card is lost, replaced, or reassigned | Card Admin updates the card assignment and start date; do not unassign/replace it casually while draft items exist. |

## One-page operational checklist

| Sequence | Completed when |
|---:|---|
| 1 | Finance approves Expensify as the routine receipt/coding workflow after cutover. |
| 2 | Webster confirms VCF eligibility and provides Processor ID, Bank ID, and Company ID. |
| 3 | Expensify Workspace, Admins, Card Admin, pilot user, and plan entitlement are ready. |
| 4 | Workspace has Company Cards enabled. |
| 5 | Workspace Admin connects Commercial Feed → Visa Commercial Cards using Webster’s identifiers. |
| 6 | Expensify confirms the feed is connected. |
| 7 | Card Admin assigns the manager’s Webster card and a future Transaction start date. |
| 8 | Finance imports Property/GL Tags, configures Categories, receipt policy, and narrow merchant rules. |
| 9 | Manager captures ten pilot receipts in the Expensify iPhone app. |
| 10 | Finance validates matching, coding, approval, and export; then authorizes full cutover. |

## References

[1] [Expensify Help — Set Up a Commercial Card Feed Connection](https://help.expensify.com/articles/new-expensify/connect-credit-cards/Set-up-a-Commercial-Card-Feed-Connection.html). Visa VCF enablement, required identifiers, workspace connection path, and commercial-feed plan limits.

[2] [Expensify Help — Configure Company Card Settings](https://help.expensify.com/articles/new-expensify/connect-credit-cards/Configure-Company-Card-Settings.html). Company-card administration, export settings, eReceipts, and warning about removing/unassigning feeds.

[3] [Expensify Help — Assign Company Cards](https://help.expensify.com/articles/new-expensify/connect-credit-cards/Assign-Company-Cards.html). Card assignment roles, transaction start date, and automatic import to the assigned member.

[4] [Expensify Help — Share a Company Card Feed Across Workspaces](https://help.expensify.com/articles/new-expensify/connect-credit-cards/Share-a-Company-Card-Connection-Across-Workspaces.html). Company Cards feature enablement path and shared commercial-feed behavior.

[5] [Expensify Help — Create and Manage Expense Tags](https://help.expensify.com/articles/new-expensify/workspaces/Create-and-manage-expense-tags.html). Tags, multi-level dependent tags, import formats, and Tag GL codes.

[6] [Expensify Help — Require Tags and Categories for Expenses](https://help.expensify.com/articles/new-expensify/workspaces/Require-tags-and-categories-for-expenses.html). Required coding behavior and mobile configuration path.

[7] [Expensify Help — Workspace Merchant Rules](https://help.expensify.com/articles/new-expensify/workspaces/Workspace-Merchant-Rules.html). Merchant rule fields, import, preview, and matching guidance.

[8] [Expensify Help — Workspace Rules](https://help.expensify.com/articles/new-expensify/workspaces/Workspace-Rules.html). Receipt, eReceipt, company-card, merchant automation, and approval-related workspace rules.
