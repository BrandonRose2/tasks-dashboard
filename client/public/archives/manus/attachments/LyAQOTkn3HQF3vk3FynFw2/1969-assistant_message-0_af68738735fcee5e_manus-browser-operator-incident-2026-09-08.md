# Browser Operator Connection Incident Report

## Summary

The **Manus AI Browser Operator** connection is currently unable to read or control authenticated provider tabs. The same failure occurs across Yardi Voyager 7 and RealPage/OneSite tabs, indicating that the issue is not tied to a particular provider website, report page, browser choice, or user login.

> **Exact error:** `HTTP 500: Unexpected number of responses from browser extension`

## Impact

The reporting workflow cannot continue because the agent cannot perform even a read-only page check after the provider tab is shared. No report generation, download, filing, parameter change, or provider-setting modification can be safely attempted while the browser bridge is failing.

## What worked

A generic browser connection test reported that the connected browser was responsive and successfully navigated to `https://example.com`.

## What failed

After the generic connection test, every attempted read-only browser check against the active provider tab failed before page content could be returned. This occurred for:

| Test target | Expected action | Actual result |
| --- | --- | --- |
| Yardi Voyager 7 | Read the active Financial Reports / Voyager page | `HTTP 500: Unexpected number of responses from browser extension` |
| Yardi Voyager 7 after browser restart | Read the active shared tab | Same HTTP 500 error |
| Yardi Voyager 7 from Mac share | Read the active shared tab | Same HTTP 500 error |
| Open RealPage/OneSite tab | Read-only connection comparison | Same HTTP 500 error |

One Comet attempt first returned `Cannot execute action: no active tab. A navigation action is required first.` After navigation was attempted, the same HTTP 500 extension error occurred.

## Recovery attempts already completed

The following were attempted without resolving the issue:

1. Reconnected the existing browser share.
2. Confirmed the browser extension was installed and enabled.
3. Toggled the Manus extension off and back on.
4. Re-shared the active Yardi Voyager 7 tab.
5. Closed and restarted Chrome with Voyager 7 opened first.
6. Started a fresh share from a Mac browser session.
7. Tested a separate RealPage/OneSite tab to determine whether the problem was Yardi-specific.

## Provider-safety confirmation

No provider passwords, MFA codes, cookies, tokens, or session material were requested, stored, or exposed. No report parameters, saved settings, report generation actions, downloads, exports, emails, or filing actions were performed after the bridge failures began.

## Requested support investigation

Please investigate the task-to-browser bridge and extension response handling for a connection that passes the generic browser test but returns `HTTP 500: Unexpected number of responses from browser extension` for every shared authenticated provider tab. Please also advise whether there is a task-session reset or extension/session cleanup step that can restore a fresh controllable browser connection.
