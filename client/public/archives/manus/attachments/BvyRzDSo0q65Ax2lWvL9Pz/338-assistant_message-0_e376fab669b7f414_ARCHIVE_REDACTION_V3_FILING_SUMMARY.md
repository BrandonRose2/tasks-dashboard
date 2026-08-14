# Archive Redaction v3 — Filing Summary

**Status:** Completed and verified on 2026-08-13.

The six approved production files were created from untouched accessible originals. Each retained only the approved federal-return pages through the specified endpoint, used narrow field-specific redactions for only the approved investor/partner tax-ID occurrences, and passed page-count, text/search, OCR, visual-redaction, and supported hidden-content checks. The original non-redacted PDFs were left in `2020 to Present - Tax Returns - Non-Redacted`; no source was modified or duplicated.

| Property | Tax year | Output pages | Post-endpoint pages removed | Field-specific masks | Redacted destination |
|---|---:|---:|---:|---:|---|
| Cumberland Apartments | 2020 | 72 | 183 | 23 | `2020-2021-Tax Returns/Cumberland Apartments LP Tax Return - 2020/CUMBERLAND APARTMENTS, LP 2020 RETURNS - FINAL_REDACTED.pdf` |
| Cumberland Apartments | 2021 | 79 | 176 | 21 | `2020-2021-Tax Returns/Cumberland Apartments LP Tax Return - 2021/CUMBERLAND APARTMENTS, LP 2021 Client Copy_REDACTED.pdf` |
| Holiday Apartments | 2021 | 68 | 142 | 9 | `2020-2021-Tax Returns/Holiday Apartments Housing LP Tax Return - 2021/HOLIDAY APARTMENTS HOUSING, LP 2021 RETURNS (3)_REDACTED.pdf` |
| Jefferson Arms Apartments | 2020 | 25 | 62 | 4 | `2020-2021-Tax Returns/Jefferson Arms Apartments LLC Tax Return - 2020/JEFFERSON ARMS APARTMENTS, LLC 2020 TAX RETURNS - FINAL_REDACTED.pdf` |
| Jefferson Arms Apartments | 2021 | 25 | 63 | 3 | `2020-2021-Tax Returns/Jefferson Arms Apartments LLC Tax Return - 2021/JEFFERSON ARMS APARTMENTS, LLC 2021 RETURN_REDACTED.pdf` |
| The Thibodaux Apartments | 2021 | 57 | 138 | 19 | `2020-2021-Tax Returns/Thibodaux Housing LP and KM of Milford MI LP as TIC Tax Return - 2021/THIBODAUX HOUSING LP 2021 CLIENT COPY (1)_REDACTED.pdf` |

## Verification results

All six outputs passed the following fail-closed checks:

- The output page count exactly matched the approved endpoint.
- All pages after the approved endpoint were absent.
- No approved identifier token remained in text extraction or OCR verification.
- Every approved field-specific redaction area was visibly confirmed.
- No document metadata values, XML metadata, embedded files, annotations, widgets, or links remained.
- The redacted OneDrive copies exactly matched the local verified outputs by SHA-256.

## Remaining archive sources awaiting accessible copies

Holiday 2020; Macedonia 2020 and 2021; Opa Locka 2020 and the second Opa Locka source with unconfirmed year; Thibodaux 2020; and Thomasville 2020 and 2021 remain password-protected and have not been redacted.
