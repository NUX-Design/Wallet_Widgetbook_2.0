# FIGMA.md

Quick Figma reference for the Receipt component set.

## File

- Figma file: `Receipt`
- File key: `gm0bgMWEOfRT1KwpGgry1w`
- Component set: `107:3227`

## Nodes

- `107:3225` = `ReceiptComponent`
- `107:3226` = `ReceiptImageComponent`
- `107:3224` = background reference only

## Shared Contract

- Responsive width, content-driven height
- Literal hard-coded colors
- Background is a separate SVG watermark layer
- Keep `Scan to Verify` hidden
- Preserve the 16px spacing rhythm

## Shared Assets

Use assets from `/Users/Niwat.yah/figma/components/receipt`:

- `receipt_background.svg`
- `check.svg`
- `qr_code_example.png`
- `wiwallet-logo.svg`

## `ReceiptComponent` (`107:3225`)

- Confirmation-style receipt
- 12px radius card
- Shadow enabled
- Dividers: 1px hairline with 12px border radius — matches card corners
- Confirmation section uses 16px horizontal padding and 0px vertical padding
- Top confirmation section with green check + `Transaction confirmed`
- Section order: confirmation, divider, from, to, divider, amount+QR, divider, details, divider, footer
- `From`, `Transaction ID:`, `Merchant Ref ID:` must not wrap
- QR has no caption

## `ReceiptImageComponent` (`107:3226`)

- Gallery-saved receipt image state
- No radius
- No shadow
- Dividers: 1px hairline with no border radius — matches square-edged card
- Top header row: `Payment` + `wiwallet-logo.svg`
- Logo is a single SVG at `86 × 20`
- Section order: header, divider, from, to, divider, amount+QR, divider, details, divider, footer
- QR has no caption

## Background Node (`107:3224`)

- Source asset: `receipt_background.svg`
- Fill the receipt bounds
- Clip inside the card bounds
- Keep it behind the content

## Colors

Use literal values from the export:

- `#242424`
- `rgba(15,15,15,0.45)`
- `#16303e`
- `#4CAF50`
- `#DDAD51`
- `rgba(0,0,0,0.08)`
- `#FFFFFF`

## Fonts

- `Noto Sans Thai`
- `Noto Sans`

## Flutter Targets

- `/Users/Niwat.yah/flutter_widgetbook_3.0/lib/widgets/receipt/receipt_component.dart`
- `/Users/Niwat.yah/flutter_widgetbook_3.0/lib/widgets/receipt/receipt_image_component.dart`

## Agent Use

- Read this first for node mapping.
- Use [receipt_api.md](./receipt_api.md) for the Figma-facing API overview.
- Use `DESIGN.md` for family-wide rules.
- Use the two component markdown files for per-state implementation details.
- Keep background and content separate.
- Do not reintroduce theme tokens unless the spec changes.
