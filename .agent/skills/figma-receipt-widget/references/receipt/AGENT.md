# AGENT.md

Read this first before touching receipt code in this folder.

## Source Of Truth

- `DESIGN.md`
- `receipt_component.md`
- `receipt_image_component.md`
- `FIGMA.md`
- `receipt_api.md`
- `base-receipt.md`

## What Exists

- `ReceiptComponent`: confirmation-style receipt
- `ReceiptImageComponent`: gallery-saved receipt image state

## Read Order

If you are starting work from this folder, read in this order:

1. `README.md`
2. `AGENT.md`
3. `FIGMA.md`
4. `receipt_api.md`
5. `base-receipt.md`
6. `DESIGN.md`
7. `receipt_component.md`
8. `receipt_image_component.md`

## Assets

Use the source bundle in this folder:

- `check.svg`
- `receipt_background.svg`
- `qr_code_example.png`
- `wiwallet-logo.svg`

Generated preview screenshots belong in `screenshots/`, not in the folder root.

Map asset paths in the target project if needed. Do not change layout rules to fit different paths.

## Rules

- Keep width responsive and height content-driven.
- Do not hard-code a fixed card width.
- Do not use theme tokens for this screen; use the literal colors in the markdown specs.
- Keep the background as a separate clipped layer.
- Keep `Scan to Verify` hidden in both current Flutter states.
- Keep labels that are marked single-line from wrapping.

## State-Specific Contract

- `ReceiptComponent`: rounded card, shadow, confirmation section with 16px horizontal padding and 0px vertical padding, QR without caption, dividers use 12px border radius to match card corners.
- `ReceiptImageComponent`: no radius, no shadow, `Payment` header, `wiwallet-logo.svg`, QR without caption, dividers use no border radius to match square-edged card.

## Preview

- Use a simple standalone Flutter preview.
- Do not add theme toggles or theme providers.
- Use 16px outer padding unless the spec says otherwise.
- Restart fully when bundled assets change.

## Output

- Keep the widget API aligned with the markdown specs.
- Keep background and content separated.
- Update the related markdown if the implementation contract changes.
- Do not merge the two states without updating the specs first.
