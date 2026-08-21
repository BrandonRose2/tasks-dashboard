# Copy-and-Paste Prompts for a Mobile Receipt App

## Read this first

The public site at [ripple.com](https://ripple.com/) currently describes a financial-infrastructure and blockchain company rather than a public prompt-to-build business-app product.[1] If you mean a different Ripple product in which you have an app-builder workspace, use the prompts below exactly as a **staged build specification**. If that product has a different name or URL, send it to me and I will adapt the wording to its exact prompt format.

> **Do not ask the builder to log in to Webster, scrape the Commercial Card Portal, use banking credentials, or imitate browser clicks.** The app should use a manual CSV import during the pilot and a future **approved** Webster/Visa commercial-card feed or API after the bank authorizes it. This keeps the app secure and avoids building an unreliable workaround around the current mobile portal.

Replace only the bracketed terms before pasting. Do not paste all prompts at once. Build in this order, review each result, then submit the next prompt.

| Replace this field | With |
|---|---|
| `[COMPANY NAME]` | Your company’s legal or operating name |
| `[FINANCE OWNER]` | The person/team responsible for coding and approvals |
| `[COMPANY TIME ZONE]` | Example: `America/New_York` |
| `[CURRENCY]` | Usually `USD` |
| `[RECEIPT POLICY]` | Example: `A receipt image is required for every commercial-card transaction` |
| `[PROPERTY LIST]` | A finance-approved list of properties/cost centers |
| `[GL MAPPING]` | Finance-approved Property-to-GL combinations |

---

## Prompt 1 — Build the secure app shell first

```text
Build a production-quality, mobile-first expense and receipt application named “ReceiptFlow” for [COMPANY NAME]. The primary user is a regional manager who has about 30 Webster Visa commercial-card receipts per day. The core outcome is: capture a receipt on an iPhone in seconds, organize and match it automatically, and send only exceptions to finance.

Create an iPhone-first mobile experience and a responsive browser-based Finance/Admin console. If your platform cannot create a native iOS app, create an installable progressive web app optimized for iPhone Safari, including a prominent camera capture action.

Create these user roles with role-based access control:
1. Regional Manager: captures receipts, views own transactions, resolves only assigned exceptions.
2. Finance Reviewer: reviews exceptions, corrects coding, approves or rejects items, manages matching decisions.
3. Workspace Admin: manages users, properties, GL mappings, policy settings, card-feed connections, and retention settings.
4. Auditor Read-Only: searches data and exports audit reports but cannot change anything.

Create these primary screens:
- Home / Today: a large “Capture Receipt” button, number of receipts captured today, unmatched count, and items needing the manager’s attention.
- Capture Receipt: camera-first flow, photo preview, retake option, multi-page receipt support, and offline queue indicator.
- My Expenses: tabs for Matched, Needs My Input, Processing, and Archived.
- Finance Exception Queue: filterable list of missing receipt, OCR issue, unmatched transaction, duplicate, missing Property/GL, and policy review items.
- Expense Detail: receipt image, extracted OCR fields, transaction information, match confidence, coding, history, and approval controls.
- Admin: users, properties, GL mapping, categories, rules, policy settings, audit log, and integration configuration.

Use a clean operational design: high contrast, large camera action, minimal manager typing, no decorative dashboard clutter, and accessible text/buttons. Use a restrained palette: dark navy, white, neutral gray, and a lime/green accent only for successful automated actions. Make all controls large enough for one-handed iPhone use.

Use only synthetic demonstration data. Include no real banking credentials, full card numbers, CVVs, online-banking passwords, or browser automation. Show an “Integration not configured” state for the card feed.

Create the database schema and seed data for users, properties, GL accounts, permitted Property-to-GL mappings, categories, receipts, transactions, expenses, matches, merchant rules, approval decisions, notifications, and immutable audit events. Use [CURRENCY] and [COMPANY TIME ZONE].
```

**Review before moving on:** Confirm the manager can reach the camera in one tap, finance has a separate exception queue, and the app shows a clearly separate **unconfigured card-feed** state.

---

## Prompt 2 — Add iPhone receipt capture and OCR

```text
Extend ReceiptFlow with a fast iPhone receipt-capture workflow. The manager should be able to complete ordinary capture in under 15 seconds.

Implement this exact behavior:
1. The home screen has a fixed, prominent “Capture Receipt” button.
2. Open the device camera directly. Also allow import from the photo library only as a fallback.
3. Display an on-screen capture guide: “Include the entire receipt. Keep merchant, date, and total visible. Avoid glare, shadows, and folds.”
4. After capture, run OCR and extract merchant, transaction date, total, tax if available, currency, and a short item/description summary if reliable.
5. Preserve the original image. Show OCR confidence separately for merchant, date, and total.
6. Support multi-page receipts and hotel folios. Let the manager add pages to one receipt record.
7. Upload encrypted receipt files to secure storage. If offline, queue the upload locally and retry automatically when the app regains a network connection. Clearly show pending sync status.
8. After OCR, show a compact confirmation view. If high-confidence fields are found, do not force the manager to type them again.
9. If the date or total has low confidence or is missing, ask the manager to correct only the uncertain field. Offer “Retake photo” first.
10. Create an expense record in Processing status, ready to match against a future imported card transaction.

Add a duplicate-receipt check using image hash, total, date range, merchant similarity, and the submitting user. Do not block a potential duplicate automatically; show it as a clear warning for finance review.

Create a receipt-quality score from 0–100. Use visual labels only: Good to Process, Check Details, or Retake. Do not claim perfect OCR accuracy.

For the initial pilot, require receipts according to this policy: [RECEIPT POLICY]. Make the threshold editable by a Workspace Admin.
```

**Review before moving on:** Test with a clear receipt, a faded receipt, a multi-page hotel folio, and an offline capture. Make sure a failed scan never loses the image.

---

## Prompt 3 — Build the transaction-import and matching engine

```text
Add a secure transaction-import and receipt-matching module to ReceiptFlow. The initial pilot must work without a direct bank integration. Build an adapter-based architecture so an approved Webster/Visa commercial-card feed can be added later without changing the user interface.

For Phase 1, create a Workspace Admin import screen that accepts CSV transaction files with these required fields: external_transaction_id, cardholder_email, transaction_date, posted_date, merchant_name, amount, currency, transaction_status, and last_four_digits. Add optional fields for merchant_category_code, card_account_reference, and statement_reference.

Validate the file before import. Show clear row-level errors, duplicate transaction prevention using external_transaction_id, import preview, import result, and audit log entries. Never accept full card numbers, CVVs, passwords, or online-banking credentials.

Implement a matching service with these inputs:
- Amount similarity: exact amount is strongest.
- Date tolerance: prefer the same day; support a configurable ±3-day window.
- Merchant similarity: normalize common abbreviations, store numbers, punctuation, and casing.
- Cardholder: match only the same assigned cardholder unless Finance explicitly overrides.
- Currency: must match exactly.

Create a transparent match score from 0–100 and show why the score was calculated. Use these default routing rules, all editable by a Workspace Admin:
- 90–100: auto-match only if there is exactly one candidate and amount/currency/cardholder match.
- 70–89: “Review Suggested Match” for Finance; do not auto-match.
- Below 70: remain unmatched.
- Any multiple-candidate situation: send to Finance exception queue even if a score is high.

When a match occurs, preserve a link between the immutable receipt and transaction records, create an Expense record, and log the matching reason, confidence, actor, date/time, and any later override. Finance can manually match or unmatch items, but the app must require a reason and create an audit event.

Create the future integration interface named CommercialCardFeedProvider with placeholder methods for validateConnection, syncTransactions, and getSyncStatus. Show this message in the UI until a bank approves the connection: “Webster commercial-card feed is not yet configured. Use approved CSV import for the pilot.”

Do not build any automation that logs into, scrapes, or sends requests to the Webster Commercial Card Portal.
```

**Review before moving on:** Import a synthetic CSV of 30 transactions. Confirm that the system auto-matches only unambiguous high-confidence items and routes ambiguities to Finance.

---

## Prompt 4 — Add Property, GL, category, and merchant-rule controls

```text
Add finance-controlled coding to ReceiptFlow. The design must reduce manager taps without creating hidden miscodes.

Create these fields on every Expense:
- Property / Cost Center: required for final approval.
- GL Account: required only where [FINANCE OWNER] requires it.
- Expense Category: required.
- Optional business purpose / note.
- Policy status.

Load the following approved structures from Admin-importable CSV templates:
1. Property list: [PROPERTY LIST]
2. Permitted Property-to-GL mappings: [GL MAPPING]
3. Expense categories: Lodging, Meals, Supplies, Repairs & Maintenance, Travel, Contracted Services, and Other. Allow Admin editing.

Implement dependent coding: after a Property is selected, show only GL accounts permitted for that Property. Finance must be able to import and edit this mapping. Regional Managers may choose a Property but may not create a Property or GL account.

Create Merchant Rules with these fields: exact merchant match or contains match, Category, Property, GL Account, default description, active/inactive, effective date, created by, approved by, and rule notes.

Apply strict safety rules:
- Support exact merchant matching as the default rule type.
- A Property can be auto-filled only when the rule is marked “Property-exclusive” and is approved by [FINANCE OWNER].
- Shared merchants such as hotels, retailers, and restaurants may auto-fill Category but must not auto-fill Property by default.
- A rule may never overwrite a field manually entered by the manager or Finance.
- Before activating a rule, show Finance a Preview Matches view with the last 30 matching transactions.
- Any manually changed auto-filled value should create a “Rule correction signal” for Finance.
- Finance can disable a rule immediately; changes must be audited.

Create a “Needs My Input” manager flow that asks only for the missing Property and, if required, an allowed GL account. Do not ask the manager to select a GL account if Finance has configured a correct automatic downstream mapping.
```

**Review before moving on:** Create one property-exclusive vendor rule, one shared-hotel category-only rule, and one new-vendor exception. Verify that the app does not auto-code a Property for the shared hotel.

---

## Prompt 5 — Add exception review, approvals, and manager notifications

```text
Build the exception-management and approval workflow in ReceiptFlow. Finance should work from one queue; regional managers should receive only simple, actionable correction requests.

Create these exception types:
- Missing receipt
- OCR confidence too low
- Missing date or total
- Duplicate receipt warning
- Unmatched transaction
- Multiple possible matches
- Missing Property
- Missing GL Account when required
- Category needs review
- Policy violation
- Rule correction signal
- Transaction import error

Create an Finance Exception Queue with filters for exception type, manager, property, category, date, amount, aging, match score, and status. Support bulk assignment to a Finance Reviewer but require a decision/reason for bulk approve, reject, or return actions.

Create these approval states: Processing, Needs Manager Input, Ready for Finance Review, Approved, Rejected, Exported, and Archived. Keep prior status history immutable.

When Finance returns an item, send the manager a concise in-app notification with one requested action, for example: “Select the Property for $84.16 at Home Depot on July 18.” Do not expose finance-only internal notes to the manager.

Create a daily manager view showing: captured today, processing, needs my input, and resolved. Add an optional end-of-day reminder only if items remain in Needs My Input; do not send notifications for items that are processing normally.

Create a policy dashboard for Finance with receipt completion rate, average OCR confidence, match rate, exceptions by type, exception aging, rule overrides, and manager touch time. Use anonymized synthetic data until production data is available.
```

**Review before moving on:** Simulate a missing Property, multi-match, unreadable receipt, and duplicate warning. Confirm the manager gets a short correction request while Finance sees the full audit context.

---

## Prompt 6 — Add security, audit, and pilot controls

```text
Harden ReceiptFlow for a controlled business pilot. Do not market the app as bank-integrated until an approved Webster/Visa commercial-card feed is configured.

Implement these controls:
- Role-based access for Regional Manager, Finance Reviewer, Workspace Admin, and Auditor Read-Only.
- Least-privilege data access: managers see only their own receipts/expenses; finance sees assigned business scope; auditors are read-only.
- Encrypt receipt documents in transit and at rest using the platform’s managed encryption capabilities.
- Do not store online-banking credentials, full card numbers, CVVs, or bank-login session tokens.
- Use masked last four digits only for transaction display.
- Maintain immutable audit events for sign-in, receipt upload/replace/delete request, OCR edits, transaction imports, match/unmatch, coding changes, rule changes, approvals, rejections, exports, and role changes.
- Add configurable document retention and deletion-review settings. Do not permanently delete records without an Admin confirmation and an audit entry.
- Export audit and expense data to CSV with date range, Property, cardholder, status, and approval filters.
- Add a Data Sources page that labels each transaction source as “Manual CSV Pilot Import” or “Approved Commercial Card Feed.”
- Add a non-production banner when synthetic/demo data is active.

Build a Pilot Readiness checklist visible only to Workspace Admin. It must require: roles configured, finance-approved Property/GL mapping imported, receipt policy selected, test CSV imported, 10 synthetic receipts processed, exception tests passed, and an approved card-feed decision recorded as either “CSV pilot only” or “Approved provider configured.”
```

**Review before moving on:** Verify that a Regional Manager cannot see another manager’s expenses, cannot edit rules, and cannot access integration credentials or audit exports.

---

## Prompt 7 — Run a realistic 30-receipt acceptance test and polish the workflow

```text
Create a complete in-app Pilot Test Mode for ReceiptFlow using synthetic data. Simulate one regional manager processing 30 receipts and 30 commercial-card transactions across five business days.

Include these scenarios:
- 20 straightforward unique receipt-to-transaction matches.
- 3 receipts with low OCR confidence.
- 2 receipts with multiple possible transaction matches.
- 2 shared-merchant purchases where only Category auto-fills and Property remains required.
- 1 property-exclusive vendor where Category and Property safely auto-fill.
- 1 duplicate-receipt warning.
- 1 missing receipt transaction.

Create an Admin-visible pilot scorecard that calculates:
- first-capture receipt time;
- OCR readable-receipt rate;
- auto-match rate;
- finance-review exception rate;
- number of incorrect automatic Property codes;
- number of routine portal-upload steps required (this must be zero in the app workflow);
- outstanding items by aging.

Use these initial pilot gates:
- Ordinary receipt capture under 15 seconds.
- At least 90% of ordinary receipt images readable on first capture.
- At least 9 of 10 ordinary items correctly auto-matched or needing only simple Finance review.
- Zero incorrect automatic Property assignments.
- No loss of a receipt image after an OCR, upload, or matching failure.

Polish the iPhone workflow to minimize taps. Keep the manager’s standard path to: Capture Receipt → Confirm → Continue. Move all advanced details, finance controls, and administration away from the manager’s main screen.

At the end of test mode, show a launch recommendation: Ready for controlled pilot, Needs rule corrections, or Needs feed/import corrections. Explain the reason using the scorecard, not generic text.
```

---

## Optional final prompt — Prepare the approved Webster/Visa feed without activating it

Use this **only after** Webster confirms that the proposed connection method is allowed.

```text
Add an Approved Commercial Card Feed configuration workflow to ReceiptFlow, but keep it disabled until [FINANCE OWNER] marks bank authorization as complete.

The configuration must support an approved provider connector rather than browser automation. Require Workspace Admin entry of provider-issued identifiers and secrets through a secure server-side secrets mechanism. Never expose secrets to a mobile device, browser client, audit export, or ordinary application logs.

Show the required connection fields only after the provider type is selected. Include connection test, least-privilege permission explanation, sync schedule, sync status, last successful sync, failed-sync alerts, and a reversible disconnect flow. Keep manual CSV import available during initial validation.

When a provider is configured, label the source clearly with the provider name, transaction timing, and whether records are posted-only or pending. Continue to use the same matching, coding, approval, security, and audit controls already built in the app.

Do not create, update, delete, submit, pay, or otherwise change any Webster card-program data. The integration is read-only for transaction retrieval unless an explicit, documented, provider-approved scope is later added by the company.
```

## References

[1] [Ripple — Financial Infrastructure & Blockchain Technology Solutions](https://ripple.com/).

[2] [Expensify Help — Set Up a Commercial Card Feed Connection](https://help.expensify.com/articles/new-expensify/connect-credit-cards/Set-up-a-Commercial-Card-Feed-Connection.html). This is included only as an example of a bank-authorized commercial-card-feed approach; it does **not** confirm a custom app’s ability to connect to Webster.
