# Windows Edge Management Runner — Change Review

**Branch:** `windows-edge-runner-design` (local only)  
**Publication status:** Not committed or pushed  
**Provider activity:** None

## Scope delivered

This change prepares a **Windows readiness-only boundary** for the OneSite provider runner while preserving the portal as a universal responsive web application. It does not make the Windows computer a production OneSite runner, and it cannot access a provider, start Edge, log in, handle credentials, claim a request, run a report, download a workbook, file a document, or change the portal.

| Component | Change | Safety effect |
|---|---|---|
| `src/windows/windowsRunnerPreflight.ts` | Adds an offline preflight validator. | Requires Windows, a signed-in interactive session rather than `Services`, HTTPS-only portal origin, a locally configured runner capability, and `LIVE_EDGE_SESSION=true`. |
| `src/windows/checkWindowsRunnerPreflight.ts` | Adds a readiness-only command. | Emits non-sensitive configuration status only; it has no browser or network operation. |
| `src/windows/windowsRunnerPreflight.test.ts` | Adds five offline tests. | Confirms Windows-only, interactive-session, live-Edge, HTTPS-origin, and secret-nonexposure controls. |
| `.github/workflows/windows-onesite-preflight.yml` | Adds a manual-only preflight workflow. | Requires a separate `onesite-windows-preflight` label and contains no queue claim or provider action. |
| `src/runQueuedRequest.ts` | Removes the legacy credentialed/browser-profile fallback. | OneSite queue processing now fails closed unless live Edge session mode is explicitly enabled. It verifies the existing Edge session before claiming a request. |
| Legacy credential modules | Removed from the local branch. | Eliminates source paths that accepted `REALPAGE_USERNAME` or `REALPAGE_PASSWORD`. |
| `.env.example` and `README.md` | Rewritten around runner-only configuration and universal portal access. | Makes clear that provider credentials and session data must never be stored, and Windows preflight does not authorize provider work. |

## Validation results

| Validation | Result |
|---|---|
| Static type check | Passed |
| Existing Request #60001 reconciliation unit tests | 5 of 5 passed |
| New Windows preflight unit tests | 5 of 5 passed |
| Whitespace check | Passed |
| Active normal OneSite queue workflows | None; the two user-approved stale runs were cancelled |

## Important release limitation

The new manual workflow proves only that a Windows workstation is configured for a future **readiness-only** test. It deliberately does not provide a Windows equivalent of the macOS Edge automation layer. A separate Windows Edge bridge must be designed, security-reviewed, and validated against an already-open user-controlled Edge tab before a Windows machine can reconcile Request #60001 or perform any provider-side task.

This separation is intentional: it ensures that a future runner cannot accidentally start operating OneSite merely because it has been registered with GitHub Actions.

## Remaining safeguards and approvals

| Required next event | Explicit authorization required? | Provider impact |
|---|---:|---|
| Commit and push this local branch to the private repository | Yes | None |
| Register the Windows work computer with the preflight-only label | Yes | None |
| Run the manual Windows preflight workflow | Yes | None; it does not open Edge or contact a provider/portal |
| Develop and review a Windows interactive Edge bridge | Yes | None during development/offline testing |
| Sign in to OneSite in visible Edge | User-controlled, after bridge review | Provider session only; no credentials shared with the portal/runner |
| Reconcile Request #60001 | Separate explicit operational approval | Existing completed outputs only; no rerun or duplicate filing |
| Begin Yardi readiness/catalog discovery | After Request #60001 reconciliation | Separate session and runner; no report run |

## Dependency advisory

The existing direct `xlsx` dependency has one high-severity advisory family: prototype-pollution and regular-expression denial-of-service advisories. The package manager reports no automatic fix. The Windows preflight change does not use `xlsx`; nevertheless, the workbook-rendering dependency should be separately remediated or formally accepted before broader production release.
