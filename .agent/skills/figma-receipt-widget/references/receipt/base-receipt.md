# Receipt

Portable component specification for the Receipt Flutter component set.

## Overview

This component set describes a mobile banking / fintech receipt slip with two production states:

- `ReceiptComponent`: confirmation-style receipt
- `ReceiptImageComponent`: gallery-saved receipt image state

Both states share the same receipt body structure, background watermark treatment, and hard-coded literal color palette. The layout is responsive in width and content-driven in height. The current implementation hides the `Scan to Verify` caption in both states.

## API

### Shared data model

Use the same data model for both states.

- `amount`
- `fee`
- `senderName`
- `senderAccount`
- `merchantName`
- `dateTime`
- `transactionId`
- `merchantRefId`
- `billerId`
- `ref1`
- `footerNoteOne`
- `footerNoteTwo`
- `transactionDetailRowCount`
- `senderLogoAssetPath`
- `qrAssetPath`
- `backgroundSvgAssetPath`
- `backgroundImageUrl`

### `ReceiptComponent`

Confirmation-style receipt.

Key config:

- `checkIconAssetPath`
- `senderLogoAssetPath`
- `qrAssetPath`
- `backgroundSvgAssetPath`
- `backgroundImageUrl`

### `ReceiptImageComponent`

Gallery-saved receipt image state.

Key config:

- `headerLogoAssetPath`
- `senderLogoAssetPath`
- `qrAssetPath`
- `backgroundSvgAssetPath`
- `backgroundImageUrl`

## Structure

### Shared structure

Both states render the same receipt body sections:

1. From info
2. To info
3. Amount + QR
4. Transaction details
5. Footer

### `ReceiptComponent` structure

1. Confirmation section
2. Divider
3. From info
4. To info
5. Divider
6. Amount + QR
7. Divider
8. Transaction details
9. Divider
10. Footer

### `ReceiptImageComponent` structure

1. Header
2. Divider
3. From info
4. To info
5. Divider
6. Amount + QR
7. Divider
8. Transaction details
9. Divider
10. Footer

## Visual

### Shared visual rules

- Use literal colors only.
- Keep the background as a separate clipped SVG watermark layer.
- Keep content opacity at 85%.
- Preserve 16px layout rhythm.
- Keep width responsive and height content-driven.
- Keep `From`, `Transaction ID:`, and `Merchant Ref ID:` single-line.
- Keep `Scan to Verify` hidden in the current implementation.

### `ReceiptComponent`

- Rounded card with 12px radius.
- Shadow enabled.
- White surface.
- Green confirmation icon.
- Top title: `Transaction confirmed`
- Confirmation section keeps `16px` horizontal padding with `0px` vertical padding; the icon-to-title gap stays at `16px`

### `ReceiptImageComponent`

- No outer radius.
- No shadow.
- White surface.
- Header row with `Payment` on the left and `wiwallet-logo.svg` on the right.
- Logo target size: `86 × 20`

## Color

Literal palette used by the current export:

- `#242424` for primary text
- `rgba(15,15,15,0.45)` for labels and supporting text
- `#16303e` for merchant name
- `#4CAF50` for confirmation green
- `#DDAD51` for bank logo gold
- `rgba(0,0,0,0.08)` for dividers
- `#FFFFFF` for the card surface

## Screen Reader

- Keep the main title / header first in the accessibility order.
- Keep amount, fee, and transaction details in reading order.
- Keep the QR block present but not captioned with `Scan to Verify`.
- Preserve single-line labels where the visual spec requires them.

## Background

- Background asset: `receipt_background.svg`
- Clip the background to the receipt bounds
- Keep it behind the content layer

## Assets

Use the source bundle from `/Users/Niwat.yah/figma/components/receipt`:

- `check.svg`
- `receipt_background.svg`
- `qr_code_example.png`
- `wiwallet-logo.svg`

## Notes

- `ReceiptComponent` maps to Figma node `107:3225`
- `ReceiptImageComponent` maps to Figma node `107:3226`
- `background` maps to Figma node `107:3224` and is internal reference only
