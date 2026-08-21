# iPhone Receipt Shortcut: “Snap & Stage Receipt”

**Recommendation:** Build a manual, one-purpose iPhone Shortcut called **Snap & Stage Receipt**. It should take the receipt photo, apply a sortable filename with a lightweight property label, and save the image directly into one shared, desktop-visible **Receipt Inbox**. It should **not** attempt to upload into the Webster portal from the iPhone.

That distinction is important. The recorded portal workflow has unreliable iPhone file selection, while the portal lists Safari as acceptable but not supported. The Shortcut therefore removes the slowest mobile step while preserving a clean desktop batch for the supported Chrome/Edge workflow.[1]

> **Target experience:** trigger shortcut → choose the property in one tap → take one photo → receive “Receipt staged.”

## The two viable versions

| Approach | Experience | Trade-offs | Cost | Setup complexity |
|---|---|---|---:|---|
| **Snap & Stage Receipt — recommended** | One trigger, one property selection, one photo. Saves a clearly named image to the Receipt Inbox. | Adds one selection per receipt, but eliminates later guessing and photo-library hunting. | $0 | About 15 minutes |
| **Camera-only Receipt Inbox — lighter alternative** | One trigger, one photo. Saves with date/time only. | Fastest capture, but property is not labeled until the desktop batch. | $0 | About 5 minutes |

The recommended version is appropriate if the manager routinely charges to a manageable group of repeat properties. If she visits dozens of properties with equal frequency, start with the camera-only version; a long property list will cost more time than it saves.

## Prepare the receipt destination first

Create one folder in the organization’s **approved, business-controlled storage** that appears in the iPhone Files app *and* on the desktop used for the Webster batch. A shared OneDrive or SharePoint folder is ideal if it is already approved and synchronized to the manager’s desktop. If that is not available, use the company-approved Files location rather than her personal photo library.

Name the folder:

```text
Commercial Card / Receipt Inbox
```

Do not make a new folder every day. A single inbox plus sortable filenames is faster and more reliable on iPhone. On the desktop, sort by filename/date, attach receipts, then move completed images into a monthly archive such as `Commercial Card / Receipt Archive / 2026-08`.

## Build the recommended Shortcut

In the Shortcuts app, create a new shortcut, name it **Snap & Stage Receipt**, and add the following actions in this order. Apple confirms that shortcuts are built by combining actions, including taking a new photo, and can be launched from the Home Screen, Action button, or Back Tap.[2] [3] [4]

| Order | Action to search for | Configuration | Purpose |
|---:|---|---|---|
| 1 | **List** | Enter the 5–12 most common property names, plus `Other` as the final item. Example: `Grove Park`, `Silver Springs`, `Other`. | Creates the short property menu. |
| 2 | **Choose from List** | Use the List from step 1; prompt: `Which property?` | Lets her identify the receipt in one tap. |
| 3 | **If** | Condition: `Chosen Item is Other`. | Opens a manual entry path only for uncommon properties. |
| 4 | **Ask for Input** | Prompt: `Type the property name or code`; input type: Text. Put this action inside the “If” branch. | Avoids making every receipt use a keyboard. |
| 5 | **Set Variable** | Name it `Property`. Set it to the typed answer in the “If” branch and to the chosen list item in the “Otherwise” branch. | Gives both paths one consistent label. |
| 6 | **Current Date** | No special setting required. | Captures the receipt’s timestamp. |
| 7 | **Format Date** | Custom format: `yyyy-MM-dd_HHmm`. | Creates a sortable date/time prefix. |
| 8 | **Take Photo** | Use the rear camera; keep camera preview enabled. | Takes the original receipt image. |
| 9 | **Convert Image** | Convert to **JPEG**; use medium/high quality. Do not make it tiny—the receipt text must remain readable. | Reduces unnecessarily large camera files while retaining legibility. |
| 10 | **Text** | Enter: `Formatted Date_Property_Receipt.jpg` using the magic variables from steps 5 and 7. | Builds a useful filename, e.g., `2026-08-19_1342_SilverSprings_Receipt.jpg`. |
| 11 | **Set Name** | Set the converted image’s name to the Text output from step 10. | Applies the sortable, property-labeled filename. |
| 12 | **Save File** | Select `Commercial Card / Receipt Inbox` as the fixed destination. If the action offers **Ask Where to Save**, turn it off. | Stages the image where the desktop workflow can find it. |
| 13 | **Show Notification** | Message: `Receipt staged: [Property]`. | Gives a quick confirmation without opening the portal. |

The shortcut has only one routine decision—the property list. Put the most common property names at the top. After one week, replace rarely selected names with the locations she actually uses. Do **not** put GL codes in the shortcut unless a property has a fixed, finance-approved GL code; GL coding is more error-sensitive and should remain in the reviewed desktop transaction workflow.

## The exact daily behavior

At the purchase location, the manager triggers the shortcut, taps the property, takes a clear photo, and stops. She does not open the Webster portal, browse the photo library, or type a filename. The receipt is already organized in the Receipt Inbox for the next desktop batch.

The filename format makes the incoming file list self-explanatory:

```text
2026-08-19_0914_GrovePark_Receipt.jpg
2026-08-19_1342_SilverSprings_Receipt.jpg
2026-08-19_1748_Other_Hilton_Receipt.jpg
```

For the `Other` path, use the shortest useful label, such as `Hilton` or `VendorSupply`. The goal is not formal bookkeeping on the phone; it is to make the right image instantly findable on the desktop.

## Put the shortcut on the fastest trigger

Use **one** trigger only. Multiple triggers cause confusion and accidental duplicate captures.

| iPhone situation | Best trigger | Setup |
|---|---|---|
| iPhone 15 Pro or later | **Action Button — preferred** | Go to **Settings → Action Button**, select **Shortcut**, then choose `Snap & Stage Receipt`. Apple documents this option for supported models.[3] |
| Any recent iPhone | **Home Screen icon** | In the Shortcut’s details, choose **Add to Home Screen** and place the icon in the dock or first Home Screen page. Apple documents Home Screen placement for shortcuts.[4] |
| Manager prefers a physical gesture | **Back Tap — optional** | Go to **Settings → Accessibility → Touch → Back Tap**, select **Double Tap** or **Triple Tap**, then choose the shortcut. Test it for a day; use Home Screen instead if it triggers accidentally.[5] |

The **Action Button** is best if her phone has one because it is fast, intentional, and reachable while she is holding a receipt. The **Home Screen icon** is the safest universal default. I would not make Back Tap the first choice for someone who carries the phone in a pocket or regularly bumps it against surfaces.

## Five-minute camera-only fallback

If even the property selection is too much friction, build a stripped-down shortcut with only these actions:

1. **Current Date**
2. **Format Date** as `yyyy-MM-dd_HHmm`
3. **Take Photo**
4. **Convert Image** to JPEG, medium/high quality
5. **Text:** `Formatted Date_Receipt.jpg`
6. **Set Name**
7. **Save File** to `Commercial Card / Receipt Inbox`
8. **Show Notification:** `Receipt staged`

This still eliminates the recorded photo-library search and lets the manager perform the desktop upload batch from a clean, time-sorted queue. It is a better first version than trying to automate merchant recognition, amount extraction, or portal upload before proving the basic capture workflow.

## Important guardrails

The Shortcut should **not** infer a property from GPS, time of day, merchant OCR, or a recurring pattern without human confirmation. Mislabeling a receipt can lead to incorrect property coding; the one-tap property choice is a small control that retains accountability. It should also not transmit receipts to a personal email address or unapproved cloud service.

After the first 30-receipt day, inspect the Receipt Inbox on the desktop. Confirm that all images synchronized, names are readable, property labels are useful, and receipt text remains legible. If any of those fail, correct the file destination or image quality before making it the standard process.

## References

[1] [Webster Commercial Card Portal — Browser Requirements](https://websterbank.commercialcardportal.com/welcome.aspx?ReturnUrl=%2f). The public portal lists Chrome and Edge as supported and Safari as acceptable but not supported.

[2] [Apple Shortcuts User Guide — What’s a shortcut?](https://support.apple.com/guide/shortcuts/welcome/ios). Apple explains that shortcuts are multi-step workflows composed of actions.

[3] [Apple Shortcuts User Guide — Run shortcuts with the Action button](https://support.apple.com/guide/shortcuts/run-shortcuts-with-the-action-button-apdfea15680b/ios). Apple documents assigning a shortcut to the Action button on supported iPhone models.

[4] [Apple Shortcuts User Guide — Add a shortcut to the Home Screen](https://support.apple.com/guide/shortcuts/add-a-shortcut-to-the-home-screen-apd735880972/ios). Apple documents adding shortcuts to the Home Screen and references the Take Photo action.

[5] [Apple Shortcuts User Guide — Run shortcuts by tapping the back of your iPhone](https://support.apple.com/guide/shortcuts/run-shortcuts-tapping-iphone-apd897693606/ios). Apple documents setting a selected shortcut to double or triple Back Tap.
