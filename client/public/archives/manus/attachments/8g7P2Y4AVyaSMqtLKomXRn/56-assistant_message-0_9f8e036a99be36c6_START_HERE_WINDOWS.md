# Start Here — Windows Edge Loopback Test

This is a **local safety test only**. It does not open OneSite, RealPage, Yardi, the reporting portal, or any other website. It does not ask for a provider password, read browser data, create a report, move a file, or affect Request #60001.

## What this validates

The test confirms that your Windows profile can run a small local helper that communicates only with its paired Microsoft Edge extension. The helper accepts one fixed `readiness_ping` message and returns `readiness_pong`; it cannot perform any other operation.

## Self-service steps — no terminal commands

1. On your Windows work computer, download or clone the **`windows-edge-runner-design`** branch of the private repository into a normal folder that you own, such as your Documents folder. Do not place it on a shared drive.
2. Open the `windows-edge-bridge` folder and double-click **`Install-User-Loopback.cmd`**. Read the output. A successful run says that the user-level loopback bridge is installed for the current profile.
3. Open **Microsoft Edge** and go to `edge://extensions`.
4. Turn on **Developer mode**. Choose **Load unpacked** and select the `windows-edge-bridge/extension` folder from the downloaded branch.
5. In the Edge toolbar, open the extension named **Apartment Corp Windows Edge Bridge — Loopback Validation** and select **Run local loopback test**.
6. A passing result reads: **“Local bridge loopback passed. No provider or portal action was performed.”**

You may remove the local test at any time by opening the same folder and double-clicking `Install-User-Loopback.cmd` after adding the `-Uninstall` argument through PowerShell. If you prefer, I can prepare a separate double-clickable removal launcher before any live provider bridge is considered.

## If Windows asks for an administrator password

The normal setup is user-level and should not need administrative access. If Windows says the action is blocked by organizational policy, stop. Your administrator may enter the Windows administrator password directly on the work computer only to approve the specifically named local loopback helper. Do not share that password in chat.

The administrator should not approve any broad browser permission, provider credential storage, web automation package, remote-control utility, debugging port, wildcard native host, or generic scripting exception. The intended scope is one named local native host, one exact extension ID, and a loopback test with no website permissions.

## If the test does not pass

Do not retry the installer repeatedly and do not change Edge or Windows policy settings yourself. Send me only the final, non-sensitive error text shown by the setup window or the loopback popup. Do not include passwords, screenshots of provider sessions, cookies, tokens, registry exports, or security logs containing personal data.

## Why this is a separate stage

A passing loopback test demonstrates that the Windows and Edge installation boundary is safe. It does **not** authorize or enable provider access. A later, separately reviewed Edge bridge must still be built and tested before the workstation can even perform a read-only OneSite readiness check.
