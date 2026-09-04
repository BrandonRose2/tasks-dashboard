# Request for Managed-Workstation Approval: Windows Edge Local Loopback Bridge

**Requested scope:** A narrowly allowlisted local Microsoft Edge extension-to-native-host **loopback validation only** on one designated Windows management workstation.  
**Business purpose:** Prepare a secure, auditable local execution boundary for a responsive internal reporting portal. The portal remains accessible from any authorized computer or phone; this local component will later support a visible, user-controlled Edge session on the management workstation.

## This request does not authorize provider access

The proposed validation package has **no OneSite, RealPage, Yardi, portal, or other website host permission**. It cannot navigate a website, read browser tabs, capture cookies, access credentials, bypass MFA/CAPTCHA, submit a report, download/upload a file, or make a network request.

Its only action is an internal loopback message:

```text
readiness_ping → readiness_pong
```

The response explicitly reports `providerActionPerformed: false`.

## Requested approval and policy check

| Item | Requested action | Scope limitation |
|---|---|---|
| User-level native-host policy | Confirm whether Microsoft Edge policy permits an approved user-level native-messaging host for the designated management user. | One named host only; no wildcard policy change. |
| If user-level hosts are prohibited | Approve a single system-level installation performed by IT. | Only the named host listed below; no administrator access granted to portal code or users. |
| Native-host allowlist | Allowlist only `com.apartmentcorp.onesite_edge_bridge` if a deny policy is present. | Do not allowlist `*` or unrelated native hosts. |
| Extension installation | Permit a single reviewed Edge extension used only for loopback validation. | Final package must have a fixed, documented extension ID. No webpage access is requested. |
| Native-host registry entry | Register the host manifest only under the approved Edge native-messaging registry path. | The manifest must list only the exact final extension ID in `allowed_origins`. |
| Executable review | Review and approve the signed native-host executable before installation. | No general-purpose scripting host, remote-control tool, browser debugger, or arbitrary command handler. |

## Package controls for review

| Control | Verification point |
|---|---|
| Extension permissions | Manifest V3; exactly `nativeMessaging`; no `host_permissions`, `content_scripts`, or external website connection. |
| Extension origin restriction | Native host uses `allowed_origins` for one final explicit extension ID. |
| Message surface | Protocol version 1; accepts `readiness_ping` only; rejects unknown fields, versions, nonces, and operations. |
| Native-host framing | Length-prefixed JSON; 16 KB message limit and 64 KB input-buffer limit. |
| Provider boundary | No provider or portal code exists in the loopback package. |
| Logging boundary | No credential, cookie, session, DOM, workbook, request-capability, or provider-page data is logged. |
| Operational boundary | The runner/workstation has no production OneSite queue label; the loopback validation cannot claim or process reporting requests. |

## Final-ID and installation condition

The package has **not** been installed. Before any native-host registry entry is created, the extension must be packaged and assigned a final Edge extension ID. That exact ID will replace the `__EDGE_EXTENSION_ID__` placeholder in the native-host manifest. No wildcard or provisional origin is acceptable.

If the device policy blocks user-level native hosts, IT should use a managed, system-level installation with the same exact host name and extension ID restriction. Microsoft Edge provides separate policies for named native-host allowlists and for whether user-level native hosts are permitted. [1] [2]

## Excluded follow-on work

This approval does not cover any provider host permission, content script, OneSite/RealPage/Yardi page interaction, provider sign-in, portal API call, report action, file transfer, source synchronization, or Request #60001 reconciliation. Each would require a separate design review and operational approval.

## References

[1]: https://learn.microsoft.com/en-us/deployedge/microsoft-edge-policies/nativemessagingallowlist "Microsoft Edge policy — NativeMessagingAllowlist"
[2]: https://learn.microsoft.com/en-us/deployedge/microsoft-edge-policies/nativemessaginguserlevelhosts "Microsoft Edge policy — NativeMessagingUserLevelHosts"
[3]: https://learn.microsoft.com/en-us/microsoft-edge/extensions/developer-guide/native-messaging "Microsoft Edge — Native messaging"
