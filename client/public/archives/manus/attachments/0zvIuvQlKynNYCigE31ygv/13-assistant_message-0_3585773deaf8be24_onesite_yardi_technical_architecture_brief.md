# Technical Architecture: OneSite & Yardi Reporting Portal

**Purpose:** Explain the technical work required to build a reliable reporting portal and why a proper implementation cannot reasonably be completed in one week.  
**Planning basis:** 244–361 development hours for a first production release; $75 per hour.  
**Architecture posture:** Use **approved vendor data access** and secure, supportable integrations or controlled imports. Do not assume undocumented APIs, shared credentials, or unauthorized automation.

![Conceptual architecture diagram](https://private-us-east-1.manuscdn.com/sessionFile/0zvIuvQlKynNYCigE31ygv/sandbox/8ADesdVrcDQdnDGnbUNORt-images_1788252493924_na1fn_L2hvbWUvdWJ1bnR1L3BvcnRhbF9yZXBvcnRfd29yay9vbmVzaXRlX3lhcmRpX2FyY2hpdGVjdHVyZQ.png?Policy=eyJTdGF0ZW1lbnQiOlt7IlJlc291cmNlIjoiaHR0cHM6Ly9wcml2YXRlLXVzLWVhc3QtMS5tYW51c2Nkbi5jb20vc2Vzc2lvbkZpbGUvMHp2SXV2UWxLeW5OWUNpZ0UzMXlndi9zYW5kYm94LzhBRGVzZFZyY0RRZG5ER25iVU5PUnQtaW1hZ2VzXzE3ODgyNTI0OTM5MjRfbmExZm5fTDJodmJXVXZkV0oxYm5SMUwzQnZjblJoYkY5eVpYQnZjblJmZDI5eWF5OXZibVZ6YVhSbFgzbGhjbVJwWDJGeVkyaHBkR1ZqZEhWeVpRLnBuZyIsIkNvbmRpdGlvbiI6eyJEYXRlTGVzc1RoYW4iOnsiQVdTOkVwb2NoVGltZSI6MTc5MDgxMjgwMH19fV19&Key-Pair-Id=K2QY5QTL8JSY6C&Signature=MEQCIAVOB8dWr7fLkm-rHbD~OzIk4YBRLWygDvU51MYanWpGAiADSFm~lh4RZnuhKook3trOn8UmYItxGNiYZHFWEMRl~A__)

## Executive perspective

The proposed **OneSite & Yardi Reporting Portal** is a multi-system internal business application. It must receive authorized data from two independently administered property-management platforms, retain source lineage, convert the inputs into a common reporting structure, reconcile discrepancies, enforce property-level access, calculate agreed metrics, and provide dashboards and exports that management can trust.

This is fundamentally different from building a single web page or exporting a report from one system. OneSite supports operations across leasing, maintenance, financial management, and related property workflows, while Yardi provides a formal data-connect capability that aggregates Voyager data with other sources, supports customized reporting and scheduled refreshes, and respects property-level security.[1] [2] The portal therefore needs a controlled data lifecycle from source acquisition through management consumption.

> **Bottom line:** The application is only valuable if its reported figures are complete, correctly mapped, traceable to their sources, appropriately secured, and reproducible. The work needed to make those conditions true is why a production-grade version exceeds a one-week timeline.

## 1. End-to-end data and application flow

| Sequence | Architecture layer | Responsibility | Why it cannot be skipped |
|---:|---|---|---|
| 1 | Source platforms | OneSite and Yardi remain the systems of record for their respective property data. | The portal must identify exactly which data elements and reports are authoritative in each system. |
| 2 | Authorized access path | Establish a vendor-approved feed/API, approved data export, or controlled upload process with appropriate permissions. | Access method determines security design, refresh frequency, failure handling, and delivery timeline. |
| 3 | Ingestion adapters | Retrieve or accept data; detect format, period, and source; validate the receipt; and isolate each source’s technical differences. | The two platforms should not be connected directly to user-facing dashboards. An adapter layer prevents source-specific changes from breaking reporting. |
| 4 | Raw landing zone | Store immutable source snapshots with file/feed identifiers, source timestamps, refresh status, and checksums where applicable. | Enables traceability, debugging, reprocessing, and proof of what data was used in a given report. |
| 5 | Validation and normalization | Test structure, required fields, duplicate records, invalid dates, currency formats, property identifiers, and period alignment. | A report can be mathematically correct but still wrong if source fields or periods are mismatched. |
| 6 | Canonical reporting model | Map OneSite and Yardi data to standardized properties, units, periods, categories, and metric definitions. | This is the translation layer that makes combined management reporting possible. |
| 7 | Reconciliation and metric service | Tie normalized totals back to source reports, calculate KPIs, aggregate results, and surface exceptions. | Cross-platform totals require evidence—not simply a combined sum. |
| 8 | Application API and portal experience | Apply access policy; supply dashboard, filters, property drill-downs, report generation, and exports. | Ensures users receive only the correct scope of data and keeps business logic out of the browser. |
| 9 | Governance and operations | Create audit history, monitoring, refresh alerts, retries, automated tests, backups, and deployment controls. | A portal needs to remain accurate and supportable after its first demonstration. |

## 2. Architecture layers in detail

### 2.1 Source systems and authorized access

**OneSite and Yardi are independent data domains.** The first task is not coding a dashboard; it is establishing what may be accessed, by whom, and through what approved method. The organization must decide whether each system will provide a vendor-supported feed/API, scheduled export, manually placed data file, or another sanctioned mechanism.

Yardi’s published Data Connect product describes secure feeds from Voyager into Microsoft Power BI, the ability to aggregate multiple Voyager databases and other sources, automated data-refresh schedules, and property-level security controls.[1] OneSite is a broad operational platform, and RealPage’s Exchange program is its published route for certified third-party integrations.[2] [3] These vendor models demonstrate why source access is a product, permission, and governance dependency—not a task that can safely be improvised.

| Required decision | Technical consequence |
|---|---|
| Which OneSite reports/data sets are in scope? | Determines the required fields, refresh needs, transformations, and reconciliation rules. |
| Which Yardi reports/data sets are in scope? | Determines whether data can be aligned directly or requires a separate crosswalk. |
| Is access feed/API-based, export-based, or manual-upload-based? | Changes connector design, automation potential, schedule, and error-recovery approach. |
| Which users may access which properties or report types? | Drives identity integration, authorization logic, and data-filtering rules. |
| What is the expected refresh cadence? | Drives scheduling, freshness indicators, retries, and manager expectations. |
| What constitutes the authoritative source total? | Provides the acceptance criterion for reconciliation and quality assurance. |

### 2.2 Secure ingestion and the raw-data landing zone

The portal should use **source-specific ingestion adapters**, not hard-coded dashboard logic. One adapter receives Yardi data; another receives OneSite data. Each adapter records source metadata, validates basic file/feed structure, and passes the received data into an isolated raw landing zone.

The raw landing zone is essential because it preserves a before-transformation record. Each import or feed run should be identifiable by source system, retrieval date/time, data period, receiving user or service identity, status, and any error details. If a manager later asks why a total changed, the team needs to know which source snapshot produced the original number and whether the source was later corrected.

A scheduled ingestion process also needs controls for duplicate receipt, partial failure, stale data, changed source layouts, network interruption, expired authorization, and empty reports. These conditions occur in real operations and cannot be addressed responsibly with a simple “download and display” approach.

### 2.3 Data quality, normalization, and the property crosswalk

The largest conceptual challenge in a two-platform reporting portal is that the systems may not identify the same business concepts in the same way. A property can have different codes, names, status values, reporting cycles, unit-count conventions, or accounting classifications. A vacancy measure may have different inclusion rules. A month-end report may be generated at a different time than an operational report.

The portal therefore needs a **canonical reporting model**: a deliberately defined, internal structure used by every dashboard and export. It usually includes a master property record, a crosswalk from each platform’s property identifier to the internal identifier, reporting-period rules, common metric names, units of measure, and data-quality statuses.

| Validation / normalization control | Example of the problem it catches | Business value |
|---|---|---|
| Required-field validation | A source file is missing property code or reporting period. | Prevents incomplete data from silently entering a management report. |
| Data-type validation | Currency or date values arrive in unexpected formats. | Prevents failed calculations and misleading trends. |
| Property crosswalk | “Walnut Hill” in one system is mapped to a different code in the other. | Ensures each property rolls into the correct portfolio and manager view. |
| Period alignment | One source reflects the prior close while the other reflects current-day activity. | Prevents inaccurate cross-platform comparison. |
| Duplicate detection | A refresh re-sends records already processed. | Prevents double-counting. |
| Exception queue | A property exists in OneSite but has no approved Yardi mapping. | Makes data gaps visible for resolution instead of hiding them. |

### 2.4 Reporting database and semantic/metric layer

After validation, normalized data should be loaded into a separate reporting database. This database is not merely a duplicate of the source systems. It is optimized for reporting questions: portfolio totals, comparisons, time trends, property drill-downs, metric definitions, and report refresh status.

A **semantic layer** sits above the standardized data. It centrally defines metrics such as occupancy, delinquency, rent collections, work-order performance, revenue, expense, or other measures selected by management. The actual KPI set must be specified during discovery; it should not be invented in code. Once approved, the definitions should be documented so that every dashboard, export, and stakeholder uses the same formula and reporting period.

Reconciliation logic compares portal outputs back to the designated source reports. Variance thresholds and exception states should distinguish a normal timing difference from a material mismatch that needs review. This turns the portal into a reporting control mechanism rather than a visually appealing but unverified aggregation layer.

### 2.5 Application services and management portal experience

The portal’s back-end application service protects business rules and data access. The browser should request only the data each user is allowed to view, rather than downloading a full portfolio and hiding it with client-side filters. The service should enforce user role, property scope, date range, and export permissions before responding.

The management interface then provides the decision-support layer: portfolio overview, **All Properties** selection, individual-property drill-downs, date filters, source/freshness indicators, KPI summaries, trends, exception lists, and downloadable reports. The UI is the visible part of the product, but it depends on every prior layer being correct.

| User-facing feature | Back-end work it depends on |
|---|---|
| Portfolio dashboard | Normalized data, metric definitions, aggregation logic, access controls, and refresh status. |
| Property drill-down | Property crosswalk, correct permissions, detailed reporting records, and navigation/API design. |
| “All Properties” filter | Valid master-property list, reporting-scope rules, and aggregation without duplication. |
| Trend view | Reliable reporting periods, consistently calculated metrics, and historical data storage. |
| Variance/exception list | Reconciliation results, thresholds, source lineage, and issue ownership. |
| Downloadable report | Export template, user scope validation, audit logging, and precise filter/period preservation. |

### 2.6 Security, auditability, and operations

Property-management reports can include confidential business, financial, resident, employee, or vendor-related information. The architecture must therefore separate credentials from application code, use least-privilege access, protect data in transit and at rest, define user roles, and maintain an audit trail of key actions such as refreshes, report generation, and exports.

Operational resilience is also part of the build. The portal needs job monitoring, refresh status, clear error messages, retry logic where appropriate, source-change detection, backup/recovery arrangements, development/staging/production separation, and tests. Without these, the product becomes dependent on manual intervention at precisely the time management needs a trusted report.

## 3. Why a one-week deadline is not realistic for a production release

A one-week work allocation equals **40 hours**, or about **11.0%–16.3%** of the 244–361-hour effort estimated for this scope. At the stated $75/hour rate, one week represents **$3,000** of development effort. It can produce a useful early milestone; it cannot encompass all data access, modeling, reconciliation, security, interface, testing, and deployment work required for a dependable portal.

| Development work package | Estimated hours | What the work actually includes | Why it takes time |
|---|---:|---|---|
| Requirements, metric definition, and acceptance criteria | 20–28 | Report inventory, KPI definitions, reporting periods, source-of-truth agreements, property coverage, stakeholder decisions. | Decisions must be correct before downstream development can be trusted. |
| Authorized data access and security design | 20–30 | Vendor/account access path, identity, permissions, credential handling, access boundaries. | Depends on approved organizational and vendor processes, not coding speed alone. |
| Source adapters and ingestion workflow | 42–60 | Source-specific input handling, scheduled/manual intake, validation, retry/error status, metadata. | Two distinct platforms mean two distinct input behaviors and test cases. |
| Reporting database, canonical model, and property crosswalk | 28–40 | Standardized tables, platform-to-internal mappings, historical periods, unmatched-property handling. | Requires analysis of real sample data and business confirmation. |
| Transformations, metrics, and reconciliation | 34–48 | Cleaning, formula logic, aggregation, source tie-outs, exception treatment. | Accuracy needs iterative comparison to trusted source reports. |
| Secure application services | 20–30 | API, authorization enforcement, data scoping, refresh/report endpoints, audit hooks. | Keeps sensitive data and business logic off the client. |
| Management dashboard and reporting user experience | 32–45 | Filters, KPI views, drill-downs, exceptions, responsive presentation, usability revisions. | A useful UI requires real data and repeated feedback. |
| Exports and audit trail | 20–28 | Report generation, parameter preservation, export permissions, source/freshness context, activity logging. | Exports must be consistent, reviewable, and correctly scoped. |
| Testing, staging, deployment, and documentation | 28–52 | Unit/integration testing, source tie-outs, negative testing, deployment, operating guide, handoff. | A portal is not production-ready until failure and edge cases have been tested. |
| **Total first-production-release effort** | **244–361** | **Secure, reconciled, maintainable two-platform reporting portal.** | **$18,300–$27,075 at $75/hour.** |

### What can reasonably be completed in the first week

The first week should be used as a foundation milestone, not as a promise of final production delivery. A realistic 40-hour outcome would be an approved report scope, source-data inventory, initial access-path decisions, sample export analysis, field-mapping draft, property crosswalk template, solution wireframe, and a small prototype using nonproduction or approved sample data.

That work is valuable because it reduces rework. It establishes the source definitions and data model on which the actual portal must be built. Attempting to skip directly to the dashboard would only defer the necessary mapping, reconciliation, and security work until after stakeholders start relying on the results.

## 4. Recommended staged delivery plan

| Stage | Primary outcome | Indicative effort | Completion standard |
|---|---|---:|---|
| Stage 0: Access and definition | Approved objectives, source inventory, data-access path, first KPI/report list, security assumptions. | 20–30 hours | Management agrees on what the first release must report and how data may be obtained. |
| Stage 1: Data foundation | Sample ingestion, raw landing zone, initial model, property crosswalk, data-quality checks. | 50–75 hours | Sample OneSite and Yardi data can be received and mapped with visible exceptions. |
| Stage 2: Reporting engine | Metrics, aggregation, reconciliation, reporting API, role/property scope. | 65–95 hours | Initial metrics tie back to agreed source reports within defined variance thresholds. |
| Stage 3: Management portal | Dashboards, filters, drill-downs, exports, freshness and exception views. | 55–80 hours | Authorized users can generate the agreed management views from validated data. |
| Stage 4: Production readiness | Testing, monitoring, deployment, documentation, training, hardening. | 54–81 hours | The portal is supportable, tested, documented, and ready for controlled use. |
| **Total** | **First production release** | **244–361 hours** | **A reliable, auditable internal reporting product.** |

## 5. Key management decisions that control the calendar

The calendar is driven as much by decisions and access as by development. Timely confirmation of the following items will prevent avoidable delay: the first set of reports/KPIs, which platform is authoritative for each metric, the property crosswalk owner, the approved data-access mechanism, the update frequency, user/property access scope, data-retention requirements, and the person who will validate source tie-outs.

A fast delivery path is possible when management chooses a small first release and supplies approved sample reports promptly. The safest initial version may accept controlled exports while the organization works through vendor-supported access. Once definitions and the data foundation are proven, additional dashboards and automated refreshes can be added without rebuilding the portal from scratch.

## 6. Concise management statement

> The OneSite & Yardi Reporting Portal has to do more than display data. It must securely receive authorized data from two different property-management platforms, preserve source history, validate and normalize the records, map properties and reporting periods, reconcile results to source reports, enforce user access, generate management views and exports, and be tested and supportable in production. A 40-hour week is a productive discovery and prototype milestone, but it represents only about 11%–16% of the 244–361 hours needed for a proper first production release. The right approach is a staged build that proves data accuracy first and expands to automation after approved access and reconciliation are in place.

## References

[1] [Yardi — Data Connect](https://www.yardi.com/product/data-connect/)  
[2] [RealPage — OneSite Property Management Software](https://www.realpage.com/property-management-software/)  
[3] [RealPage — RealPage Exchange](https://www.realpage.com/exchange/)
