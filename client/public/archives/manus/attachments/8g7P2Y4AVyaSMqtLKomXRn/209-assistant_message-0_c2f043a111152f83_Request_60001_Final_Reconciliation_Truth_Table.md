# Request #60001 — Final Reconciliation and Duplicate-Prevention Truth Table

**Prepared:** September 1, 2026  
**Request:** `60001` — `All Units (Excel)`  
**Method:** Read-only reconciliation using the recovered macOS runner and the authenticated, visible Microsoft Edge OneSite My Reports page.

> **No provider report was rerun, generated, cancelled, downloaded, uploaded, filed, deleted, or otherwise modified during this reconciliation.**

## Final Coverage Reconciliation

| Population | Count | Result |
|---|---:|---|
| Portal-recorded provider-selected properties | 35 | Fully accounted for. |
| OneSite completed rows | 31 | May be classified as already filed or retrieval-eligible. |
| OneSite in-progress rows | 2 | Must remain untouched. |
| OneSite errored rows | 2 | Must remain untouched; no rerun is authorized. |
| 31 completed + 2 in progress + 2 errored | 35 | Matches the recorded provider selection exactly. |
| Portal request property scope | 38 | Includes 3 properties not represented in the provider-selected batch. |
| Existing portal documents | 22 | Exactly 11 source/HTML pairs; no duplicates identified. |

## Completed Rows Already Filed — No Action

The following completed properties already have both a `source_report` and a `workbook_html` document in the portal. They must not be downloaded, filed again, overwritten, or deleted.

| Property | Existing portal state | Required action |
|---|---|---|
| 135th Street Apartments | Complete source/HTML pair | Preserve unchanged. |
| Anaheim Gardens | Complete source/HTML pair | Preserve unchanged. |
| Arbor Crest | Complete source/HTML pair | Preserve unchanged. |
| Bayou Pointe | Complete source/HTML pair | Preserve unchanged. |
| Boca Ciega Townhomes | Complete source/HTML pair | Preserve unchanged. |
| Breckenridge Village | Complete source/HTML pair | Preserve unchanged. |
| Coral Village | Complete source/HTML pair | Preserve unchanged. |
| Crossroads of Lees Summit | Complete source/HTML pair | Preserve unchanged. |
| Fairfax Sr Apartments | Complete source/HTML pair | Preserve unchanged. |
| Grace Townhomes | Complete source/HTML pair | Preserve unchanged. |
| Grove Park Terrace | Complete source/HTML pair | Preserve unchanged. |

## Completed Rows Missing a Portal Pair — Eligible Only After Explicit Approval

These 20 rows are completed in OneSite and have no existing portal source/HTML pair. They are eligible for **later retrieval of the already-completed output only** after explicit approval. They are not authorized to be rerun.

| Property | OneSite state | Portal state | Conditional action |
|---|---|---|---|
| Granite Ridge Apartments | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Historical - Riverchase Homes | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Holiday Apartments | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Howell Place | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Jefferson Arms Apts | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Lexington Arms | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Macedonia Gardens | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Marrero 3 LP | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Midtown Manor | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| New Wilmington Arms | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| North Pointe | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Pacific Pointe Apartments | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Pelican Bay | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Pirates Bend | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Silver Springs Terrace | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| St. Charles | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Thomasville Church Homes | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Walnut Hill | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Windsor Village | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |
| Yorkshire Apartments | Completed 08/28/2026 11:04 AM | No pair | Retrieve/file only after approval. |

## Prohibited Rows — No Action

| Property | OneSite state | Required disposition |
|---|---|---|
| Cumberland Apartments | In Progress | Do not download, file, rerun, cancel, or change status. |
| Urban Rehab | In Progress | Do not download, file, rerun, cancel, or change status. |
| Granite Elmwood Indiana Homes | Errored | Do not download, file, rerun, cancel, or change status. |
| Granite Valencia Villas | Errored | Do not download, file, rerun, cancel, or change status. |
| Gates On Manhattan | Not in the 35-property provider-selected batch | No report or file action. |
| Ruby and Diamond Homes | Not in the 35-property provider-selected batch | No report or file action. |
| Star Homes | Not in the 35-property provider-selected batch | No report or file action. |

## Final Decision Gate

The reconciliation is now complete and contains **no duplicate candidates**. The only possible OneSite retrieval operation is limited to the 20 named **already-completed** outputs above. Before any such operation, the user must explicitly approve retrieval and portal filing for this exact list.

All other scope remains blocked: report reruns, report cancellation, provider setting changes, email, deletion/overwrite of documents, Yardi interaction, and Windows fallback activation.
