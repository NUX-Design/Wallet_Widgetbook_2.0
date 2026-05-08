# Receipt Component

Use this Markdown as a neutral handoff spec for building the standard receipt widget in any Flutter project.

## Context

- This is the confirmation-style receipt state shown after a successful payment.
- The design source is the Figma receipt frame `102:1257`.
- The watermark/background source is Figma node `104:1584`.
- The widget must stay responsive in width and content-driven in height.
- The widget should not depend on app theme tokens; use literal colors for this component.
- The assets in `/Users/Niwat.yah/figma/components/receipt` are the source bundle for this spec. Copy or map them into the target Flutter project before implementation.

## Asset Map

Use these source files from `/Users/Niwat.yah/figma/components/receipt`:

- `check.svg` -> confirmation icon
- `receipt_background.svg` -> receipt watermark/background
- `qr_code_example.png` -> QR image example

Implementation can replace the sender/bank logo with any equivalent circular brand asset from the host project.

## Codebase Contract

Implement the widget as a reusable Flutter `StatelessWidget`.

### Widget API

```dart
class ReceiptComponent extends StatelessWidget {
  final String amount;
  final String fee;
  final String senderName;
  final String senderAccount;
  final String merchantName;
  final String dateTime;
  final String transactionId;
  final String merchantRefId;
  final String billerId;
  final String ref1;
  final String footerNoteOne;
  final String footerNoteTwo;
  final int transactionDetailRowCount;
  final String? checkIconAssetPath;
  final String? senderLogoAssetPath;
  final String? qrAssetPath;
  final String? backgroundSvgAssetPath;
  final String? backgroundImageUrl;
}
```

### Default Values

- `transactionDetailRowCount = 5`
- `checkIconAssetPath = '<project asset>/check.svg'`
- `senderLogoAssetPath = '<project asset>/sender-logo.svg'`
- `qrAssetPath = '<project asset>/qr_code_example.png'`
- `backgroundSvgAssetPath = '<project asset>/receipt_background.svg'`
- `backgroundImageUrl = null`

### Flutter Implementation Rules

- Use `LayoutBuilder` so the amount/QR row can respond to available width.
- Use a `Container` with `width: double.infinity`.
- Use a `Stack` with `Positioned.fill` for the background layer.
- Use `Padding.all(16)` for the content layer.
- Wrap content in `Opacity(opacity: 0.85)`.
- Use a vertical `Column(mainAxisSize: MainAxisSize.min)`.
- Keep the layout content-driven in height.
- Do not tie the widget to a theme system.
- Do not force a fixed card width.

## Visual Rules

- Card surface: white
- Outer radius: `12px`
- Shadow: soft layered shadow
- Background: full-bleed SVG watermark
- Divider: 1px hairline with 12px border radius — matches the card corners
- Typography: `Noto Sans Thai` with `Noto Sans` fallback

## Section Order

Render sections in this order:

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

## Section Contract

### Confirmation Section

- Centered column
- Horizontal padding: `16px`
- Vertical padding: `0px`
- 52x52 confirmation icon
- Gap of 16px
- Title: `Transaction confirmed`
- Keep the title on one line
- Use strong dark text for the title

### From Info

- Horizontal row
- Left label width: `26px`
- Gap between label and details: `12px`
- Keep `From` on one line
- Sender name stays one line
- Sender account stays one line

### To Info

- Same structure as From Info
- Keep `To` on one line
- Merchant name stays one line
- Merchant text uses the darker merchant color

### Amount + QR

- If `availableWidth >= 340`, render amount and QR in one horizontal row.
- Use `CrossAxisAlignment.center` in the horizontal row.
- If `availableWidth < 340`, stack vertically and align the QR block to the right.
- Amount text stays single line.
- Fee text stays single line.
- QR image size: 78x78
- Do not render `Scan to Verify` below the QR image in the current implementation.

### Transaction Details

Render these rows in order:

1. `Date&Time:`
2. `Transaction ID:`
3. `Merchant Ref ID:`
4. `Biller ID:`
5. `Ref 1:`

Rules:

- Fixed label column width: `108px`
- Gap between label and value: `8px`
- Labels left aligned
- Values right aligned
- Values use ellipsis overflow
- `Transaction ID:` and `Merchant Ref ID:` must never wrap
- `transactionDetailRowCount` controls visible rows

### Footer

- Two bullet rows
- Use muted secondary text
- Let the bullet text wrap naturally in the available space

## Background Contract

- Build a private background widget that fills the card.
- Prefer `backgroundImageUrl` when present.
- Otherwise use `backgroundSvgAssetPath`.
- Otherwise fall back to a painter-based watermark.
- Keep the watermark clipped to the card shape.

## Preview Contract

- Create a standalone preview file for this widget.
- Use a simple `MaterialApp`.
- Use `Scaffold`.
- Do not add theme toggles or theme providers.
- Apply `16px` padding around the receipt.
- Do not constrain the receipt to a fixed max width.
- When asset files change, do a full app restart so the bundle is rebuilt.

## Data Contract

Treat these props as the data model for the widget:

- `amount`: main payment amount
- `fee`: fee text shown under the amount
- `senderName`: sender display name
- `senderAccount`: sender account or masked identifier
- `merchantName`: merchant display name
- `dateTime`: transaction timestamp
- `transactionId`: unique transaction ID
- `merchantRefId`: merchant reference ID
- `billerId`: biller identifier
- `ref1`: additional reference field
- `footerNoteOne`: first disclaimer line
- `footerNoteTwo`: second disclaimer line
- `transactionDetailRowCount`: number of visible rows to render

## Implementation Notes for Other Agents

- Prefer composition over inheritance.
- Keep the widget self-contained.
- Keep all text constraints single-line where noted.
- Preserve the 16px rhythm between major sections.
- Use the source assets from `/Users/Niwat.yah/figma/components/receipt` as the design reference and copy them into the target project before wiring the widget.
- If the host project uses different asset paths, update only the asset path props, not the layout logic.
