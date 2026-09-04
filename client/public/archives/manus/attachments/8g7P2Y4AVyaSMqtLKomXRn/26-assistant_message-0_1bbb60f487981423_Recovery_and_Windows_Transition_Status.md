# OneSite & Yardi Reporting Portal — Recovery and Windows Transition Status

**Prepared:** August 31, 2026 (PDT)  
**Status:** Read-only audit complete; operational reconciliation and provider access remain deliberately blocked pending explicit approval and an approved execution path.

## Executive conclusion

The **OneSite & Yardi Reporting Portal remains intended as a responsive web application available to authorized management users from any computer or phone**. The public deployment is currently reachable and identifies itself as **OneSite Reporting Hub**.

The current blockage is not a web-app access issue. It is limited to the historic **provider-side runner**: the only registered OneSite runner is an offline macOS computer, while the user’s future management workstation is Windows. The existing runner code and GitHub workflow are macOS-specific; they cannot safely use the Windows machine without a separately reviewed Windows Edge runner implementation.

> **Correct architecture:** Users access the portal universally. A designated management workstation, using an already authenticated visible Microsoft Edge session, performs only the approved provider-side activity. Provider credentials, cookies, MFA codes, and session tokens remain outside the portal, repository, logs, and chat.

## Read-only recovery audit

| Area | Finding | Status |
|---|---|---|
| Historical portal deployment | `https://onesiterepor-tsrr864t.manus.space` returned HTTP 200 over HTTPS and serves the **OneSite Reporting Hub** application shell. | Reachable |
| Portal source project, database, and object storage | The supplied archive contains no source-project identifier, and the runner repository is not the portal application. The continued attachment of historic project data cannot be verified from the available material. | Unverified; untouched |
| Runner repository | Private repository `BrandonRose2/realpage-portal-runner` is aligned on `main` at commit `4a908385ef42bfdd4d6c2090f4ac0845417dbf26` (“Fix Edge companion XHR capture compatibility”). | Verified |
| Offline quality checks | Type check passed. All five offline OneSite reconciliation tests passed. No provider or portal API calls occurred. | Passed |
| Actions queue | Two scheduled OneSite queue runs remain active: `33436116524` is pending and `33432193385` is queued. | Blocked pending a decision |
| Registered provider runner | `brandon-onesite-mac` is the only registered runner. It is macOS/ARM64, labelled `self-hosted`, `macOS`, `ARM64`, `onesite-runner`, and is offline. | Unavailable |
| Request #60001 records | The live request inventory cannot be queried without the protected runner capability. No Excel/HTML report artifacts are present in the cloned runner or supplied archive attachments. The historical record of 10 filed originals + 10 HTML companions remains unverified. | Not reconciled; untouched |
| Temporary Edge companion | Source scope is narrow: paired, existing **All Units (Excel)** output only, RealPage My Reports only, and the historical completed timestamp. Installed-machine version and pairing state are unknown because the Mac is offline. | Not used; removal deferred |

## Request #60001 — safety gate

Request #60001 must **not** be rerun to compensate for historical pagination/download failures. The existing reconciliation logic is designed to fail closed: it requires the exact request name and format, a recorded provider-selected-property count, a complete current-batch provider row set matching that count, and intact original/HTML filing pairs. It would file only completed outputs missing from the portal.

However, the current runner being offline is protective: reconnecting it now could immediately cause one of the two active scheduled queue jobs to claim work. Therefore, **no runner should be registered or reactivated until those two existing workflow runs are intentionally resolved**.

| Explicitly not performed | Confirmation |
|---|---|
| Rerunning, submitting, or cancelling a OneSite report | Not performed |
| Opening or using OneSite from a non-approved browser/session | Not performed |
| Downloading, uploading, filing, deleting, or duplicating Request #60001 documents | Not performed |
| Sending email or changing provider / portal settings | Not performed |
| Dispatching, rerunning, cancelling, or editing GitHub Actions workflows | Not performed |

## Universal portal access versus a Windows management runner

The portal does **not** need to be limited to the historic Mac. Its responsive application should be available through normal browser access on desktop and phone. A Windows management computer can become the designated provider-execution machine, but it needs a Windows-specific local runner because the present implementation uses macOS AppleScript to communicate with visible Microsoft Edge tabs.

GitHub supports self-hosted runners on Windows, and routes a job only when an online idle runner has **all** labels listed in the workflow’s `runs-on` definition. [1] [2] The current workflow specifically requires `macOS`, so it will not target a Windows machine until a distinct Windows workflow and runner are reviewed and approved.

| Design element | Approved target behavior |
|---|---|
| Web application | Continue universal authorized access from computer or phone. |
| Edge usage | Microsoft Edge remains the exclusive browser for OneSite provider interaction. |
| Windows Edge bridge | Targets only an existing, interactive, user-visible Edge tab; fails closed if the right page/session is absent. |
| Credential boundary | No credential entry, collection, reading, persistence, forwarding, or logging by the portal or runner. Provider login/MFA/CAPTCHA remains a user action in Edge. |
| Execution context | Operates in the signed-in management user’s interactive Windows session, not through a background desktop that cannot safely represent the visible user session. |
| Workflow routing | Use a distinct Windows-specific runner label. Do not broaden the historic macOS workflow before the Windows bridge has passed offline and readiness-only tests. |
| Provider separation | Maintain separate OneSite and Yardi local configuration, runner capabilities, Edge sessions, catalogs, request handling, and storage roots. |

## Recommended next decision

The safe sequence is as follows:

1. **Approve or decline cancellation** of only the two stale scheduled Actions runs (`33436116524` and `33432193385`). Cancellation would prevent automatic queue processing; it would not rerun or modify a provider report.
2. If approved, create and review a **Windows-only Edge runner** in a separate change. Begin with offline checks and an Edge readiness test only—no provider sign-in, report action, file action, or setting change.
3. After the Windows runner is confirmed safe and the user has an already authenticated visible OneSite My Reports Edge tab, use the existing Request #60001 reconciliation gates to inventory the request and file only genuinely missing completed original/HTML pairs.
4. Remove the temporary Request #60001 companion after successful reconciliation.
5. Begin the Yardi flow only after that gate, in a separate read-only Edge-session and catalog-discovery stage. Do not run a Yardi report until its catalog and property mapping are verified.

## Evidence and references

The findings above are based on the user-supplied continuation brief, the user-supplied archived task export, a read-only inspection of the authorized private runner repository, and its current GitHub Actions/runner metadata.

[1]: https://docs.github.com/actions/hosting-your-own-runners/adding-self-hosted-runners "GitHub Actions — Adding self-hosted runners"
[2]: https://docs.github.com/enterprise-cloud@latest/actions/how-tos/write-workflows/choose-where-workflows-run/choose-the-runner-for-a-job "GitHub Actions — Choosing the runner for a job"
