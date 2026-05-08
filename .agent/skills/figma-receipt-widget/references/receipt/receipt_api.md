# Receipt API Overview

This file documents the Figma-facing API for the `Receipt` component set.

## Component

- Component set name: `Receipt`
- Figma node: `107:3227`
- Figma file key: `gm0bgMWEOfRT1KwpGgry1w`

## API

### Variant property

| Property | Type | Default | Options | Notes |
|---|---|---:|---|---|
| `state` | variant | `background` | `ReceiptImageComponent`, `ReceiptComponent`, `background` | Top-level variant axis for the component set. |

## State Meaning

### `ReceiptComponent`

- Confirmation-style receipt state.
- Intended for the normal transaction-confirmed receipt view.

### `ReceiptImageComponent`

- Gallery-saved receipt image state.
- Intended for the exported / saved-image version of the receipt.

### `background`

- Internal reference frame.
- Not intended for direct use as a production widget state.

## Sub-components

- None.

The component set does not expose booleans, instance swaps, or slots at the top level in the extracted `_base.json`.

## Notes

- The portable Flutter-facing handoff spec for this family lives in [base-receipt.md](./base-receipt.md).
- Use [DESIGN.md](./DESIGN.md) for implementation mapping and current Flutter behavior.
