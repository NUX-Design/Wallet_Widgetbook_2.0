# Design System — Receipt Component

## Overview
A clean, trustworthy payment slip interface designed for mobile banking and fintech applications.
The receipt family currently has two Flutter widget states:
- `ReceiptComponent` for the confirmation-style receipt
- `ReceiptImageComponent` for the gallery-saved receipt image state

The portable, implementation-neutral source of truth for this family is [base-receipt.md](./base-receipt.md). Use that file first when handing the component set to another agent or another project.

Both states use structured layout, generous whitespace, a subtle watermark SVG background, and a mostly monochrome palette.
The overall atmosphere is "Minimal-Professional" — informational density is high, but visual noise is low.

## Current Flutter Mapping

This document reflects the current implementation in:

- `/Users/Niwat.yah/flutter_widgetbook_3.0/lib/widgets/receipt/receipt_component.dart`
- `/Users/Niwat.yah/flutter_widgetbook_3.0/lib/widgets/receipt/receipt_image_component.dart`

For cross-project handoff and agent onboarding, prefer [base-receipt.md](./base-receipt.md), then use this file to confirm how the Flutter implementation maps back to the receipt family.

Use this document as the source of truth for the current Flutter widgets, not as a direct mirror of a single Figma state.

## Colors

- This component should use the Figma-derived color values directly in Flutter. Do not route them through a separate semantic token layer for this screen unless the token resolves to the same literal value.
- **Confirmation Green** (`#4CAF50`): success check icon fill
- **Deep Carbon** (`#242424`): primary heading text, especially amount and `Transaction confirmed`
- **Muted Fog** (`rgba(15,15,15,0.45)`): labels, field values, timestamps, and footer copy
- **Midnight Teal** (`#16303e`): merchant name text
- **Warm Gold** (`#DDAD51`): bank logo circle/background
- **Surface White** (`#FFFFFF`): card surface
- **Whisper Divider** (`rgba(0,0,0,0.08)`): section rules and separators
- **Slate Grey** (`#4E5865`): supporting grey referenced in the source system
- **Line Grey** (`#E4E4E4`): outline/border stroke for icons and avatars

### Hard-Coded Palette Guidance

- Keep the receipt palette literal in code for this component.
- If a style is reused elsewhere, it can be tokenized at the app level later, but this receipt spec should describe the concrete values used in the Figma export.
- Preserve the current muted text contrast instead of introducing new semantic shades.

## Typography

- **Primary Font**: Noto Sans Thai / Noto Sans (bilingual support: Thai + Latin)
- **Heading Font**: Noto Sans Bold
- **Label Font**: Noto Sans Thai SemiBold

### Type Scale

| Role | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| `heading/h4/bold` | 22px | Bold (700) | 28px | Transaction amount |
| `heading/title` | 20px | Bold (700) | normal | "Transaction confirmed" |
| `body/x-small/medium` | 11px | Medium (500) | 14px | Fee label |
| `body/x-small/normal` | 11px | Regular (400) | 14px | Field labels, values, footer |
| `body/x-small2/semi-bold` | 10px | SemiBold (600) | 12px | "From" / "To" labels |
| `body/x-small2/normal` | 10px | Regular (400) | 12px | Account numbers, sub-labels |

The amount is the typographic hero at 22px bold — everything else steps down to 10–11px to let the number breathe.
Section labels ("From", "To") use the smallest size (10px) intentionally — they are navigational hints, not content.

## Shape & Geometry

- **Card**: Subtly rounded corners (12px radius) — approachable but structured, not playful
- **Avatar/Logo circles**: Fully pill-shaped (border-radius 999px) — consistent circular containers for bank and merchant logos
- **Dividers**: Full-width hairlines (1px) — `ReceiptComponent` uses 12px border radius to match the card corners; `ReceiptImageComponent` uses no radius to match its square-edged card
- **QR Code container**: Fixed square (78×78px) with no border decoration — functional, scan-ready

## Elevation & Depth

The card uses a layered shadow strategy to lift content off the background:

```
Primary card shadow:  0px 4px 4px rgba(0,0,0,0.25)
Ambient glow (light): 0px 24px 48px -10px rgba(0,0,0,0.04)
                      0px 16px 10px  -7px rgba(0,0,0,0.04)
                      0px 23px 28px  -7px rgba(0,0,0,0.04)
Ambient glow (medium):0px 24px 48px -10px rgba(0,0,0,0.08)
                      0px 16px 10px  -7px rgba(0,0,0,0.08)
                      0px 23px 28px  -7px rgba(0,0,0,0.08)
```

Dividers use only the medium ambient shadow — they float without casting hard edges.
The overall depth feel is: **Whisper-soft multi-layer shadows**, not dramatic. The receipt should feel like paper lifted gently off a surface.

## Layout & Spacing

- **Card size**: The Figma artboard is `343 × 651`, but the Flutter widget should remain responsive in width and dynamic in height
- **Card padding**: 16px on all sides (`--spacing/sm`)
- **Section gap**: 16px between each major section (`gap-[16px]`)
- **Inner field gap**: 8px between row items within a section (`--spacing/xs2`)
- **Logo to text gap**: 12px (`--spacing/xs`)
- **Content opacity**: 85% on the content wrapper — the watermark background subtly shows through

### Responsive Sizing Rules

- **Width**: The Flutter widget should remain responsive to the available device width, even though the Figma artboard is a fixed 343px-wide receipt
- **Height**: The Flutter widget should remain content-driven and expand or contract with the content rendered inside it
- **Constraint**: The layout should preserve padding, spacing, and readability at all supported screen sizes without clipping or overflow

### Grid Behavior

Each info row uses a two-column flex layout:
- Left: label, fixed or shrink-wrapped width
- Right: value, `flex-1` with `text-right` alignment and ellipsis overflow

### Single-Line Constraints

Some labels must never wrap to a second line in the Flutter implementation:
- `From`
- `Transaction ID:`
- `Merchant Ref ID:`

Use a single-line text constraint for these labels and clip or truncate overflow instead of allowing line breaks. Keep the label column wide enough to preserve readability on mobile widths.

### Amount Alignment

The amount and QR block should sit on the same row when width allows it, with the amount section vertically centered against the QR block. On narrow widths, the layout may stack, but the amount itself should remain visually centered within its available horizontal lane.

## Components

- **Check Icon**: 52×52px circle, confirmation green fill, white checkmark vector inside
- **Confirmation Section Padding**: 16px horizontal padding, 0px vertical padding, with a 16px gap between the icon and the title
- **Bank Logo**: 48×48px circular avatar, gold background, white bank emblem
- **Merchant Logo**: 48×48px circular container, brand-colored background with centered storefront icon
- **QR Code**: 78×78px square image; no caption below in the current implementation
- **QR Caption**: hidden in the Flutter receipt preview to keep the QR area visually clean
- **Divider**: Full-width 1px line using `--utility/shade/200`, separates each content section
- **Footer**: Bulleted list (disc) at 11px, muted color — two line items for legal/service notice
- **Detail Rows**: Fixed label column with right-aligned value column; labels such as `Transaction ID:` and `Merchant Ref ID:` must remain single-line and never wrap
- **Background SVG**: The receipt watermark/background is the dedicated SVG at Figma node `104:1584`; it should be used as the background layer behind the content, clipped to the rounded card

## Sections (Top to Bottom)

1. **Confirmation Section** — Check icon + "Transaction confirmed" title, centered, with 16px left/right padding and 0px top/bottom padding
2. **From Info** — Sender bank logo, name, masked account number
3. **To Info** — Merchant logo, merchant name
4. **Amount + QR** — Large bold amount left, QR code right, fee below amount
5. **Transaction Details** — Date/Time, Transaction ID, Merchant Ref ID, Biller ID, Ref 1
6. **Footer** — Two bullet disclaimers and customer service info

## Do's and Don'ts

- **Do** keep the amount text (#242424, 22px bold) as the single visual focal point per receipt
- **Do** use circular avatars for all logo/icon containers — never squares
- **Do** pair every section with a hairline divider — structure requires clear boundaries
- **Do** support Thai + Latin in all text nodes using Noto Sans Thai with Noto Sans fallback
- **Do** make the receipt width responsive across devices and let height follow content dynamically
- **Do** use the Figma SVG background node `104:1584` as the receipt watermark layer
- **Do** keep `From`, `Transaction ID:`, and `Merchant Ref ID:` on one line in the Flutter widget, even on narrow screens
- **Do** vertically center the amount block against the QR block when the layout is horizontal
- **Do** treat the color palette as literal values for this component, not as a generic token abstraction
- **Don't** use more than two type sizes in any single section — compression creates confusion
- **Don't** increase shadow intensity beyond the defined multi-layer ambient values — heavy shadows feel untrustworthy for financial UI
- **Don't** swap in a different neutral palette or auto-generated token shade for the text colors
- **Don't** remove the background watermark opacity — it is a deliberate anti-fraud visual cue

## Variant: Receipt Image State

This is the auto-saved-to-gallery variant of the receipt. It reuses the same receipt body content but changes the top treatment and removes the rounded card shape.

### Visual Differences

- No rounded corners on the outer receipt card
- No confirmation/check section
- A compact header row appears at the top instead
- The header contains `Payment` on the left and the `wiwallet-logo.svg` mark on the right
- The overall card is shadowless and square-edged, matching the gallery-saved export

### Header Rules

- Title text: `Payment`
- Title weight: bold
- Title size: `15px`
- Title color: `#242424`
- Right side: `wiwallet-logo.svg` branding
- Header sits in a single row with `16px` between left and right groups
- The header replaces the confirmation section used by the detail receipt state

### Layout Rules

- The outer receipt surface is square-edged
- The background watermark remains the same style family as the detail receipt
- The content still uses 85% opacity
- The receipt body still uses the same receipt detail rows, QR block, footer, and single-line constraints
- The image state keeps the same responsive width behavior as the detail receipt
- The header logo is a single `wiwallet-logo.svg` asset rendered at `86x20`
- The outer card has no shadow in this variant

## Implementation Notes

- `ReceiptComponent` still uses the confirmation section at the top and a rounded card with layered shadow.
- `ReceiptImageComponent` replaces the confirmation section with a `Payment` header and `wiwallet-logo.svg`, and removes the rounded card and shadow.
- In both widgets, the QR block currently does not render a `Scan to Verify` caption.
- The background watermark should come from `receipt_background.svg` and be clipped to the card bounds.

## Handoff Hierarchy

- `base-receipt.md` = portable component specification for other agents / projects
- `DESIGN.md` = Flutter implementation mapping and family-wide visual contract
- `receipt_component.md` = standard confirmation receipt state
- `receipt_image_component.md` = gallery-saved receipt image state
