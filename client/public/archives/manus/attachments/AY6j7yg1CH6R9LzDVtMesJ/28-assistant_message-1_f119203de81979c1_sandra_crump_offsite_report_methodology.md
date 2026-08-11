# Connecteam GPS Geofence Off-Site Report

**Employee:** Sandra Crump  
**Study period:** January 1, 2026 through August 10, 2026  
**Generated:** 2026-08-10T22:00:39.405789+00:00  

## Executive Result

The recommended primary result is the conservative **Strict Total**: **421.75 minutes** (07:01:45). It includes only compatible explicit Connecteam geofence EXIT-to-ENTER evidence.

The separate **Review Total** is **5970.05 minutes** (99:30:03), combining the Strict Total with **5548.30 minutes** of inferred off-site time between clearly outside observations no more than 15 minutes apart. It should be used only with the interval-level evidence and exception review.

A total of **40617.33 minutes** (676:57:20) remains unknown and is not added to either total. This includes GPS gaps, shift-boundary intervals, location transitions, boundary-accuracy uncertainty, and any provider-limited intervals.

## Coverage

| Measure | Value |
|---|---:|
| Completed shifts in scope | 132 |
| Shifts with Breadcrumb events | 131 |
| Shifts without Breadcrumb events | 1 |
| Enabled geofences in extraction snapshot | 61 |
| GPS/geofence events analyzed | 6629 |
| Classified intervals | 6726 |
| Exception/review entries | 1072 |

## Method

The analysis joined read-only Breadcrumbs exports to the corresponding completed shift record using the Connecteam time-activity identifier, and used the time-clock-specific enabled geofence snapshot. GPS point distance to each applicable geofence center was calculated with the Haversine formula. A GPS point within a reported accuracy boundary band was never treated as clearly outside. Explicit geofence ENTER and EXIT events had priority as evidence; all long or uncertain gaps were classified as unknown rather than silently treated as off-site.

The source archive and its integrity manifest are retained separately because raw route records are sensitive. This manager-facing package deliberately excludes raw GPS trails.

## Limitations

The exports are event- and point-based rather than continuous location video. Therefore, missing location data cannot establish on-site or off-site status. The geofence list reflects the configuration retrieved at extraction time; if fences were changed during the study period, management should provide approved historical location records for any affected date before relying on related outcomes. This report is a factual location-evidence analysis, not an employment or legal conclusion.

## References

[1]: https://developer.connecteam.com/docs/time-clock-breadcrumbs "Connecteam Developer Documentation — Breadcrumbs"
[2]: https://developer.connecteam.com/docs/time-clock-time-activities "Connecteam Developer Documentation — Time Activities"
[3]: https://developer.connecteam.com/docs/time-clock-geofences "Connecteam Developer Documentation — Geofences"
[4]: https://developer.connecteam.com/docs/api-access "Connecteam Developer Documentation — API Access"
