# LA Elite Peptides: Final Steps to Put the Site Live

**Replacement project:** `website-peptide`  
**Working temporary site:** <https://peptideweb-yaousumk.manus.space>  
**Production domain to connect:** `laelitepeps.com`  
**Cutover-ready checkpoint:** `7471f85e` or a newer intended checkpoint

> **Good news:** The temporary Manus website is loading the LA Elite Peptides age gate and storefront. The prior temporary-site billing/unavailable page is no longer the current blocker. The next step is to connect the existing public domain to this verified replacement project—carefully, without affecting email.

---

## First: Find the **Management UI** Button

This is the control that opens the **right-hand project-management panel**. It is not the account/profile settings menu and it is not the task-chat settings.

| What to look for | Where it is | What happens after clicking it |
|---|---|---|
| **Management UI** button or control | In the **open replacement website project**, at the **right side of the project workspace/header** | A right-hand panel opens with project controls, including **Settings**. |
| **Settings** | Inside the right-hand **Management UI** panel | Opens the project settings navigation. |
| **Domains** | Inside **Settings** | Opens the page used to connect `laelitepeps.com`. |

### Quick visual path

```text
Open the replacement website-peptide project
                ↓
Click the right-side button labelled “Management UI”
                ↓
A right-hand panel opens
                ↓
Click Settings
                ↓
Click Domains
```

> If the label is not immediately visible, look in the project’s right-side header/panel controls and hover over the small project-management buttons until the tooltip says **Management UI**. Do not use the general account settings reached from the profile/avatar menu. If the layout looks different, stop and ask the existing Manus task: “Open the replacement project’s Management UI, then Settings → Domains.”

---

## Step 1 — Confirm the Safe Starting Point

Before changing the live domain, open the temporary site in a private/incognito browser window:

<https://peptideweb-yaousumk.manus.space>

| Confirm this | Expected result | If not true |
|---|---|---|
| Temporary site opens | LA Elite Peptides **21+ age gate** and storefront appear | **Stop.** Do not touch the production domain. |
| Correct project is open | The replacement **website-peptide** project is selected | **Stop.** Find the project serving the temporary URL. |
| Correct deployment is selected | Checkpoint is `7471f85e` or a newer intended release | **Stop.** Confirm the intended version first. |
| Temporary fallback remains available | `peptideweb-yaousumk.manus.space` is still connected | **Stop.** Do not remove it. |
| Integrations remain disabled initially | Resend and ShipStation are disabled unless deliberately configured | This is expected during the first cutover. |

---

## Step 2 — Open the Domains Settings

1. Open the verified **website-peptide** project in Manus.
2. Click the **Management UI** button on the right side of the project workspace to open the right-hand panel.
3. Click **Settings** in that panel.
4. Click **Domains** in the Settings navigation.
5. Verify that `peptideweb-yaousumk.manus.space` is listed as the working temporary domain.

> **Stop immediately** if the temporary domain is missing or the project preview does not show the rebuilt LA Elite Peptides storefront. Connecting the production domain to the wrong or uncertain project would create avoidable downtime.

---

## Step 3 — Connect the Existing Domain

Inside **Settings → Domains**:

1. Click **Connect existing domain**, **Add domain**, or the equivalent button.
2. Enter exactly:

```text
laelitepeps.com
```

3. Do **not** enter `https://`, a page path, spaces, or a trailing slash.
4. If the panel offers **Set up both**, turn it on.
5. Confirm the two hostnames are:
   - `laelitepeps.com`
   - `www.laelitepeps.com`
6. Choose **`laelitepeps.com`** as the primary/canonical domain.
7. Keep the temporary `peptideweb-yaousumk.manus.space` domain enabled as the working fallback.

> This is the point where live website traffic may change. Do not proceed unless the owner approves the production cutover and the temporary site has been tested successfully.

---

## Step 4 — Handle What the Domains Panel Shows

| What the Domains panel says | What to do next | Do not do |
|---|---|---|
| **Connected**, **Verified**, or it accepts the new domain without conflict | Continue to DNS/verification steps below. | Do not change DNS unless the panel explicitly asks. |
| **Already connected**, **In use**, or **Attached to another project** | If the old project is visible, open that old project’s **Management UI → Settings → Domains** and disconnect only its `laelitepeps.com` website binding. Return to the replacement project and try again. | Do not transfer the domain or delete nameservers. |
| The old project cannot be opened and offers no disconnect option | Preserve the working temporary URL. Contact [Manus Help](https://help.manus.im) from the owner account with: `laelitepeps.com`, `https://peptideweb-yaousumk.manus.space`, and checkpoint `7471f85e`. | Do not change DNS while the binding remains unresolved. |
| The UI asks to **purchase** or **transfer** the domain | Stop. The owner already owns the domain. | Do not pay for, transfer, or re-register it. |

> Disconnecting a website binding is **not** the same thing as transferring domain ownership. Only remove the old project’s website association if it blocks the new project and the replacement site is ready.

---

## Step 5 — Follow DNS Instructions Only If Manus Shows Them

Because the domain already reaches Manus, the Domains panel may verify the connection automatically. If it does, **do not edit DNS**.

If Manus displays DNS records to add or replace, copy its **exact** record type, host, destination/value, and TTL. The new replacement project’s Domains panel is the only reliable source for these values.

| Change only if Manus explicitly asks | Never change |
|---|---|
| A conflicting root website record for host **`@`** | Nameservers |
| A conflicting website record for host **`www`** | MX records |
| The exact A/CNAME target and TTL provided for the replacement project | SPF, DKIM, DMARC, Google verification, or other email TXT records |
| Nothing else | Domain registration/ownership, unrelated subdomains, or the temporary Manus URL |

> Do not copy an old IP address from the unavailable site and do not guess whether a Cloudflare record should be proxied. If a displayed record might affect email or is unclear, stop and take a screenshot before saving it.

---

## Step 6 — Wait for Domain Verification

1. Return to **Settings → Domains** after submitting the connection.
2. Wait until `laelitepeps.com` shows a status such as **Connected**, **Verified**, or **Active**.
3. Confirm that `www.laelitepeps.com` is also connected or is configured to redirect to the root domain.
4. Keep `peptideweb-yaousumk.manus.space` enabled.
5. Do not repeatedly disconnect and reconnect while DNS/TLS verification is in progress.

A pending status is safer than repeatedly changing settings. Certificate and DNS validation may take time.

---

## Step 7 — Verify the Live Domain

When the panel reports the domain as active, use a private/incognito window and verify the following pages. Do not enter real customer information or place a live order during the first production-domain test.

| Address | Expected result |
|---|---|
| <https://laelitepeps.com> | The LA Elite Peptides age gate and storefront load securely. |
| <https://www.laelitepeps.com> | Redirects to the primary domain or securely loads the same site. |
| <https://laelitepeps.com/product/retatrutide-10mg> | Product page, image, and research notice load. |
| <https://laelitepeps.com/login> | Customer sign-in loads; registration remains temporarily disabled. |
| <https://laelitepeps.com/admin> | An anonymous visitor sees **Admin access required**. |
| <https://laelitepeps.com/terms> | The legal page shows **LA Elite Sales LLC**. |

Also verify that the browser displays a secure HTTPS connection and that business email continues to send and receive normally. This does **not** require changing any email DNS record.

---

## If the Production Domain Does Not Work

| Condition | Safe rollback |
|---|---|
| The Domains panel says active, but `laelitepeps.com` still does not load the replacement site | Confirm the temporary site still works. Do not delete DNS records or nameservers. |
| Immediate rollback is needed | In the replacement project’s **Management UI → Settings → Domains**, disconnect **only `laelitepeps.com`**. |
| After rollback | Leave `peptideweb-yaousumk.manus.space` active. Record the exact error page, domain-panel status, and approximate time. |

This rollback removes the new website binding only. It does **not** delete the replacement project, new database, checkpoint, or temporary fallback URL.

---

## Final Message to Send Back After Cutover

After the connection is complete, send the existing Manus task this message:

```text
Connected. The Domains panel shows: [copy the exact status beside laelitepeps.com].
```

Attach a screenshot of the single **Domains status row** if possible. Do **not** include passwords, API keys, DNS-provider credentials, secret values, customer details, or database connection strings.

## Source Material

- [LA Elite Peptides Domain Cutover Guide](https://www.manus.im/share/file/76d437e6-bc5e-4a39-9620-5ab1c09938b9)
- [Manus: Connect a website to a custom domain](https://help.manus.im/en/articles/11711203-how-can-i-connect-the-website-created-by-manus-to-my-custom-domain)
