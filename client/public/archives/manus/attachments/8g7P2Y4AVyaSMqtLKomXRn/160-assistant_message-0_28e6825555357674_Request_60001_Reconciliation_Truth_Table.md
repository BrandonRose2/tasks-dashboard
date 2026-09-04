# Request #60001 — Completion and Duplicate-Prevention Truth Table

**Prepared:** September 1, 2026  
**Request:** `60001` — `All Units (Excel)`  
**Operating posture:** Read-only reconciliation. No provider report was rerun, generated, cancelled, downloaded, uploaded, filed, or deleted.

## Evidence Summary

| Evidence source | Result | Reconciliation implication |
|---|---:|---|
| Portal request record | `in_progress`; provider-selected property count: **35** | The request has not been completed or closed by the portal. |
| Portal request scope | **38** properties | The broader portal request scope differs from the provider-selected scope by 3 properties. |
| OneSite My Reports inventory, dated 08/28/2026 | **33** unique rows | This read-only inventory is currently two rows short of the portal’s recorded provider-selected count. |
| OneSite status results | **31 Completed**, **2 In Progress** | Only the 31 completed rows are candidates for later retrieval; neither in-progress row may be acted on. |
| Existing portal documents | **22** documents: 11 `source_report` + 11 `workbook_html` | Eleven completed reports are already stored as complete source/HTML pairs. |
| Duplicate detection | **0** candidates | No existing portal property/document-kind duplicate was found. |

## Truth Table

| Reconciliation group | Count | Properties / condition | Required disposition |
|---|---:|---|---|
| Completed in OneSite and already filed as a source/HTML pair | 11 | 135th Street Apartments; Anaheim Gardens; Arbor Crest; Bayou Pointe; Boca Ciega Townhomes; Breckenridge Village; Coral Village; Crossroads of Lees Summit; Fairfax Sr Apartments; Grace Townhomes; Grove Park Terrace | **Do not download or file.** These are complete and non-duplicated. |
| Completed in OneSite but no portal source/HTML pair | 20 | Granite Ridge Apartments; Historical - Riverchase Homes; Holiday Apartments; Howell Place; Jefferson Arms Apts; Lexington Arms; Macedonia Gardens; Marrero 3 LP; Midtown Manor; New Wilmington Arms; North Pointe; Pacific Pointe Apartments; Pelican Bay; Pirates Bend; Silver Springs Terrace; St. Charles; Thomasville Church Homes; Walnut Hill; Windsor Village; Yorkshire Apartments | **Potentially eligible later**, but remain blocked until the provider-inventory scope gap is resolved and a final user approval is given. |
| In progress in OneSite | 2 | Cumberland Apartments; Urban Rehab | **No action.** Do not download, file, rerun, cancel, or change status. |
| In the portal request scope but absent from the observed 33-row OneSite inventory | 5 | Gates On Manhattan; Granite Elmwood Indiana Homes; Granite Valencia Villas; Ruby and Diamond Homes; Star Homes | **No action.** These require scope reconciliation, not report reruns. |
| Provider-selected count not yet represented in the observed inventory | 2 | Recorded provider-selected count is 35; observed read-only inventory is 33 | **Blocking condition.** The current 4-page inventory cannot yet prove that all provider-selected rows have been observed. |

## Duplicate-Prevention Decision

The existing 22 documents form exactly **11 complete source/HTML pairs**, and the portal association response identified **no duplicate candidates**. The reconciliation therefore must preserve all existing files unchanged.

> The request is **not yet safe for any retrieval or filing step**. The current inventory is incomplete relative to the portal’s recorded provider-selected count: 33 observed rows versus 35 selected rows. In addition, the portal scope includes five properties that did not appear in the observed provider rows. The next safe action is an expanded **read-only** My Reports inventory that follows all available list pages and proves the final row set before any completed output is retrieved.

## What Remains Prohibited

No future step may rerun or generate a OneSite report, cancel an in-progress report, overwrite or delete existing portal documents, send provider email, change provider settings, reuse OneSite state for Yardi, or touch Yardi before this Request #60001 reconciliation gate is completed.
