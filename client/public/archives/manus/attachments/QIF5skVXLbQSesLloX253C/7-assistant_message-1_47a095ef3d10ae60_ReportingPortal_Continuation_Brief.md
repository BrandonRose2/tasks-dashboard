# OneSite & Yardi Reporting Portal — Continuation Brief

**Prepared:** August 31, 2026  
**Purpose:** Resume the frozen “Reports - Onesite & Yardi” project in a new task without repeating earlier discovery or making unverified assumptions.

## Continuation decision

The archived task conversation has been recovered and the saved runner repository has been cloned and verified. This task can therefore continue as the fresh working task; no information needs to be reconstructed from memory. The original conversation export contains 947 events and identifies the earlier task as **waiting** at the point it was archived. The immediately preceding request concerned filing the remaining completed results from a OneSite **All Units (Excel)** portfolio run, after which the user intended to begin a fully separate Yardi sign-in flow.

> **Important:** The portal application and its runner are different assets. The recovered GitHub repository is the private macOS/Microsoft Edge runner. It does not contain the complete portal UI, database, deployment settings, or object storage state. The new task must first determine whether the existing portal project is still attached and deployable before changing application code.

## Verified assets and current status

| Asset | Verified status | Notes for the continuation |
|---|---|---|
| Archived conversation | Available locally as `ReportingPortal.json` | Contains requirements, decisions, screenshots/file references, task history, and the final frozen state. Do not rely on it to recover passwords, browser cookies, or MFA codes. |
| Runner repository | Recovered from [BrandonRose2/realpage-portal-runner][1] | Current branch `main`, clean and aligned with `origin/main`; latest verified commit is `4a90838` (“Fix Edge companion XHR capture compatibility”), dated August 31, 2026. |
| Original portal | Historical deployment URL appears in the archive | Its current availability and source-project attachment have **not** been verified in this recovery task. Treat historical URLs as references, not proof of a live production service. |
| Microsoft Edge companion | Present in repository under `edge-companion/` | A narrow, temporary, unpacked extension was added after the freeze to file existing OneSite Request #60001 workbook downloads. It should be removed after reconciliation. |
| GitHub runner activity | Needs attention | Two scheduled OneSite queue runs were recorded as `pending`/`queued` on August 31. This ordinarily indicates that no eligible self-hosted macOS runner was available to claim them. No attempt should be made to force a report run before configuration and queue state are reviewed. |

## Product goal and confirmed requirements

The intended product is the actual **OneSite Reporting Hub**, expanded to support both **OneSite/RealPage** and **Yardi**. It is not to be described or treated as a prototype. It should be a responsive internal management portal that works on desktop and iPhone, while provider actions occur only in an authorized visible browser session on a management computer.

| Capability | Confirmed requirement |
|---|---|
| Accounts and access | Individual portal accounts for management users, source-specific access, audit visibility, and no shared provider credentials. |
| Provider separation | OneSite and Yardi must remain completely separate: distinct sign-in/session state, runner boundaries, catalog sources, request handling, storage roots, and tokens. |
| OneSite catalog | The authoritative source is the paginated Classic OneSite Reports catalog: **10 pages / 310 reports**. It must populate the OneSite report selector. |
| Property directory | The authoritative OneSite source is the Classic-mode property dropdown. The portal should synchronize it to the property directory. |
| Request workflow | Users select a report, provide report-specific parameters, and run it for **all properties** or a **selected property only**. All-property selections must use OneSite’s explicit Select All behavior, not a limited visible-page subset. |
| Document filing | File originals under separate source roots: `OneSite Reporting/{Property}/…` and `Yardi Reporting/{Property}/…`. Preserve originals, request metadata, status, and generated HTML summaries. |
| Report library | Filter and sort by source, date, property, and report type; clearly show when generation is active. PDFs should open in an in-portal viewer; Excel workbooks need a preview with sheets and an original-download option. |
| Manager workflow | Generate polished property-specific Manager’s Checklists in HTML/Markdown from filed reports. Match property managers to the Notion page **“Company Contacts 07.23.26”** only after current access and mapping quality are revalidated. |
| Email workflow | Draft emails to regional/property managers but keep review and delivery distinct. No message may be sent without explicit confirmation. Exchange delivery was intentionally deferred. |

## Security and operational constraints — non-negotiable

The project must never collect, store, relay, or expose OneSite or Yardi usernames, passwords, browser cookies, session tokens, or MFA codes in the portal, source repository, logs, or chat. Each provider login belongs in the provider-approved visible Edge session of the authorized user. CAPTCHA and two-step verification must not be bypassed; a user completes them whenever the provider requires it.

For OneSite/RealPage, **Microsoft Edge on the designated macOS management computer is the only approved execution environment.** The prior discussion contains confusion about browser identity; do not repeat it. The new continuation must not use a separate connected browser session as a substitute for the Mac’s authorized Edge session. Any automation must operate through the installed Mac runner or the narrowly scoped Edge companion, subject to the provider’s permitted controls.

The runner README specifies a protected, user-readable local configuration file containing only the portal URL, OneSite runner token, and live-session flag. That file must remain outside Git and must not contain provider credentials. The separate Yardi runner needs the same isolation. The temporary companion stores only a short-lived portal pairing capability in Edge session storage, is limited to the My Reports download context, and must be removed after its limited reconciliation purpose is complete.[2]

## Exact operational recovery point

The historical OneSite batch is **Request #60001**, report **“All Units (Excel)”**, dated **August 28, 2026**. The conversation records that OneSite’s own Select All action confirmed **35 selected options** and created results across multiple My Reports pages. It also records that **10 original workbooks and 10 responsive HTML companions** had already been filed into the portal. The remaining results were not reliably captured because the post-run downloader repeatedly scanned only the first ten visible My Reports rows or failed to wait for page transitions.

There is an important discrepancy that must be reconciled before any additional action: the later Edge companion is restricted to a **21-property filing plan** and a specific completed-minute filter, while the original provider run was described as covering 35 selected options. This is not safe to resolve by rerunning the report. The new task must compare the live portal records, OneSite My Reports entries, and the runner’s staged/downloaded files to determine: which properties were selected, which output files exist, which originals and HTML companions are already filed, and which files remain unfiled or legitimately in progress.

| Item | Historical record | Required verification before proceeding |
|---|---|---|
| Provider run | OneSite portfolio selection reported as 35 options | Verify completed/in-progress outcomes in the provider’s visible My Reports page. |
| Portal filing | 10 original workbooks + 10 HTML companions reported filed for Request #60001 | List actual request documents and property associations in the live portal/database. |
| Unfinished records | Remaining files not consistently staged because of pagination/reset logic | Reconcile all unique property/report pairs and download only missing, already-completed outputs. |
| Edge companion | Added only for this one approved current batch | Verify extension version, portal pairing status, allowed-property plan, then remove it once Request #60001 is reconciled. |

## Work already present in the runner repository

The recovered runner contains a significant automation layer rather than only partial fragments. It includes OneSite queue processing, live Edge session checks, live catalog and property synchronization commands, report parameter inspection, all-properties Select All preflight, completed-report downloading, request-scoped filing, HTML companion generation, reconciliation tests, and a workflow for Request #60001.

It also contains later work beyond the archived conversation: separate Yardi Edge-session readiness, Yardi observed-catalog synchronization, a safe Yardi directory sync, OneSite reconciliation utilities, and the restricted direct-filing Edge companion. These additions should be reviewed and tested before being represented as operationally complete. The relevant commands are listed in `package.json`; no blind command should be issued against the Mac because the local runner configuration, correct provider tab state, current portal API, and queue ownership must be verified first.[3]

## Recommended first work sequence for the new task

The new task should begin with a read-only recovery audit: confirm the live portal source project or backup, determine whether its deployment is functioning, inspect the current GitHub Actions queue and the designated Mac runner availability, and inventory Request #60001 records. This audit should establish a single truth table of provider entries, local files, portal documents, and property associations.

Only after that audit should the task reconcile Request #60001. It must use existing provider outputs and prevent duplicates; it must not rerun “All Units (Excel)” merely to compensate for a file-discovery issue. After reconciliation, the temporary Edge companion should be removed and the normal runner process should be repaired or replaced with an auditable production mechanism.

At that point, the Yardi sign-in/session flow may begin. It must start as a separate staged, read-only readiness and catalog discovery process, never reuse OneSite data or configuration, and not perform a report run until the Yardi catalog and property mapping have been verified.

| Available continuation direction | What it provides | Tradeoffs | Setup complexity |
|---|---|---|---|
| Repair the existing Mac-based Edge runner | Retains the saved runner, scheduled queue model, and provider-permitted visible session pattern. | Requires the designated Mac to stay available and the self-hosted runner to be correctly configured. | Moderate; best path when the prior Mac installation can be recovered. |
| Complete the current batch with the restricted temporary Edge companion, then rebuild the durable runner | Offers a narrowly constrained way to reconcile existing Request #60001 downloads before broader automation work. | Is intentionally batch-specific and not a lasting automation architecture; must be removed afterward. | Low for the specific batch, then moderate for the durable replacement. |

No architectural choice has been made in this recovery brief. The current repository supports both paths, but the live portal/runner audit must come first.

## Deferred and explicitly prohibited actions

Exchange/OWA email delivery remains deferred. The archive contains sensitive material supplied in the old conversation; this continuation must not repeat, persist, or attempt to reuse it. If email delivery is eventually implemented, it must use a supported, protected integration with current secret entry and explicit send approval.

Do not make provider-side configuration changes, submit reports, cancel in-progress reports, delete downloads, send emails, or modify access settings until the recovery audit identifies exactly what is present. Do not treat the conversation’s historical claims as confirmation that the current portal, Mac runner, or authorized provider session is functional.

## New-task starter prompt

> Continue the OneSite & Yardi Reporting Portal using the attached `ReportingPortal_Continuation_Brief.md`, the archived `ReportingPortal.json`, and the private GitHub repository `BrandonRose2/realpage-portal-runner`. Start with a **read-only recovery audit** of the portal project/deployment, GitHub Actions queue, macOS Edge runner availability, and Request #60001. Do not rerun reports, send emails, alter provider settings, or use any non-Edge browser for OneSite. Reconcile the existing completed Request #60001 files without duplicates before starting the isolated Yardi sign-in/catalog flow. Preserve the security boundaries and product requirements in the brief.

## References

[1]: https://github.com/BrandonRose2/realpage-portal-runner "realpage-portal-runner repository"
[2]: https://github.com/BrandonRose2/realpage-portal-runner/tree/main/edge-companion "Edge companion source and operating boundaries"
[3]: https://github.com/BrandonRose2/realpage-portal-runner/blob/main/package.json "Runner commands"
