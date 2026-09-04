# Secure Windows Edge Bridge — Architecture and Validation Plan

**Status:** Design only; no provider integration is implemented or enabled.  
**Objective:** Allow the existing responsive portal to be used from any authorized computer or phone, while a designated Windows management workstation performs only an explicitly approved provider-side action in an existing visible Microsoft Edge session.

## Design decision

Use a **Microsoft Edge extension plus a local native-messaging host** on the designated Windows workstation. This architecture is safer than attaching a generic browser-debugging port or launching a second browser profile because the extension is bound to Microsoft Edge, has narrowly defined host permissions, and communicates only with a locally registered native host whose manifest restricts access to one approved extension ID. Microsoft documents native messaging as a standard-input/output JSON channel between an Edge extension and an installed native application; the native host manifest identifies the executable and allowed extension origins. [1]

The GitHub Actions runner remains only a controlled way to run offline validation and, later, explicitly authorized local orchestration. It must not be used as a background service to impersonate the visible user session. The Windows preflight branch therefore uses a distinct label and contains no normal queue-claim step. GitHub routes self-hosted jobs only to runners matching all `runs-on` labels, so a preflight-only label remains isolated from the production queue. [2]

## Security model

| Boundary | Required control |
|---|---|
| Portal access | The responsive portal remains available to authorized management users on computer or phone. Portal authentication and source-specific access controls remain independent of the workstation. |
| Browser | OneSite and Yardi provider interactions use Microsoft Edge only. The bridge must target an existing visible tab; it must never launch a profile, invoke a credential form, or bypass provider security controls. |
| Provider credentials | Credentials, browser cookies, session tokens, MFA codes, CAPTCHA responses, and equivalent data never enter the portal, repository, runner configuration, extension storage, native-host messages, logs, or chat. |
| Provider separation | Build **separate OneSite and Yardi bridge packages**. They have separate extension IDs, local native-host names, allowed origins, request capabilities, configuration files, message schemas, host permissions, catalogs, storage roots, and logs. |
| Native host identity | Register one per-user host under the Windows Edge native-messaging registry location, with the `allowed_origins` list limited to the exact packaged extension ID. Do not allow wildcard extension origins. [1] |
| Workstation policy | Before installation, check whether enterprise policy permits user-level native hosts; if not, request a scoped system-level installation/allowlist from the organization’s IT administrator. Edge can allowlist named native hosts and can require system-level installation when user-level hosts are disabled. [3] [4] |
| Message protocol | Allow only versioned, schema-validated messages with a nonce, short expiry, source (`onesite` or `yardi`), request ID, and operation name. Reject unknown fields, duplicate nonces, expired messages, wrong source, oversized payloads, and unexpected extension origins. |
| Authorization | Require three independent conditions: (1) an authenticated portal user creates a source-specific request, (2) the portal issues a short-lived, single-use capability bound to that request and operation, and (3) the management user explicitly approves the matching operation in the visible Edge extension. |
| File transfer | File handling remains disabled until the source-specific operation is reviewed. When enabled, use bounded chunks smaller than Edge’s 1 MB native-host response limit, immutable object keys, request/property/document-kind uniqueness, and server-side idempotency. [1] |
| Logging | Log only request ID, source, operation, success/failure code, timestamps, and non-sensitive diagnostics. Never log DOM contents, workbook contents, cookies, browser storage, headers, capability values, or provider URLs containing parameters. |
| Revocation | The portal can revoke a pending single-use capability. The native host must reject it after expiry or first use; disabling/removing the extension or host must immediately block local provider execution. |

## Components

| Component | Responsibility | Explicit non-responsibilities |
|---|---|---|
| Responsive portal | Identity, source-specific permissions, request creation, status/library display, audit records, issuance and revocation of one-time local capabilities. | It does not hold provider credentials, browser state, or a standing workstation control token. |
| OneSite Edge extension | Runs only on explicitly allowed OneSite pages; displays source/request confirmation; obtains only the minimum DOM signals needed for a supported operation; relays validated messages to its own native host. | It does not read passwords, cookies, local/session storage, hidden credentials, MFA values, or unrelated page data. It has no Yardi hosts. |
| OneSite native host | Validates extension origin and bounded message schema; provides local signed results to the portal only for an authorized, in-window operation. | It does not execute arbitrary commands, inspect the filesystem broadly, scrape browser data, access other browsers, or persist capabilities. |
| Yardi package | Separate future extension/native host for Yardi readiness/catalog discovery. | It cannot reuse the OneSite package, config, capability, or storage path. |
| GitHub runner | Runs offline tests and explicit readiness checks on a separate Windows-only label. | It must not automatically claim provider requests or run as a service controlling a noninteractive desktop. |

## Staged validation sequence

| Stage | Evidence required | Permitted activity | Explicitly prohibited |
|---|---|---|---|
| A. Environment preflight | Windows interactive session; protected runner-only local configuration; HTTPS portal origin; no queue label. | Run the published `preflight:windows-onesite-runner` check. | Opening Edge, portal/API call, provider sign-in, request claim. |
| B. Policy and installation check | Edge policy allows the intended native host or IT approves a narrowly scoped system-level install. Exact extension ID is known. | Confirm host-manifest `allowed_origins` and policy conditions. | Installing an unrestricted host; allowlisting wildcards; using a general-purpose native bridge. |
| C. Native-message loopback test | Extension and host exchange a fixed schema fixture; messages stay below documented size limits. | Validate local protocol, origin restriction, rejected unknown/expired/replayed messages, and log redaction. | Loading a provider page or returning any browser data. |
| D. Edge-tab readiness test | Management user opens Edge; bridge sees only an allowlisted non-provider test page or a source-specific blank/readiness page. | Confirm the bridge recognizes an existing visible Edge context and presents a user confirmation surface. | Provider sign-in, DOM inspection of OneSite/Yardi data, navigation, clicks, downloads. |
| E. Source readiness test | User personally signs in through normal Edge flow and opens the exact provider landing page. | Return a minimal “authorized tab present / interactive required” state. | Report generation, cancellation, configuration changes, file transfer, catalog sync. |
| F. Request #60001 read-only inventory | OneSite bridge, portal reconciliation endpoint, and My Reports tab are all ready; explicit authorization is renewed. | Compare recorded selected property count, provider rows, portal documents, original/HTML pairs, and local staged files. | Rerunning/cancelling reports, downloading, filing, deleting, or modifying provider settings. |
| G. Non-duplicative filing | Complete truth table and explicit filing approval. | Retrieve only existing completed outputs missing a complete original/HTML pair; use server idempotency. | Report rerun, overwrite, delete, email delivery. |
| H. Yardi discovery | Request #60001 reconciliation is completed and temporary OneSite companion removed. | Separate, read-only Yardi session readiness and observed catalog/property discovery. | Reusing OneSite capability/state or running a Yardi report. |

## Safest implementation order

1. **Do not merge the preflight branch yet.** It removes the historic fallback before a Windows bridge exists, so preserving `main` maintains the audited baseline.
2. Create a second feature branch from the Windows preflight branch for the **OneSite bridge protocol only**. It should include the extension manifest, strict native-host message parser, fixture tests, local installer templates, policy detection, and audit-log redaction tests—but no OneSite page automation.
3. Complete Stages A–D above in a non-provider test environment. Any policy restriction, extension-ID mismatch, native-host registration failure, or message-schema failure blocks progress.
4. Add a source-specific **readiness-only** OneSite tab check. The user completes normal sign-in in visible Edge, and the runner sees only an allowed “ready / not ready / user action needed” result.
5. Submit this change for review. Only then consider merging the preflight and bridge branches into `main` and registering the production Windows runner under a distinct, reviewed label.
6. Obtain a separate explicit operational approval before the first Request #60001 inventory. The initial live pass is read-only; it must produce the reconciliation truth table before any completed file is retrieved.

## Known release blockers

The branch currently has three blockers by design. First, the Windows bridge has not been implemented. Second, the portal source project/database/object-storage attachment has not yet been recovered or verified, so changes must not assume that all historical request records are accessible. Third, the workbook rendering dependency `xlsx` has unresolved high-severity advisories with no automatic package-manager fix; it should be remediated or formally accepted before broader workbook processing is released.

## References

[1]: https://learn.microsoft.com/en-us/microsoft-edge/extensions/developer-guide/native-messaging "Microsoft Edge — Native messaging"
[2]: https://docs.github.com/enterprise-cloud@latest/actions/how-tos/write-workflows/choose-where-workflows-run/choose-the-runner-for-a-job "GitHub Actions — Choosing the runner for a job"
[3]: https://learn.microsoft.com/en-us/deployedge/microsoft-edge-policies/nativemessagingallowlist "Microsoft Edge policy — NativeMessagingAllowlist"
[4]: https://learn.microsoft.com/en-us/deployedge/microsoft-edge-policies/nativemessaginguserlevelhosts "Microsoft Edge policy — NativeMessagingUserLevelHosts"
