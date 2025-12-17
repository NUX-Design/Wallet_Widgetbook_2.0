# 🚀 Release Notes v25.0.5 - New Widgets & Enhanced Preview System

**Release Date:** December 2025
**Branch:** `dev`

---

## ✨ What's New

### 🧩 New Widgets (6 Added)
- **Avatar** - Profile card with status badge (danger/warning) and skeleton loading support.
- **ImageCarousel** - Image slider with auto-play capability and custom indicators.
- **ItemList (Transaction Type)** - Enhanced list item with subtitle, amount display, and dynamic styling for transactions.
- **PreLoading** - Full-screen loading overlay with 10px blur effect and Lottie animation.
- **LottieSkeleton** - Advanced skeleton loading wrapper using Lottie animations.
- **SnackBarWidget** - Custom styled notifications with 3 types: Success, Warning, Error.

### 📚 Documentation Updates
- **WIDGETS_GUIDE.md** - Added comprehensive documentation for all 6 new widgets.
- **CODEBASE_CONTEXT.md** - Updated component count to 20 and added new categories (Display, Loading).
- **CONTRIBUTING.md** - Added "Development Tools" section covering Widgetbook and Code Generation.
- **SETUP_GUIDE.md** - Added optional Widgetbook setup instructions.

### 🛠️ Developer Experience
- **Widgetbook Integration** - Added use cases for all new widgets, enabling interactive testing.
- **Enhanced Previews** - `PreLoading` preview now simulates a transaction list background with alternating colors.
- **Transaction Simulation** - `ItemList` preview now showcases realistic transaction data with positive/negative amounts.

---

## 🔧 Technical Improvements

### Component Architecture
- **Total Components:** 20 widgets (up from 14)
- **Modular Structure:** New dedicated folders for `avatar/`, `image_carousel/`, `loading/`, `skeleton/`, `snack_bar/`.
- **Refined ItemList:** Added `ItemListType` enum for better type safety and extensibility.

### Preview System
- **Realistic Data:** Previews now use dynamic data to simulate real-world scenarios.
- **Interactive Controls:** Widgetbook knobs allow testing different states (e.g., loading, error) easily.

### 🌍 Localization Workflow
- **Centralized Management** - New `localization.json` source of truth for all translations.
- **Automated Generation** - New `tool/generate_arb.dart` script to auto-generate ARB files.
- **Documentation** - Added `lib/l10n/localization_i10n.md` guide.

---

## 🚀 What's Next

### Planned for v25.1.0
- **Navigation System** - Implement go_router integration
- **API Layer** - Repository pattern implementation
- **Testing Suite** - Unit and widget test coverage
- **Performance Optimization** - Image caching and lazy loading

---

# 🚀 Release Notes v2.1.0 - Glass Morphism & Enhanced Architecture

**Release Date:** November 2025  
**Commit:** `b557b84`  
**Branch:** `dev`

---

## ✨ What's New

### 🎨 NavigatorBar Glass Morphism Effect
- **10px Backdrop Blur** - Modern glass-morphism effect using `ImageFilter.blur`
- **Enhanced Visual Depth** - Subtle transparency with backdrop filtering
- **Improved Border Styling** - Updated border color to `alt/base/300` for better contrast
- **Fixed Scan Button Clipping** - Restructured layout with `Stack + ClipRRect` to prevent button truncation

### 🏗️ Component Architecture Improvements
- **Organized Folder Structure** - Moved components into dedicated folders:
  - `button/` - Button components with preview and documentation
  - `shortcut_menu/` - Menu components with SVG icon manipulation
- **Enhanced Documentation** - Added comprehensive guides with compliance scoring:
  - Button Components: **85/100** compliance score
  - Shortcut Menu: **70/100** compliance score

### 🎯 Design System Enhancements
- **New Design Token Variant** - Added `alt/` variant for alternative color schemes
- **Expanded Color Palette** - 100+ design tokens with improved categorization
- **Theme Consistency** - Better color token organization across all components

---

## 🔧 Technical Improvements

### Code Organization
- **14 Total Components** (up from 13)
- **18+ Documentation Files** with detailed implementation guides
- **Improved Import Paths** - Fixed import references across drawer widgets
- **Better Component Isolation** - Self-contained widgets with preview capabilities

### Performance & Quality
- **Type-Safe Design Tokens** - Consistent color access pattern
- **Responsive Design** - MediaQuery-based responsive behavior
- **Theme-Aware Components** - Full light/dark mode support
- **Multi-Language Ready** - 5 language support with proper font handling

---

## 📱 Component Updates

### NavigatorBar
- ✅ Glass-morphism blur effect (10px)
- ✅ Fixed floating scan button clipping
- ✅ Updated border color scheme
- ✅ Improved layout hierarchy

### Button Components
- ✅ Moved to dedicated `button/` folder
- ✅ Added comprehensive documentation
- ✅ 3 button types: primary, secondary, amount
- ✅ Press animations and theme support

### Shortcut Menu
- ✅ New component with SVG icon manipulation
- ✅ Dynamic color customization
- ✅ Theme-aware styling
- ✅ Comprehensive documentation

---

## 🎯 Developer Experience

### Enhanced Documentation
- **Component Compliance Scoring** - Quality metrics for each widget
- **Step-by-Step Guides** - Detailed implementation instructions
- **Preview System** - Individual testing widgets for each component
- **External Device Testing** - Web server support for real device testing

### Project Statistics
- **Total Components:** 14 widgets
- **Supported Languages:** 5 languages
- **Design Tokens:** 100+ color tokens
- **Platform Support:** 6 platforms (iOS, Android, Web, macOS, Linux, Windows)
- **Documentation Coverage:** 18+ guide files

---

## 🔄 Migration Guide

### NavigatorBar Updates
If you're using NavigatorBar, no breaking changes - the blur effect is automatically applied. The component maintains the same API while providing enhanced visual appeal.

### Button Components
Update import paths from:
```dart
import 'package:your_app/widgets/buttons.dart';
```
To:
```dart
import 'package:your_app/widgets/button/buttons.dart';
```

### New Design Tokens
You can now use the new `alt/` variant:
```dart
ThemeColors.get('light', 'alt/base/300')
```

---

## 🐛 Bug Fixes

- ✅ **NavigatorBar Scan Button Clipping** - Fixed layout hierarchy to prevent button truncation
- ✅ **Import Path Issues** - Resolved import references across drawer widgets
- ✅ **Border Color Consistency** - Updated NavigatorBar border to match design system

---

## 🚀 What's Next

### Planned for v2.2.0
- **Navigation System** - Implement go_router integration
- **API Layer** - Repository pattern implementation
- **Testing Suite** - Unit and widget test coverage
- **Performance Optimization** - Image caching and lazy loading
- **Accessibility Enhancements** - Improved a11y support

---

## 📊 Impact Summary

- **Visual Enhancement:** Modern glass-morphism effect
- **Code Quality:** Better organization and documentation
- **Developer Experience:** Improved guides and compliance scoring
- **Maintainability:** Cleaner folder structure and import paths
- **Design System:** Expanded token system with alt/ variant

---

**🎉 Ready to use in production with enhanced visual appeal and better code organization!**

**Made with ❤️ for the Flutter community**