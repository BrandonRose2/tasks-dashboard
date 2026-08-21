# Expensify SmartScan and Automation Configuration for 30 Daily Regional Receipts

**Purpose:** Configure Expensify so the regional manager captures each receipt once on her iPhone, the existing Webster Visa card feed supplies the transaction, and only exceptions require manual review. This is a **mobile-first workflow**; it is not a faster way to use the existing Webster Safari portal.

## 1. First, understand what SmartScan does—and does not do

SmartScan is the receipt-reading engine. It extracts the **merchant, date, total, and currency** from a receipt image; it does not independently know the correct property, GL account, approval route, or whether the charge is a valid Webster transaction. Those decisions come from the commercial-card feed, the Workspace’s tags/categories, and carefully scoped rules.[1] [2]

> **Key configuration principle:** SmartScan is not configured per person. The automation rules are applied at the **Workspace level**. For the regional manager pilot, use a dedicated pilot Workspace or make sure the workspace contains only users/cardholders who should receive the same coding and approval logic.[3]

| Layer | What it automates | What the manager still does |
|---|---|---|
| SmartScan | Reads merchant, date, total, and currency from the receipt image | Takes a readable photo and verifies an exception when needed |
| Webster Visa commercial feed | Delivers posted card charges to Expensify | Nothing once the correct card is assigned |
| Default categories | Suggests a category from the merchant category code and learned patterns | Overrides only when clearly wrong |
| Merchant Rules | Applies approved Category, Property Tag, description, and other fields from a specific merchant match | Selects a Property only when there is no safe rule |
| Dependent Tags | Limits GL selections to valid choices for a selected Property | Selects the Property for an unmatched/ambiguous item |
| Approval Rules | Sends only the exceptions or policy violations to finance | Replies only if finance asks for clarification |

## 2. Recommended design for this manager

Use a dedicated workspace named **Webster Regional Receipts — Pilot**. Assign only the regional manager’s Webster Visa card during the first pilot. This contains the first iteration of the rules and prevents an incorrect merchant rule from affecting every cardholder.

Use the following coding structure. The finance owner should supply the final mapping; do not build this list from memory or from a partially completed Webster portal transaction.

| Existing business need | Expensify configuration | Recommended setup |
|---|---|---|
| Property Code | **Tag level 1: Property** | Import every valid Property as a tag. Include a code in the visible name only if staff need to see it, e.g., `497 — Grove Park Housing`. |
| GL Code | **Tag level 2: GL Account** or a Category, depending on the accounting model | Use a dependent second-level tag if each Property has a restricted set of permissible GL codes. |
| Expense type | **Category** | Maintain a controlled list such as Lodging, Meals, Supplies, Repairs, Travel, and Contracted Services. |
| Approval | **Tag Approver and Workspace approval flow** | Add only after the matching and coding pilot works. |
| Receipts | **Workspace receipt rules** | Require a receipt from $0.01 if company policy requires an image for every Webster charge. |

Expensify Tags are intended for accounting/reporting values such as cost centers, classes, projects, locations, customers, and jobs. Its Control Workspace supports multi-level tags, including **dependent** tag levels that filter downstream choices to permitted combinations. Tag data can be imported from a spreadsheet, including GL codes for export.[4]

## 3. One-time administrator setup

### Step 1 — Enable the right Workspace features

The Workspace Admin should open **Workspaces → Webster Regional Receipts — Pilot → More Features** and enable the following:

| Feature | Turn on? | Reason |
|---|---|---|
| Company Cards | **Yes** | Required for the Webster Visa commercial feed and assigned card workflow. |
| Categories | **Yes** | Separates expense type from Property/GL accounting codes. |
| Tags | **Yes** | Holds the Property and, where needed, GL coding. |
| Rules | **Yes** | Enables receipt policy, merchant automation, eReceipts, and exception visibility. |
| Workflows / Approvals | **Yes, but keep simple in pilot** | Sends exceptions to the finance owner without creating a multi-step burden. |

### Step 2 — Connect and assign the Webster card

Complete the VCF commercial-feed setup before asking the manager to use the app. The published Expensify path is **Workspaces → [Workspace] → Company Cards → Add Cards → Commercial Feed → Visa Commercial Cards**, then enter the Processor ID, Bank/Financial Institution ID, and Company ID supplied by Webster.[5]

Once Expensify confirms the feed is connected, go to **Company Cards → [Webster connection] → Assign card**. Assign the manager’s card to her company email and set a future **Transaction start date** for the pilot. Posted transactions from that date forward import to the assigned member’s Expensify account.[6]

### Step 3 — Import Property and GL Tags

Create a finance-approved CSV with the following conceptual structure. The exact import template should be downloaded from Expensify before upload.

| Property (Tag Level 1) | GL Account (Tag Level 2) | Optional GL code for export | Enabled |
|---|---|---:|---|
| 497 — Grove Park Housing | Repairs & Maintenance | 6XXX | Yes |
| 497 — Grove Park Housing | Lodging | 6XXX | Yes |
| 473 — Silver Springs Housing | Repairs & Maintenance | 6XXX | Yes |
| 473 — Silver Springs Housing | Lodging | 6XXX | Yes |

Configure the two tag levels as **dependent**. The manager selects a Property first, then sees only the GL accounts permitted for that Property. This is safer than exposing one long all-company GL list.

### Step 4 — Require coding without forcing duplicate work

Go to **Workspaces → [Workspace] → Tags/Categories → Settings** and enable **Members must tag or categorize all expenses**. Expensify displays missing coding as a visible attention item for both the submitter and approver; it does not make the field a hard technical stop. Therefore, finance must use the approval review to reject or correct unresolved violations.[7]

For the pilot, make the Property Tag required. Make GL a dependent Tag only if finance truly needs the manager to choose it; otherwise map GL behind the approved Property/Category structure to reduce taps.

## 4. SmartScan configuration for the manager’s iPhone

SmartScan is on in paid group Workspaces and cannot be disabled.[3] Configure the experience around clean capture and minimal manager decision-making rather than trying to tune the OCR engine itself.

### Manager’s normal receipt routine

1. Immediately after the purchase, open the **Expensify** app.
2. Tap the green camera icon and photograph the receipt using the **in-app camera**.
3. Capture the entire receipt: merchant, date, and total must be visible; avoid glare, shadows, folds, and cropped edges.
4. Select the **Webster Regional Receipts — Pilot** Workspace.
5. Confirm the receipt image. SmartScan reads the core fields.
6. Do **not** open Webster Safari, search the photo library, or manually locate the card transaction.
7. If a tested rule fills Category and Property, tap **Create Expense**. If no Property is filled, choose the Property Tag; only select a GL field if it appears and finance has required it.
8. Leave the item in Expensify for the Webster feed to deliver and match the posted transaction. Review only an exception indicator or a finance request.

SmartScan needs a readable **date** and **total** to complete. If it fails, open the failed expense from **Spend → Expenses**, tap the receipt image, select **Replace**, and retake the photo with the full receipt in frame. Expensify recommends the in-app camera because it is optimized for receipt scanning.[1]

| Problem | Manager action | Do not do |
|---|---|---|
| SmartScan cannot read date/total | Retake the photo in the in-app camera with all receipt edges visible | Do not take a screenshot of the receipt or switch to Webster Safari |
| Receipt is a multi-page hotel folio | Attach every page to the same expense and select Lodging | Do not rely on a generic low-dollar receipt rule |
| Posted charge is not yet visible | Wait for the agreed feed timing; do not create a duplicate manual charge | Do not upload the receipt in Webster as a parallel routine |
| SmartScan read a field incorrectly | Correct the item in Expensify and notify finance during pilot review | Do not create a merchant rule based on one unverified scan |
| Receipt is genuinely unreadable | Enter the required expense detail manually in Expensify and note the exception | Do not silently discard the charge |

## 5. Configure auto-categorization and merchant rules

### Step 5A — Start with safe defaults

Use Expensify’s **Default Spend Categories** for broad expense type. Expensify says these may be assigned from the merchant’s MCC and learned merchant-category preferences. Let the system handle high-confidence categories such as airline, hotel, or office supply; use finance review to correct exceptions.[7]

Do **not** use a default category as a property rule. The same Hilton, restaurant, Home Depot, or contractor may relate to different properties. Category can be safely generalized more often than Property.

### Step 5B — Build a small Merchant Rules file

After the first 10–20 pilot receipts, export/review the merchant strings and build rules for only the repeat patterns that are truly unambiguous. Go to **Workspaces → [Workspace] → Rules → Merchant → Add merchant rule**. Rules may set Merchant name, Category, Tag, Description, reimbursable/billable status, and tax.[8]

Use the following rule decision table.

| Merchant pattern | Rule type | Auto-fill | Should it auto-fill Property? | Reason |
|---|---|---|---|---|
| A vendor used only for one named property | **Matches exactly** | Category + Property Tag + known description | **Yes** | The merchant/property relationship is stable and validated. |
| A generic hotel brand used across properties | **Matches exactly** | Category = Lodging | **No** | The hotel does not prove which property should carry the cost. |
| A common retailer used across many properties | **Matches exactly** | Category = Supplies or Repairs, if validated | **No** | Property must remain a manager/finance decision. |
| Merchant string varies by store number | Start with a few exact rules; then test **contains** | Category only | **Usually no** | Broad contains rules can falsely match other merchants. |
| One-off contractor or unusual vendor | No rule at first | No auto-fill | **No** | Wait for a repeated, auditable pattern. |

Merchant Rules apply when an expense is created, are Workspace-wide, and do not overwrite a field the manager entered manually. Use **Preview matches** before saving a rule and begin with exact merchant matching. Expensify specifically warns that broad “contains” logic can match unintended merchants.[8]

### Step 5C — Recommended first 30-day rule set

| Configuration | Initial setting | Review point |
|---|---|---|
| Merchant Rules | Begin with 5–10 rules, not 50 | Add rules only after two or more correctly coded examples, unless finance certifies the mapping. |
| Property auto-fill | Allow only for property-exclusive merchants | Finance reviews every new Property rule before activation. |
| GL auto-fill | Map through dependent Property → GL tags or accounting export mapping | Do not create a generic merchant → GL rule if the Property can change. |
| Receipt requirement | Use the organization’s policy; $0.01 if every card charge needs an image | Review whether eReceipts reduce low-dollar receipt collection without creating compliance gaps. |
| eReceipts | Optional for qualifying USD card transactions at $75 or below | eReceipts do not cover all categories, including lodging.[9] |
| Auto-approval | **Off during pilot** | Consider only after a month of clean matching and exception data. |

## 6. Weekly exception review

For the first month, the finance owner should review a short report each week. The goal is to increase automatic matching and coding **without creating silent miscodes**.

| Measure | Week 1 target | Month 1 target | Corrective action if missed |
|---|---:|---:|---|
| Manager capture time | Under 30 seconds per receipt | Under 15 seconds per ordinary receipt | Simplify the required fields; retrain photo capture; remove unnecessary tags. |
| SmartScan readable-receipt success | At least 90% | At least 95% | Check lighting, capture behavior, and recurring receipt types. |
| Correct automatic Category | At least 80% | At least 95% for ruled merchants | Narrow/repair merchant rules. |
| Correct Property auto-fill | 100% for every auto-filled case | 100% | Disable any rule that creates one incorrect property coding. |
| Exceptions requiring manager input | Under 30% | Under 15% | Add only validated property-exclusive merchant rules. |
| Webster Safari uploads | Zero routine uploads | Zero routine uploads | Reinforce that Expensify—not Safari—is the normal receipt workflow. |

## 7. Ready-to-send Webster support email

**To:** [Webster Program Administrator or Relationship Manager]  
**Cc:** [Finance Owner], [Expensify Workspace Admin], [IT/Security Contact if applicable]  
**Subject:** Request to enable Visa Commercial Format feed to Expensify for iPhone-only receipt workflow

> Hello [Name],
>
> We are implementing Expensify as the mobile receipt and expense-management workflow for our existing **Webster Visa Commercial Card** program. Our objective is to eliminate manual iPhone Safari receipt uploads: cardholders will photograph receipts in the Expensify iPhone app, and Expensify will match those images to Webster Visa transactions delivered through a commercial card feed.
>
> Please confirm whether our Webster commercial-card program is eligible for a **Visa Commercial Format (VCF)** feed to Expensify. If eligible, please enable the feed through Visa’s Subscription Management portal for delivery to Expensify. Expensify’s published guidance states that no test file is required for this bank-side VCF enablement.
>
> Please provide the following information through a secure channel to our authorized Expensify Workspace Admin, [Name / Company Email]:
>
> 1. **Processor ID**
> 2. **Financial Institution / Bank ID**
> 3. **Company ID**
> 4. Confirmed feed start date and expected delivery cadence
> 5. Whether the feed sends posted transactions only or also supports real-time/pending transaction alerts
> 6. The implementation contact who can coordinate any feed questions with Expensify
> 7. Confirmation that enabling the feed will not alter our cardholder privileges, liability arrangement, payment responsibility, or existing Webster card-program terms
>
> Our pilot will begin with one regional manager and her existing Webster Visa card. We will use Expensify as the routine receipt capture, coding, and approval workflow after successful testing. We will retain the Webster portal only for card administration and non-routine exceptions, subject to our internal policy.
>
> Please let us know whether you require any authorization form, technical contact, or additional implementation information from us.
>
> Thank you,
>
> [Name]  
> [Title]  
> [Company]  
> [Phone]  
> [Company Email]

## References

[1] [Expensify Help — Troubleshoot SmartScan Issues](https://help.expensify.com/articles/new-expensify/reports-and-expenses/Troubleshoot-SmartScan-Issues.html). SmartScan extraction, readable date/total requirement, capture guidance, and retry process.

[2] [Expensify Help — Create an Expense](https://help.expensify.com/articles/new-expensify/reports-and-expenses/Create-an-Expense.html). SmartScan mobile capture and the fields that Workspace Merchant Rules may apply.

[3] [Expensify Help — Workspace Rules](https://help.expensify.com/articles/new-expensify/workspaces/Workspace-Rules.html). Workspace-level rules and SmartScan availability in paid group Workspaces.

[4] [Expensify Help — Create and Manage Expense Tags](https://help.expensify.com/articles/new-expensify/workspaces/Create-and-manage-expense-tags.html). Tags, dependent multi-level tags, imports, and GL codes.

[5] [Expensify Help — Set Up a Commercial Card Feed Connection](https://help.expensify.com/articles/new-expensify/connect-credit-cards/Set-up-a-Commercial-Card-Feed-Connection.html). Visa VCF feed request and connection steps.

[6] [Expensify Help — Assign Company Cards](https://help.expensify.com/articles/new-expensify/connect-credit-cards/Assign-Company-Cards.html). Card assignment and transaction start date behavior.

[7] [Expensify Help — Require Tags and Categories for Expenses](https://help.expensify.com/articles/new-expensify/workspaces/Require-tags-and-categories-for-expenses.html). Required Tag/Category behavior and default spend categories.

[8] [Expensify Help — Workspace Merchant Rules](https://help.expensify.com/articles/new-expensify/workspaces/Workspace-Merchant-Rules.html). Merchant rule fields, Preview matches, and matching cautions.

[9] [Expensify Help — Configure Company Card Settings](https://help.expensify.com/articles/new-expensify/connect-credit-cards/Configure-Company-Card-Settings.html). eReceipt eligibility and configuration.
