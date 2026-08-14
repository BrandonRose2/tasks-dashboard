# Remaining Six Federal Returns — Redaction Proposal v1

> **No page removal or redaction has been performed.** This is an approval-gated review of untouched originals.

The proposed endpoint for each source is the final actual federal Schedule K-1 (Form 1065) page, consistent with the user-confirmed endpoint rule. Every later page—including partner supporting schedules, state returns, and e-file material—is proposed for removal. On retained pages, only high-confidence, field-specific investor/partner SSN/TIN occurrences identified from K-1 Part II Item E are proposed. Entity EINs, money figures, names, addresses, labels, and medium-confidence candidates remain visible and are excluded.

## Scope summary

| Property | Tax year | Source pages | Retain through | First excluded | Pages removed | Canonical IDs | Field masks | Medium excluded |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| Grove Park Terrace | 2020 | 80 | 33 | 34 | 47 | 2 | 4 | 7 |
| River Pointe Apartments | 2020 | 134 | 50 | 51 | 84 | 3 | 7 | 8 |
| St. Charles Place | 2020 | 93 | 91 | 92 | 2 | 0 | 0 | 0 |
| Village Green Apartments | 2020 | 290 | 93 | 94 | 197 | 14 | 29 | 24 |
| Village Green Apartments | 2021 | 285 | 90 | 91 | 195 | 14 | 29 | 24 |
| Yorkshire / Windsor Village | 2020 | 119 | 117 | 118 | 2 | 0 | 0 | 0 |

## Grove Park Terrace — 2020

### High confidence — proposed for redaction
- `INV-13BCBFA65A` — occurrence pages: 33; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field.
- `INV-B0CE211D83` — occurrence pages: 18, 29, 32; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
### Medium confidence — excluded from the proposal
- `INV-400994B719` — pages: 33; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-CB7FADE3FF` — pages: 29; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-DC93E09DF1` — pages: 10, 12, 18, 29, 33; potential noncanonical identification-number field, excluded unless specifically approved.

## River Pointe Apartments — 2020

### High confidence — proposed for redaction
- `INV-36C1FEC359` — occurrence pages: 36, 40; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-4598BC1A9B` — occurrence pages: 24, 41, 45; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-763FDB2CCB` — occurrence pages: 46, 50; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
### Medium confidence — excluded from the proposal
- `INV-40AE5A35DE` — pages: 24; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-4B927A9B8A` — pages: 16, 18, 24, 36, 41, 46; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-BB902CCD16` — pages: 41; potential noncanonical identification-number field, excluded unless specifically approved.

## St. Charles Place — 2020

### High confidence — proposed for redaction
- No canonical investor tax ID could be securely derived from the text layer. This source requires further visual/OCR review before any output can be created.

## Village Green Apartments — 2020

### High confidence — proposed for redaction
- `INV-037C356DFA` — occurrence pages: 37, 40; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-36C1FEC359` — occurrence pages: 57, 60; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-38B1D3B921` — occurrence pages: 65, 68; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-3DBE9DF5B7` — occurrence pages: 45, 48; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-3DECD81D1B` — occurrence pages: 85, 88; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-40AE5A35DE` — occurrence pages: 53, 56, 93; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-4C5F418355` — occurrence pages: 61, 64; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-702BA0A3B5` — occurrence pages: 49, 52; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-7398770FED` — occurrence pages: 69, 72; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-9639DF9B3E` — occurrence pages: 89, 92; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-9E1F4CA421` — occurrence pages: 41, 44; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-B786508A46` — occurrence pages: 77, 80; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-C8EB333CA2` — occurrence pages: 81, 84; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-DE977121B8` — occurrence pages: 73, 76; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
### Medium confidence — excluded from the proposal
- `INV-0BE7A98299` — pages: 45, 49; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-1C96DD9D20` — pages: 41; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-40B8B6D0C4` — pages: 12, 14, 37, 41, 45, 49, 53, 57, 61, 65, 69, 73, 77, 81, 85, 89, 93; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-A43FD623A4` — pages: 37; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-B6CD354774` — pages: 45, 49; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-DEBBC4FBB6` — pages: 41; potential noncanonical identification-number field, excluded unless specifically approved.

## Village Green Apartments — 2021

### High confidence — proposed for redaction
- `INV-037C356DFA` — occurrence pages: 34, 37; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-36C1FEC359` — occurrence pages: 54, 57; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-38B1D3B921` — occurrence pages: 62, 65; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-3DECD81D1B` — occurrence pages: 82, 85; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-40AE5A35DE` — occurrence pages: 50, 53, 90; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-4C5F418355` — occurrence pages: 58, 61; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-702BA0A3B5` — occurrence pages: 46, 49; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-7398770FED` — occurrence pages: 66, 69; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-9639DF9B3E` — occurrence pages: 86, 89; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-9E1F4CA421` — occurrence pages: 38, 41; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-B786508A46` — occurrence pages: 74, 77; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-BAC035213F` — occurrence pages: 42, 45; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-C8EB333CA2` — occurrence pages: 78, 81; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
- `INV-DE977121B8` — occurrence pages: 70, 73; safe context: Federal Schedule K-1 Part II Item E partner tax-identification field; Same canonical investor tax ID on a retained source page.
### Medium confidence — excluded from the proposal
- `INV-0BE7A98299` — pages: 42, 46; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-1C96DD9D20` — pages: 38; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-40B8B6D0C4` — pages: 12, 14, 34, 38, 42, 46, 50, 54, 58, 62, 66, 70, 74, 78, 82, 86, 90; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-A43FD623A4` — pages: 34; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-B6CD354774` — pages: 42, 46; potential noncanonical identification-number field, excluded unless specifically approved.
- `INV-DEBBC4FBB6` — pages: 38; potential noncanonical identification-number field, excluded unless specifically approved.

## Yorkshire / Windsor Village — 2020

### High confidence — proposed for redaction
- No canonical investor tax ID could be securely derived from the text layer. This source requires further visual/OCR review before any output can be created.

## Required approval

For each source, explicitly approve the retain-through page, first excluded page, and every high-confidence `INV-…` token listed for that source; confirm every medium-confidence candidate remains excluded. No secure production can be made until that approval is received.
