# OneSite Reporting Hub: GitHub Preservation Assessment

**Repository reviewed:** [`BrandonRose2/realpage-portal-runner`](https://github.com/BrandonRose2/realpage-portal-runner)  
**Assessment date:** August 26, 2026 (PDT)  
**Prepared by:** Manus AI

## Bottom line

You preserved a **substantial and useful portion** of the project. The repository is not a stub: it contains **143 commits**, a mature TypeScript runner, operational documentation, a self-hosted GitHub Actions workflow, and more than 60 runnable commands for OneSite/RealPage automation, report download, filing, catalog synchronization, and Yardi-related workflows.[1] [2]

The important distinction is that this repository is the **automation runner/service**, not demonstrably the full OneSite Reporting Hub application. Its source explicitly calls a separately deployed portal API at a configurable `PORTAL_BASE_URL`; therefore the portal UI, server-side routes, database/storage, and user-authentication implementation are **not present in this repository**.[3] The configured portal address is still reachable and shows an authenticated **OneSite Reporting Hub** sign-in page, but its protected content and source cannot be assessed without authentication.[4]

> **Practical recovery verdict:** the runner is highly recoverable from this repository; the end-to-end portal is only partially recoverable from this repository alone. The portal’s live deployment appears to survive, which improves the recovery outlook considerably.

| System component | What the repository preserves | Recovery confidence | Notes |
|---|---|---:|---|
| **Runner automation** | Queue processing, report generation/download/upload flow, error handling, request state updates, report summaries, and weekly scheduling. | **High** | The primary runner is implemented in `runQueuedRequest.ts`, not merely described in a README.[2] |
| **OneSite/RealPage browser workflows** | Persistent and live Edge session handling, report-form and parameter inspection, completed-report discovery/download utilities, native download helpers, property selection, and scope controls. | **High** | The source tree and manifest show a broad operational workflow surface.[1] |
| **Yardi workflow** | Queue processor, session tooling, unit-directory inspection/execution, all-property scope verification, and final merged-output verification. | **High** | The latest saved commits document this development sequence.[5] |
| **Portal integration contract** | API calls for health, queue claiming, status/progress, file upload, completion/failure, catalog sync, and contact sync. | **High** | The runner-side contract is preserved in `portalClient.ts`.[3] |
| **Portal UI, backend, database, storage** | **Not included in this repository.** | **Unknown from this repo** | A separate project/task export or another repository is needed to recover source and data. |
| **Credentials, authenticated browser session, local reports/debug data** | **Intentionally excluded.** | **Must be recreated/recovered separately** | `.env`, Edge browser profile, and debug folders are excluded from Git; the README also places runtime config outside the repository.[6] [7] |

## What was definitely saved

The saved project contains the architecture needed to run the report-execution side of the system. The primary queue processor validates required configuration, checks portal health, claims requests, supports all-properties and specific-property report scopes, logs into RealPage or uses a visible trusted Edge session, downloads generated documents, uploads them back to the portal by property, and records success/failure status.[2]

The repository also includes a weekly GitHub Actions workflow that targets a dedicated self-hosted macOS runner. That matches the documented design: a persistent Mac with Microsoft Edge and the RealPage session available for the automation layer.[7] [8]

The history is meaningful. The most recent visible work is dated August 20–21, 2026 and includes debugging/verification for completed report pages, All Units downloads, property-scope controls, and a Yardi Unit Directory runner ending in **“Verify merged Yardi unit directory output.”**[5]

## What was not saved here—and why it matters

The absence of browser cookies, the local Edge profile, runtime credentials, downloaded reports, and debugging files should **not** be interpreted as failed backup. These items were deliberately ignored by Git for security and portability. Recreating the runner will require a new local `onesite-runner.env`, an authenticated Edge/RealPage session, and the portal runner token.[6] [7]

The material not found in this repository is the portal application itself. `portalClient.ts` makes authenticated HTTP calls to endpoints such as `/api/onesite-runner/requests/claim` and `/api/onesite-runner/requests/:id/documents`; those server routes must live in another codebase/deployment.[3] In short, the repository contains the **worker that operates the portal**, rather than the portal’s entire web application.

One functional limitation is also intentionally documented and preserved in code: a `sync_my_reports` request is completed with a warning because the completed-output discovery method was not yet verified enough to treat discovered files as downloaded. That is a known feature gap, not lost work.[2] [7]

## Recommended next steps

First, preserve this repository twice: keep it private on GitHub and make an offline clone/export. It is the strongest surviving source for the runner layer. The 143-commit history is valuable because it preserves the evolution and debugging context, not only the latest files.[1] [5]

Second, locate the **portal-app source** separately. The highest-value places to check are other GitHub repositories under the same account, any website/project export, local project folders, or a task backup that includes the OneSite Reporting Hub. Search for the portal API route prefix `onesite-runner`, the site name `OneSite Reporting Hub`, or the deployment identifier `delinquiry-a9qeeygg`.

Third, when ready to restore operation, re-establish the runner only after the portal application/API is confirmed. The runner needs a macOS self-hosted runner, `npm ci`, the local environment configuration, a valid portal runner token, and an authenticated RealPage/Edge session. The repository’s README provides the intended setup sequence.[7]

Finally, use the protected portal deployment as a potential recovery source. It is currently online at the configured address, but a signed-in review is necessary to determine whether its database, report catalog, property records, queued jobs, and historical output documents remain intact.[4]

## References

[1]: https://github.com/BrandonRose2/realpage-portal-runner "Repository overview"
[2]: https://github.com/BrandonRose2/realpage-portal-runner/blob/main/src/runQueuedRequest.ts "Primary queue processor"
[3]: https://github.com/BrandonRose2/realpage-portal-runner/blob/main/src/portalClient.ts "Portal API client"
[4]: https://delinquiry-a9qeeygg.manus.space/ "OneSite Reporting Hub deployment"
[5]: https://github.com/BrandonRose2/realpage-portal-runner/commits/main/ "Commit history"
[6]: https://github.com/BrandonRose2/realpage-portal-runner/blob/main/.gitignore "Ignored local assets"
[7]: https://github.com/BrandonRose2/realpage-portal-runner/blob/main/README.md "Runner setup and operating documentation"
[8]: https://github.com/BrandonRose2/realpage-portal-runner/blob/main/.github/workflows/onesite-report-queue.yml "Scheduled runner workflow"
