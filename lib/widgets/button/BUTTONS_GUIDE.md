# Buttons Widget Guide

## Overview
The `Buttons` widget is a versatile, theme-aware button component that supports multiple button types with consistent styling across the application. It follows the project's design token system and provides interactive feedback with animations.

## Figma Source
- File: `New Wi Wallet 2.0`
- Component set: `buttons`
- Source component link: [Buttons component in Figma](https://www.figma.com/design/D7WVaC8n3foVLo6S3HuPn8/New-Wi-Wallet-2.0?node-id=7066-6424&m=dev)
- Figma variants currently available:
  - `Role=Primary, State=Enabled`
  - `Role=Secondary, State=Enabled`
  - `Role=Secondary, State=Disabled`
  - `Role=Amount, State=Enabled`

## Design Specifications

### Button Types
- **Primary**: Main action button with primary brand color
- **Secondary**: Secondary action button with contrast styling and border
- **Amount**: Specialized button for amount selection with currency handling

### Dimensions
- **Height**: 40px (fixed)
- **Padding**: 16px horizontal
- **Border Radius**: 999px (fully rounded)
- **Border Width**: 1px (for secondary and amount types)

### Typography
- **Font**: Noto Sans Thai
- **Font Size**: 15px
- **Line Height**: 1.33
- **Font Weight**: 700 (Bold)

### Interactive States
- **Pressed Animation**: Scale down to 0.95 with 100ms duration
- **Disabled State**: Reduced opacity and different color scheme

## Design Token Usage

### Primary Button (Enabled)
- **Background**: `primary/400`
- **Text**: `fill/contrast/600`
- **Border**: None

### Secondary Button (Enabled)
- **Background**: `fill/contrast/600`
- **Text**: White (light mode) / `text/base/600` (dark mode)
- **Border**: `text/base/600`
- **Shadow**: rgba(24, 40, 40, 0.05) with 2px blur

### Amount Button (Enabled)
- **Background**: `fill/contrast/600`
- **Text**: White (light mode) / `text/base/600` (dark mode)
- **Border**: `text/base/600`
- **Shadow**: rgba(24, 40, 40, 0.05) with 2px blur

### Disabled States
- **Figma-shipped disabled variant**: `Secondary/Disabled`
- **Background**: `alt/base/600`
- **Text**: `text/base/400`
- **Border**: none
- **Shadow**: rgba(24, 40, 40, 0.05) with 2px blur
- **Fallback for non-Figma disabled roles in Flutter**: `fill/base/300` background, `text/base/400` text, `stroke/base/200` border

## Code Review Analysis

### ✅ Compliant with Project Standards
1. **Design Tokens**: Properly uses `ThemeColors.get()` for consistent theming
2. **Theme Awareness**: Correctly implements light/dark mode switching
3. **Typography**: Uses `GoogleFonts.notoSansThai()` for multi-language support
4. **State Management**: Implements proper StatefulWidget pattern
5. **Animation**: Smooth press animation with `AnimatedScale`
6. **Accessibility**: Proper gesture handling and disabled states

### ⚠️ Areas for Improvement
1. **Hardcoded Colors**: Some text colors use hardcoded values instead of design tokens
   ```dart
   // Current (inconsistent)
   textColor = brightnessKey == 'light' 
       ? const Color(0xFFFFFFFF) 
       : ThemeColors.get(brightnessKey, 'text/base/600');
   
   // Should use design tokens consistently
   textColor = ThemeColors.get(brightnessKey, 'text/contrast/600');
   ```

2. **Shadow Values**: BoxShadow uses hardcoded color values
   ```dart
   // Current
   color: const Color(0x10182828).withValues(alpha: 0.05),
   
   // Could use design token
   color: ThemeColors.get(brightnessKey, 'shadow/base/100'),
   ```

3. **Currency Logic**: Amount button has specific Thai Baht (฿) handling that could be more flexible

## Usage Examples

### Basic Primary Button
```dart
Buttons(
  text: 'Confirm',
  type: ButtonType.primary,
  onPressed: () => print('Primary pressed'),
)
```

### Secondary Button with Disabled State
```dart
Buttons(
  text: 'Secondary Disabled',
  type: ButtonType.secondary,
  enabled: false,
)
```

### Amount Button
```dart
Buttons(
  text: '฿100',
  type: ButtonType.amount,
  onPressed: () => selectAmount(100),
)
```

## Integration with Other Components

### Used In
- **DrawerReviewTransaction**: Confirm button
- **DrawerBalanceDetail**: Action buttons
- **Various forms**: Submit/cancel actions

### Dependencies
- `ThemeColors`: Design token system
- `GoogleFonts`: Typography system
- `Provider`: Theme switching (in preview)

## File Structure
```
lib/widgets/button/
├── buttons.dart                 # Main button widget
├── preview_buttons.dart         # Preview with theme switching
└── BUTTONS_GUIDE.md            # This documentation
```

## Preview Features
The preview file demonstrates:
- All button types and states
- Theme switching functionality
- Multi-language support
- Interactive feedback
- Proper spacing and layout

## Recommendations

1. **Standardize Color Usage**: Replace hardcoded colors with design tokens
2. **Add Shadow Tokens**: Create design tokens for shadow values
3. **Flexible Currency**: Make currency handling more configurable
4. **Add More Types**: Consider adding danger, success, warning button types
5. **Size Variants**: Add small/large button size options

## Current Alignment Note

The Flutter widget is now aligned to the current Figma disabled state for the shipped component set. If additional variants such as `Primary/Disabled` or `Amount/Disabled` are added in Figma later, the Flutter fallback should be replaced with those exact specs.
