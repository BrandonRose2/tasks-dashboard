# PropertyMax Rent Comps API Integration Handoff

## Integration endpoint

PropertyMax can retrieve ApartmentCorp rent-comparable information from the public production API at:

```text
https://rent-comps.manus.space
```

The GET endpoints are public and do **not** require an API key, OAuth token, or browser session. The machine-readable OpenAPI 3.0.3 contract is available at [`GET /api/openapi.json`](https://rent-comps.manus.space/api/openapi.json). [1]

## Endpoints

| Use case | Method and URL | Response |
|---|---|---|
| Populate a PropertyMax building selector; cache the portfolio | `GET https://rent-comps.manus.space/api/rentcomps` | Portfolio envelope with `success`, `count`, `lastRefreshed`, and `data[]`. The live response includes full subject, comp, FMR, and market-average data for every returned building. [2] |
| Retrieve one property on demand | `GET https://rent-comps.manus.space/api/rentcomps/{buildingId}` | Envelope with `success` and a full `data` object for the requested building. [3] |
| Generate client types or import the contract into an API client | `GET https://rent-comps.manus.space/api/openapi.json` | Downloadable OpenAPI 3.0.3 specification. [1] |

> **Important:** `buildingId` must exactly match the identifier returned by the list endpoint and must be URL encoded. For example, `21 - Boca Ciega` becomes `21%20-%20Boca%20Ciega`.

## Recommended PropertyMax data flow

PropertyMax should call the portfolio endpoint at application startup or through a server-side cache, then use `buildingId` as the stable join key. Render the property-specific card or panel from the matching object in `data[]`; there is no need to make a second request unless PropertyMax wants a detail route that fetches a single property on demand.

```ts
const RENT_COMPS_API = "https://rent-comps.manus.space";

export async function getRentCompPortfolio() {
  const response = await fetch(`${RENT_COMPS_API}/api/rentcomps`, {
    headers: { Accept: "application/json" },
  });
  if (!response.ok) throw new Error(`Rent comps API failed: ${response.status}`);
  const payload = await response.json();
  if (!payload.success) throw new Error(payload.error ?? "Rent comps API returned an unsuccessful response");
  return payload;
}

export async function getRentCompBuilding(buildingId: string) {
  const response = await fetch(
    `${RENT_COMPS_API}/api/rentcomps/${encodeURIComponent(buildingId)}`,
    { headers: { Accept: "application/json" } },
  );
  if (response.status === 404) return null;
  if (!response.ok) throw new Error(`Rent comps API failed: ${response.status}`);
  const payload = await response.json();
  if (!payload.success) throw new Error(payload.error ?? "Rent comps API returned an unsuccessful response");
  return payload.data;
}
```

## Data structure PropertyMax should use

The first level is a portfolio envelope:

```json
{
  "success": true,
  "count": 40,
  "lastRefreshed": "2026-07-02T17:39:19.000Z",
  "data": ["...building objects..."]
}
```

Each building object contains the subject property, rent benchmarks, and comparable set:

```ts
type RentCompsBuilding = {
  buildingId: string;
  name: string;
  address: string | null;
  city: string | null;
  state: string | null;
  county: string | null;
  msa: string | null;
  program: string | null;
  totalUnits: number | null;
  yearBuilt: number | null;
  currentRents: Record<string, number>;  // e.g., { "1BD": 1470, "2BD": 1800 }
  marketAvg: Record<string, number>;     // market-rate comp averages by bedroom type
  fmrByBed: Record<string, number>;      // HUD FMR benchmark by bedroom type
  lastRefreshed: string | null;
  comps: {
    affordable: Comparable[];             // LIHTC / HUD / other restricted context
    market: Comparable[];                 // market-rate rent comps used in the average
    fmr: BenchmarkComparable | null;
    marketAverage: BenchmarkComparable | null;
  };
};

type Comparable = {
  propertyName: string;
  address: string | null;
  city: string | null;
  state: string | null;
  distanceMiles: string | null;
  yearBuilt: number | null;
  totalUnits: number | null;
  program: string | null;
  competitionLevel: string | null;
  rents: Record<string, {
    actual?: number;  // current advertised / market comp rent where available
    asking?: number;
    ami50?: number;
    ami60?: number;
    fmr?: number;
  }>;
};
```

For PropertyMax rent-positioning views, use the following fields in this order:

| Field | Meaning | Recommended display |
|---|---|---|
| `currentRents[bedType]` | ApartmentCorp subject property’s in-place/current rent | “Current Rent” |
| `marketAvg[bedType]` | Arithmetic market average based on usable market-rate comparable rents | “Market Average” |
| `fmrByBed[bedType]` | HUD Fair Market Rent benchmark | “HUD FMR” |
| `comps.market[]` | Underlying market-rate comps | Expandable comp detail/table |
| `comps.affordable[]` | Restricted/affordable market context | Separate tab or “Affordable Context” table; do not mix into market average |

## Example: Boca Ciega integration

```ts
const portfolio = await getRentCompPortfolio();
const bocaCiega = portfolio.data.find(
  (building: RentCompsBuilding) => building.buildingId === "21 - Boca Ciega",
);

const twoBedroom = {
  currentRent: bocaCiega?.currentRents["2BD"],
  marketAverage: bocaCiega?.marketAvg["2BD"],
  hudFmr: bocaCiega?.fmrByBed["2BD"],
  varianceToMarket:
    (bocaCiega?.currentRents["2BD"] ?? 0) -
    (bocaCiega?.marketAvg["2BD"] ?? 0),
};
```

## Current production data status

The live API was verified on **September 4, 2026**. It currently returns **40 properties** with `lastRefreshed` of **July 2, 2026**. [2] The finalized August 2026 workbook and 41-property checklist were delivered separately and are already reflected in the GitHub Pages rent-comps portal.

> The API is therefore appropriate for the currently deployed API dataset, but it is **not yet synchronized to the final August workbook refresh**. PropertyMax developers should use the API contract above now, while the data source is synchronized in a follow-up update. This avoids silently representing the July API snapshot as the finalized August refresh.

## Error handling and caching

Use a reasonable server-side or edge cache (for example, 15–60 minutes) and preserve the API’s `lastRefreshed` value in the PropertyMax UI or data store. Treat `404` from the single-property endpoint as an unknown/nonexistent building ID and display an appropriate “rent comps unavailable” state. Do not assume that every property contains every bedroom type; only render bedroom types present in `currentRents`, `marketAvg`, or `fmrByBed`.

## References

[1]: https://rent-comps.manus.space/api/openapi.json "ApartmentCorp Rent Comps API — OpenAPI specification"
[2]: https://rent-comps.manus.space/api/rentcomps "ApartmentCorp Rent Comps API — portfolio endpoint"
[3]: https://rent-comps.manus.space/api/rentcomps/21%20-%20Boca%20Ciega "ApartmentCorp Rent Comps API — Boca Ciega example"
