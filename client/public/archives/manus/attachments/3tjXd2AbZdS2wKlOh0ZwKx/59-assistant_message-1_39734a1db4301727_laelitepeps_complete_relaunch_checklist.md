# LA Elite Peptides Website Relaunch Checklist

**Purpose.** This document is a self-contained checklist for rebuilding and relaunching the LA Elite Peptides website from the GitHub repository [`EKhelil11/website-peptide`](https://github.com/EKhelil11/website-peptide) in a **new full-stack Manus project**, then safely reconnecting `laelitepeps.com`. It is written for the project owner or administrator to follow in sequence.

> **Do not begin any custom-domain or DNS change until the new temporary Manus URL is fully working.** The source repository can recreate the application, but it cannot recreate historic data from the unavailable project.

## 1. Understand the Current Situation

The original site is reaching the Manus/Cloudflare edge, but it is not currently routing to a usable project. The public domain and `www` resolve, yet the live response is Manus’s standard maintenance page: **HTTP 503** with `x-manus-original-status: 404`. This indicates a missing, unavailable, or stale project binding—not a domain-registration or ordinary TLS-certificate failure. [1]

The owner restored the Manus account but does **not** have the original Task Data Backup. Account restoration by itself does not restore the WebDev project’s code, database, file storage, checkpoints, secrets, or deployment. The GitHub repository is therefore the practical source for a new deployment. [2]

| Verified fact | What it means |
|---|---|
| `laelitepeps.com` and `www.laelitepeps.com` reach the Manus/Cloudflare edge | Do not transfer the domain or replace nameservers as a first response. |
| Live response is 503 with an underlying 404 | The old project binding is not a working website target. |
| DNS delegates to `ns1.globaldomaingroup.com` and `ns2.globaldomaingroup.com` | The authoritative DNS manager is likely Global Domain Group, not Cloudflare or GoDaddy, unless DNS was separately delegated. [3] |
| Google MX routing is present | Preserve Google email routing and related TXT records. [4] |
| No Task Data Backup exists | Historic orders, customer accounts/passwords, uploads, database records, and project settings cannot be restored from the source repository. |

## 2. Follow This Order

The safe sequence is **GitHub repository → new full-stack Manus project → new database/configuration → temporary Manus URL → testing → domain connection → final verification**. The domain-reconnection instructions are appropriate only after there is a real, tested destination project.

| Stage | Stop condition | Do not proceed until |
|---|---|---|
| 1. Preserve source | The repository is safely copied and reviewed | The current source remains intact and no secrets are committed. |
| 2. Build the replacement | A new full-stack project has deployed | The temporary Manus URL loads. |
| 3. Configure services | Database/authentication work | Controlled tests create and retrieve data correctly. |
| 4. Verify integrations | Required external features work or are intentionally disabled | The owner understands what is and is not operational. |
| 5. Connect domain | The owner explicitly approves cutover | The temporary URL has passed the go/no-go gate. |
| 6. Verify production | Root, `www`, HTTPS, and email are intact | The four URL checks and business-critical tests pass. |

## 3. Protect the Repository Before Deployment

Complete these items in GitHub before creating the new Manus task. These steps protect the only available source copy and prevent accidental secret exposure.

- [ ] Confirm the repository URL is `https://github.com/EKhelil11/website-peptide` and the intended source branch is identified.
- [ ] Record the current commit SHA. The previously reviewed repository commit was `f64a146` dated July 1, 2026; use GitHub history to confirm whether a newer intended commit exists.
- [ ] Create a recovery branch or Git tag before any edits. Do not force-push, delete history, rename the repository, or overwrite `main` during the recovery effort.
- [ ] Confirm that `.env`, exported database files, API keys, passwords, token files, and real customer data are not committed. Never paste secrets into GitHub issues, task chat, source comments, build logs, screenshots, or attachments.
- [ ] Keep `pnpm-lock.yaml` in the repository. It pins the dependency graph used for the validated build.
- [ ] Do not remove Drizzle migration files under `drizzle/`. They are needed to create the empty replacement database schema.
- [ ] Do not replace packages solely to silence non-blocking build warnings. Preserve behavior unless an actual build or runtime error requires a targeted change.

### Safe Local/Terminal Validation

Use this only against a local clone or the new project’s working copy. It does not deploy, change DNS, send email, or create orders.

```bash
gh repo clone EKhelil11/website-peptide
cd website-peptide
pnpm install --frozen-lockfile --ignore-scripts
pnpm check
pnpm build
```

The repository previously completed all three checks successfully. The production build generated frontend files in `dist/public` and a server bundle at `dist/index.js`. It emitted only non-blocking warnings for undefined optional Umami analytics variables and a large JavaScript bundle. [5]

> Do not run production tests that create real orders, payments, fulfillment labels, customer emails, or shipments. Use owner-controlled test accounts and harmless test data only.

## 4. Recognize What This Repository Is

This is **not** a static website. It is a full-stack TypeScript commerce application with a React/Vite frontend, a Node/Express server, tRPC APIs, Drizzle ORM, and MySQL. It also contains customer accounts, an owner/admin workflow, orders, order-status history, transactional email, storage functions, and ShipStation integration. The new Manus project must be deployed as a **full-stack WebDev project**, not as a static-only site. [5]

| Included in source code | Not included in source code |
|---|---|
| Application code and user interface | Historic production database records |
| Database schema and Drizzle migrations | Existing customer passwords/sessions |
| Cart/order and customer-account logic | Existing orders, payment notes, or shipment history |
| Email, storage, and ShipStation integration code | Existing API keys, secrets, OAuth tokens, and runtime settings |
| Static assets committed to GitHub | Files that existed only in the lost project storage |

## 5. Create the New Manus Project

Start a **new task in the personal Manus account that owns the project and domain**, not in another person’s personal or team workspace. Give the task the repository URL and direct it to create a new **full-stack** project. It should inspect the repository before modifying code and should use a new, empty project database.

- [ ] Import or clone `https://github.com/EKhelil11/website-peptide`.
- [ ] Create a full-stack project with a Node/Express backend and MySQL-compatible database support.
- [ ] Keep the project private or temporary until the owner has completed testing.
- [ ] Install dependencies from the existing lockfile, run `pnpm check`, and run `pnpm build`.
- [ ] Fix only verified build/runtime blockers. Do not redesign the storefront or substitute business behavior during recovery.
- [ ] Publish to the temporary Manus URL first. Do **not** connect `laelitepeps.com` at this stage.
- [ ] Record the temporary URL and use it throughout the test checklist below.

## 6. Configure Environment Variables Securely

The new deployment requires fresh configuration. Enter secrets only in the secure settings of the new project. Never reveal their values in the task conversation or repository.

| Environment variable or capability | Priority | Purpose | Required action |
|---|---:|---|---|
| `DATABASE_URL` | **Required** | MySQL-compatible database connection | Create the new database and enter the connection value only in secure project settings. |
| `JWT_SECRET` | **Required** | Session/cookie security | Generate a fresh, strong value and keep it stable across redeployments. |
| `VITE_APP_ID` | Required for this code’s Manus/owner flow | Application identity | Configure through the new project/runtime as instructed; do not invent a placeholder. |
| `OAUTH_SERVER_URL` | Required for Manus OAuth/admin flow | OAuth callback/service endpoint | Configure securely, then test owner sign-in. |
| `OWNER_OPEN_ID` | Required for owner admin role assignment | Identifies the intended owner/admin | Confirm it maps only to the proper owner identity. |
| `BUILT_IN_FORGE_API_URL` | Needed for Manus-backed data/storage features | Manus service endpoint | Configure through the new full-stack project’s secure settings. |
| `BUILT_IN_FORGE_API_KEY` | Needed for Manus-backed data/storage features | Secure access token | Configure securely; never copy from an old log or placeholder. |
| `RESEND_API_KEY` | Optional until transactional email is enabled | Order, payment, verification, and shipping email | Leave email features documented as disabled if it is not yet available. |
| `SHIPSTATION_API_KEY` and `SHIPSTATION_API_SECRET` | Optional until fulfillment/tracking is enabled | Shipping and tracking integration | Do not configure guessed values or create a live shipment during testing. |
| `VITE_ANALYTICS_ENDPOINT` and `VITE_ANALYTICS_WEBSITE_ID` | Optional | Umami analytics | Configure only if analytics is wanted; warnings are non-blocking. |
| `NODE_ENV` and `PORT` | Platform-managed | Runtime mode/server port | Do not hard-code unless the hosting environment specifically requires it. |

### Environment-Inventory Script

The attached `check_env_requirements.sh` script from the earlier review can scan the repository using the GitHub CLI without revealing values. It reports variable names and categories only.

```bash
bash check_env_requirements.sh EKhelil11/website-peptide
```

The script performs a temporary, read-only clone when no local directory is provided and deletes that temporary copy after its scan. “Not present in this shell” does **not** prove a secret is absent from Manus project settings; it simply means the variable was not exposed to that terminal session.

## 7. Create and Verify the New Database

Use a new, empty database. Do not point the replacement application at an unknown existing database in an attempt to recover lost data.

- [ ] Configure `DATABASE_URL` using the secure project setting.
- [ ] Apply the included Drizzle migrations to the new database.
- [ ] Confirm the database contains `users`, `orders`, `order_items`, `order_status_history`, `customers`, and `customer_sessions`.
- [ ] Confirm the database service account has the required read/write permissions.
- [ ] Open the customer and admin sections before creating test data. Empty lists are normal on a new database and are not by themselves an outage.
- [ ] Create a customer using an owner-controlled test mailbox. Verify a customer record is created and the password is never displayed or stored as raw text.
- [ ] Sign out and sign back in with the test account. Confirm protected routes require authentication and the session is created/inactivated correctly.
- [ ] Create one clearly marked, non-live test order with an owner-controlled test address. Confirm that order, order items, and an initial status-history row are saved.
- [ ] Confirm the intended owner has admin access and a normal customer account does not.

The sender address in the code is `noreply@laelitepeps.com`. Before enabling production email, confirm the selected email provider authorizes that sending identity. A working website does not prove email delivery is authorized.

## 8. Test the Temporary Manus URL

Perform all testing on the temporary Manus URL first, preferably in a private/incognito browser session as well as a normal session. Keep a short timestamped record of failures, but remove all secret values from screenshots and logs.

- [ ] Homepage loads over HTTPS with no 5xx response.
- [ ] Product catalogue, product details, static imagery, prices, research-use/legal content, and navigation render correctly.
- [ ] Add an item to the cart, change its quantity, and remove it.
- [ ] Customer-only routes reject unauthenticated visitors and allow the owner-controlled test customer after sign-in.
- [ ] Customer registration, verification workflow if enabled, sign-in, sign-out, and password/session behavior work as intended.
- [ ] A controlled test order persists in the database with matching item lines and status history.
- [ ] The owner/admin can access the intended administration features; a regular customer cannot.
- [ ] If storage/uploads are in scope, upload and retrieve a harmless test file. If storage is not configured, document the feature as disabled.
- [ ] If Resend is configured, send one test message only to an owner-controlled mailbox. If it is not configured, document that transactional email is disabled.
- [ ] If ShipStation is configured, verify credentials or a safe test path without generating a real label or shipment. If it is not configured, document that fulfillment automation is disabled.
- [ ] Review browser network activity and deployment logs. There should be no repeated API 4xx/5xx errors, unhandled exceptions, storage failures, or authentication loops.
- [ ] Repeat the key customer and owner tests after a clean sign-out/sign-in.

## 9. Error Messages That Require Attention

The following messages or patterns are relevant to this repository. Treat the items marked **blocker** as a no-go for custom-domain cutover until resolved.

| Message or pattern | Likely meaning | Cutover decision |
|---|---|---|
| `Could not find the build directory: ... make sure to build the client first` | The server cannot find the compiled frontend. | **Blocker:** run/fix the production build and redeploy. |
| `%VITE_ANALYTICS_ENDPOINT% is not defined` or `%VITE_ANALYTICS_WEBSITE_ID% is not defined` | Optional Umami analytics values are absent. | Non-blocking if analytics is intentionally disabled. |
| `[Database] Failed to connect:` | Database URL, credentials, network access, or service health is wrong. | **Blocker:** fix connection and retest persisted data. |
| `[Database] Cannot upsert user: database not available` or `Database not available` | Required database operation cannot be completed. | **Blocker:** verify database configuration, permissions, and migrations. |
| `ER_NO_SUCH_TABLE`, “table does not exist,” missing-column error, or migration error | Database schema/migrations are incomplete. | **Blocker:** apply and verify Drizzle migrations. |
| `ER_ACCESS_DENIED_ERROR` or database authentication failure | The database user lacks valid access. | **Blocker:** correct credential/permissions securely. |
| `[OAuth] ERROR: OAUTH_SERVER_URL is not configured!` | Owner/admin OAuth is not configured. | **Blocker** for owner-admin workflow: configure and retest login. |
| `OAuth callback failed`, `code and state are required`, or `openId missing from user info` | OAuth callback configuration or identity data is incomplete. | **Blocker** for owner-admin workflow: fix and retest in a clean session. |
| `[Auth] Missing session cookie`, `Session payload missing required fields`, or `Session verification failed` | Session/JWT/cookie handling is not reliable. | **Blocker:** verify `JWT_SECRET`, HTTPS, and login flow. |
| HTTP `401 UNAUTHORIZED` or `403 FORBIDDEN` from customer/admin API calls | Authentication or role assignment is incorrect. | **Blocker:** verify customer restrictions and owner/admin mapping. |
| `Storage proxy not configured`, `Storage backend error`, `Storage proxy error`, `Empty signed URL from backend`, or `Missing storage key` | Manus-backed storage is missing or unavailable. | Block upload/storage features until securely configured and retested. |
| `[Email] RESEND_API_KEY not set — skipping order email` | The website can browse/order, but transactional messages are not sent. | Non-blocking only if email is intentionally disabled and documented. |
| Email `401`, `403`, invalid-key, or sender-domain-not-verified response | Email credential or sender identity is invalid. | Keep email features disabled until corrected. |
| `ShipStation API credentials not configured` | Fulfillment integration is not configured. | Non-blocking only while shipping automation is disabled. |
| `ShipStation POST ... → 401`, `403`, or another `4xx/5xx` response | ShipStation rejected the request or credentials. | Do not use fulfillment automation for customer orders until fixed. |
| HTTP `502`, `504`, `Failed to fetch`, or recurring tRPC API failures | Backend or upstream service is unavailable/misconfigured. | **Blocker:** inspect the matching deployment-log entry. |
| Manus maintenance page, HTTP `503`, or `x-manus-original-status: 404` | The target is not a working published project/domain binding. | Do not make broad DNS changes; verify the temporary project is published first. |

## 10. Go/No-Go Gate Before Connecting the Domain

The owner should approve the custom-domain cutover only after every applicable statement below is true.

- [ ] The temporary Manus URL is deployed and loads reliably in a private browser window.
- [ ] The new database connects, all migrations are applied, and controlled test data persists correctly.
- [ ] Customer authentication, session handling, and owner/admin authorization work correctly.
- [ ] Required storage, email, and ShipStation capabilities work, or each disabled capability is explicitly documented and accepted by the owner.
- [ ] No unresolved database, authentication, storage, deployment, or recurring 5xx errors remain.
- [ ] The owner understands that historic orders, customers, passwords, uploads, and production database data are not recovered by the GitHub source deployment.
- [ ] The owner has explicitly approved the connection of the existing public domain to the new, tested project.

## 11. Connect `laelitepeps.com` Only After Approval

The published presentation script is correct for the **domain cutover** phase, but it assumes a live destination project exists. Apply it only after the temporary deployment passes the gate above. [6]

1. Open the **new, tested** LA Elite Peptides project in Manus.
2. Inspect **Settings → Domains**. If `laelitepeps.com` is still bound to an old unusable project, disconnect/unbind the root and `www` entries there only after the new destination is ready.
3. In the new project, choose **Connect existing domain** and enter `laelitepeps.com` without `http://`, `https://`, or a trailing slash.
4. Enable **Set up both** so the root domain and `www.laelitepeps.com` are connected together.
5. Set `laelitepeps.com` as the primary host and redirect `www.laelitepeps.com` to it, unless the owner deliberately chooses the reverse.
6. Publish the intended checkpoint/version. Do not assume that connecting a domain alone publishes the application.
7. If the project panel says the domain is connected, do not make DNS changes.
8. If the panel gives DNS records, use exactly its type, host, value, and TTL. Manus may give an **A record or CNAME**, and the actual target is generated for the specific deployment; there is no universal Manus address to pre-enter. [7]

### DNS Safety Rules

| Never change | Change only if Manus’s new project panel explicitly requires it |
|---|---|
| Nameservers: `ns1.globaldomaingroup.com` and `ns2.globaldomaingroup.com` | A conflicting **website** record for root host `@` |
| Google MX record(s) | A conflicting **website** record for `www` |
| Google TXT/SPF/DKIM/DMARC/verification records | The exact A or CNAME value and TTL shown by the new project panel |
| Domain registration or ownership | Nothing else |

Do **not** reuse the currently observed `104.18.26.246` IP address as the new record target. It corresponds to the existing Cloudflare edge response for the unavailable/stale state, not to a confirmed target for the replacement deployment. If a Cloudflare DNS panel does not say whether a record should be proxied, do not guess or change proxy mode; preserve the existing setting or request clarification before saving.

## 12. Final Production Verification

After connection and publishing, wait for the project panel to report the correct binding and for any displayed DNS/TLS validation to complete. Avoid repeatedly disconnecting and reconnecting, because that can restart validation or obscure which configuration is active.

| Address to test | Expected behavior |
|---|---|
| `http://laelitepeps.com` | Redirects to `https://laelitepeps.com/` |
| `https://laelitepeps.com` | Loads the new LA Elite Peptides website without a certificate warning |
| `http://www.laelitepeps.com` | Redirects to HTTPS and then the chosen primary hostname |
| `https://www.laelitepeps.com` | Loads or redirects without a certificate warning |

- [ ] Test all four addresses in a private/incognito window or another device.
- [ ] Confirm the final browser address is the intended primary hostname.
- [ ] Confirm the website no longer returns a 503, maintenance page, 404, or certificate warning.
- [ ] Re-run the key storefront, customer, and admin tests on the custom domain.
- [ ] Confirm business email still sends/receives normally. Do not test by changing email DNS records.
- [ ] Confirm enabled integrations have been reauthorized and tested before accepting live traffic.

## 13. When to Stop and Ask for Help

Stop rather than improvising if the source repository cannot produce a working temporary deployment, the new project lacks required runtime values, database migrations fail, or the Domains panel displays a failure you cannot explain. Capture only the error message, timestamp, relevant non-secret settings names, and affected URL; then contact [Manus Help](https://help.manus.im) from the account that owns the project. Do not transmit secrets or customer data in a support request.

## References

[1] [LA Elite Peptides domain-reconnection assessment](https://www.manus.im/share/file/39861f80-1991-47df-83e2-bd90a130e965)

[2] [Manus: Service Change Overview—How Service Change Affects Your WebDev Projects and Website](https://help.manus.im/en/articles/16354507-service-change-overview-how-service-change-affects-your-webdev-projects-and-website)

[3] [Google Public DNS: NS lookup for laelitepeps.com](https://dns.google/resolve?name=laelitepeps.com&type=NS)

[4] [Google Public DNS: MX lookup for laelitepeps.com](https://dns.google/resolve?name=laelitepeps.com&type=MX)

[5] [GitHub: EKhelil11/website-peptide](https://github.com/EKhelil11/website-peptide)

[6] [LA Elite Peptides domain-reconnection presentation](https://www.manus.im/share/file/76d437e6-bc5e-4a39-9620-5ab1c09938b9)

[7] [Manus: Connect a website to a custom domain](https://help.manus.im/en/articles/11711203-how-can-i-connect-the-website-created-by-manus-to-my-custom-domain)
