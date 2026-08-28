# LA Elite Peptides: Post-Deployment Validation Checklist

This checklist applies to a **new full-stack deployment** created from the [`EKhelil11/website-peptide`](https://github.com/EKhelil11/website-peptide) repository. It assumes the original Task Data was not restored. The newly deployed database will therefore begin empty; its purpose is to confirm that the rebuilt application is safe and operational before `laelitepeps.com` is connected.

> **Do not connect the custom domain or alter DNS until all “before domain cutover” checks below pass on the temporary Manus URL.** Never expose secret values in task chat, source code, screenshots, error reports, or commits.

## 1. Deployment Baseline

| Check | Pass condition | Notes |
|---|---|---|
| Dependencies | Installation completes using the repository lockfile. | Do not replace packages merely to silence warnings. |
| Type check | `pnpm check` passes. | The supplied repository previously passed this check. |
| Production build | `pnpm build` completes and generates the frontend bundle plus server bundle. | The supplied repository previously built successfully. |
| Temporary URL | The newly deployed temporary Manus URL loads over HTTPS without a 5xx error. | Test in an incognito/private window as well as the normal browser. |
| Basic navigation | Homepage, product pages, cart, account pages, and admin sign-in route load. | A route that consistently returns 404, blank content, or an application error needs investigation before cutover. |

The repository contains a React frontend and a Node/Express + tRPC backend. It is **not** suitable for static-only deployment. It also includes a MySQL/Drizzle data layer, customer accounts, order records, shipping integration, transactional email, storage access, and a Manus OAuth/admin path.

## 2. Database Validation

Create a **new, empty project database** for the replacement site. Do not point the rebuilt project at an unknown or historic database in an attempt to recover data; neither the source repository nor a new database recreates historic orders, customer passwords, uploads, or records from the unavailable project.

| Check | How to verify | Expected result |
|---|---|---|
| `DATABASE_URL` is configured | Confirm the project has a valid database connection value, without displaying it. | The server can establish a MySQL-compatible connection. |
| Migrations are applied | Run the repository’s Drizzle migration process against the new database. | Tables are created without migration errors. |
| Core tables exist | Confirm the database contains `users`, `orders`, `order_items`, `order_status_history`, `customers`, and `customer_sessions`. | All listed tables exist and their columns match the schema. |
| Database permissions | Verify the application database user can read/write the above tables. | Customer registration and a controlled test order can create records. |
| Empty-state behavior | Open the admin/order interface before any test order exists. | Empty order/customer lists show a proper empty state; they must not be treated as evidence of an outage. |
| Customer registration | Use a dedicated test email address. Complete sign-up and inspect the new customer record. | A record is created, the password is stored only as a hash, and no raw password appears anywhere. |
| Customer session | Sign out and sign in using the test account. | A session is created, protected pages work, and sign-out invalidates the active session. |
| Controlled test order | Use only an owner-controlled test account and a clearly marked test item/address. Do not process a real payment, live fulfillment request, or customer shipment. | An order, order items, and the initial status-history row are written consistently. |
| Admin workflow | Sign in with the intended administrator identity and inspect the test order. | The admin interface is accessible only to the owner/admin and can safely view the test record. |

## 3. Environment and Integration Validation

| Variable or capability | Required? | Pass condition | If missing or incorrect |
|---|---:|---|---|
| `DATABASE_URL` | **Yes** | Database-backed actions work, including registration and controlled test orders. | Treat as a release blocker. |
| `JWT_SECRET` | **Yes** | A fresh, strong secret is stored in deployment settings and remains stable across redeployments. | Sessions/authentication may fail or users will be logged out after deployments. |
| `VITE_APP_ID`, `OAUTH_SERVER_URL`, `OWNER_OPEN_ID` | Required for the Manus OAuth/admin workflow used by this code. | Owner can complete the expected Manus/admin login flow; non-owners do not get admin rights. | The public shop may render, but owner/admin login can fail. Do not invent these values. |
| `BUILT_IN_FORGE_API_URL`, `BUILT_IN_FORGE_API_KEY` | Required for the code’s Manus-backed storage/data integrations. | Any upload/storage or related Manus-backed feature completes successfully. | Configure only through the new full-stack project’s secure settings; never copy placeholder values. |
| `RESEND_API_KEY` | Optional for browsing, but required for transactional emails. | Test emails deliver from an approved sender identity to an owner-controlled address. | The app may still work, but order, confirmation, verification, and shipping emails will be skipped or rejected. |
| `SHIPSTATION_API_KEY`, `SHIPSTATION_API_SECRET` | Optional until fulfillment/tracking is enabled. | Use an approved non-production test path or a harmless owner-controlled test record. Confirm that no real order is created or shipped inadvertently. | Fulfillment/tracking actions will fail; do not enter guessed credentials. |
| `VITE_ANALYTICS_ENDPOINT`, `VITE_ANALYTICS_WEBSITE_ID` | Optional. | Analytics requests resolve if analytics is intentionally enabled. | Build warnings are non-blocking; remove/disable the analytics snippet only if the owner decides not to use it. |

The sender address in the code is `noreply@laelitepeps.com`. Before enabling live transactional email, ensure the chosen email provider recognizes and authorizes that sending domain. A successful website deployment does not itself prove outgoing email is authorized.

## 4. Temporary Manus URL Test Sequence

Run these tests at the temporary URL before any custom-domain connection. Capture the exact URL, timestamp, browser error, HTTP response, and deployment-log message for any failure. Do not include secret values in the capture.

1. Open the homepage in a private/incognito window. Confirm the storefront renders and all product images, prices, navigation, and legal/research-use content are present.
2. Visit a product page, add an item to the cart, change quantity, and remove it. Confirm cart state behaves predictably.
3. Create a test customer account using an owner-controlled test mailbox. Verify that customer-only pages remain inaccessible before login and accessible after login.
4. Complete a **controlled, non-live** order flow. Do not use a real customer, actual payment, production shipping label, or live fulfillment request.
5. Confirm the new database records are created for the test customer, order, items, and initial order status.
6. Confirm the designated owner account has the required admin access and that a regular customer does not.
7. If email is configured, test one owner-controlled email and confirm the message arrives. If it is not configured, document that email notifications are deliberately disabled.
8. If ShipStation is configured, verify credentials and webhook configuration without creating a real outbound shipment. If it is not configured, keep fulfillment actions disabled and document the limitation.
9. Open browser developer tools and the deployment logs. There should be no repeated 4xx/5xx API failures, unhandled exceptions, authentication loops, or storage failures.
10. Re-test the critical flow after a fresh sign-out/sign-in. Only after these checks pass should the owner approve custom-domain cutover.

## 5. Error and Warning Guide

| Where seen | Message or pattern to look for | Meaning | Required response before domain cutover |
|---|---|---|---|
| Deployment build log | `Could not find the build directory: ... make sure to build the client first` | The production server cannot find the compiled frontend. | Run/fix the production build and redeploy. |
| Deployment build log | `%VITE_ANALYTICS_ENDPOINT% is not defined` or `%VITE_ANALYTICS_WEBSITE_ID% is not defined` | Optional Umami analytics variables are absent. | Non-blocking if analytics is intentionally disabled; otherwise configure the values. |
| Application/deployment log | `[Database] Failed to connect:` | The database URL, credentials, network access, or database service is wrong/unavailable. | Block release; correct the connection and test registration/order persistence again. |
| Application behavior/log | `[Database] Cannot upsert user: database not available` or `Database not available` | The app cannot perform a required database operation. | Block release; verify `DATABASE_URL`, service health, and migrations. |
| Database error | `ER_NO_SUCH_TABLE`, “table does not exist,” migration error, or missing-column error | Database migrations were not applied correctly or the schema is incomplete. | Block release; apply/review the Drizzle migrations against the new database. |
| Database error | `ER_ACCESS_DENIED_ERROR`, “access denied,” or authentication failure | The database credential does not have valid access. | Block release; correct credentials and database-user permissions. |
| Authentication log | `[OAuth] ERROR: OAUTH_SERVER_URL is not configured!` | The owner/admin OAuth flow lacks its required setting. | Configure the value through secure project settings; then test owner login. |
| Authentication endpoint/log | `OAuth callback failed`, `code and state are required`, or `openId missing from user info` | OAuth configuration/callback flow is incomplete or invalid. | Do not cut over; resolve the configured login flow and retest in a clean browser session. |
| Authentication log | `[Auth] Missing session cookie`, `Session payload missing required fields`, or `Session verification failed` | Cookie/JWT/session setup is not working reliably. | Verify `JWT_SECRET`, HTTPS, login route configuration, and browser cookie behavior. |
| Browser/API response | HTTP `401 UNAUTHORIZED` or `403 FORBIDDEN` on a customer/admin API request | Authentication is absent, expired, or the role is insufficient. | Confirm the intended owner identity maps to admin and that customer permissions are restricted. |
| Storage endpoint/log | `Storage proxy not configured`, `Storage backend error`, `Storage proxy error`, `Empty signed URL from backend`, or `Missing storage key` | Manus-backed storage configuration or the requested file key is invalid. | Block any feature that depends on uploads/storage; configure the secure Manus storage values and retest. |
| Email log | `[Email] RESEND_API_KEY not set — skipping order email` | Browsing and orders may work, but that message type will not send. | Non-blocking only if email is intentionally disabled and documented; otherwise add/verify a valid key and sender domain. |
| Email-provider response/log | `401`, `403`, “API key invalid,” or domain/sender-not-verified error | The email credential or `noreply@laelitepeps.com` sender authorization is invalid. | Keep email-dependent workflows disabled until fixed; retest using an owner-controlled mailbox. |
| Shipping log | `ShipStation API credentials not configured` | The fulfillment credentials are absent. | Non-blocking only while shipping automation is disabled. |
| Shipping log | `ShipStation POST ... → 401`, `403`, or another `4xx/5xx` response | ShipStation rejected credentials, payload, permissions, or service request. | Do not process customer orders through shipping automation until resolved. |
| Browser/API response | HTTP `502` or `504`, “Failed to fetch,” or recurring tRPC request failures | The backend, integration, or upstream service is unavailable or misconfigured. | Inspect the corresponding deployment log entry; do not proceed based only on the browser message. |
| Public page | Manus “Site under maintenance,” HTTP `503`, or `x-manus-original-status: 404` | The target is not a working published project/domain binding. | Do not edit general DNS. Confirm the temporary deployment is published first; only then reconnect the domain. |

## 6. Go/No-Go Gate Before Domain Cutover

The owner should approve custom-domain connection only when all of these statements are true:

- The temporary Manus URL loads reliably in a private browser window.
- The new database is connected, migrations are applied, and controlled test records persist correctly.
- Customer sign-up/sign-in and owner/admin authorization behave as intended.
- Email, storage, and ShipStation are either tested successfully or intentionally disabled with a documented plan to configure them later.
- No unresolved database, authentication, storage, shipping, or repeated 5xx deployment errors remain.
- The owner understands that historic orders, customer records, passwords, uploads, and the former production database are not restored by this source-code deployment.
- The owner is ready to change only the website association/records after the new deployment is proven functional.

After this gate passes, use the domain-connection process: connect both `laelitepeps.com` and `www.laelitepeps.com`, select the root domain as primary, verify HTTPS, and preserve all nameserver, Google MX, and Google-related email TXT records.

## References

[1] [Website Peptide GitHub repository](https://github.com/EKhelil11/website-peptide)

[2] [Manus: Custom domain connection guidance](https://help.manus.im/en/articles/11711203-how-can-i-connect-the-website-created-by-manus-to-my-custom-domain)

[3] [Manus: WebDev projects and website restoration guidance](https://help.manus.im/en/articles/16354507-service-change-overview-how-service-change-affects-your-webdev-projects-and-website)
