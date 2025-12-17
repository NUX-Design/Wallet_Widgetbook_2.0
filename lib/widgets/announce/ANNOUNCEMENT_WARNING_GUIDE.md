# AnnouncementWarning Widget

Static warning alert component for displaying important cautionary messages.

## 📋 Overview

`AnnouncementWarning` เป็น widget แสดงข้อความเตือนแบบคงที่ ไม่หายไปเอง เหมาะสำหรับแสดงข้อมูลสำคัญที่ผู้ใช้ต้องอ่านและรับทราบ เช่น คำเตือนก่อนทำธุรกรรม หรือข้อมูลความปลอดภัย

## 🎨 Design Specs (Based on Figma)

https://www.figma.com/design/D7WVaC8n3foVLo6S3HuPn8/New-Wi-Wallet-2.0?node-id=7089-198760&t=15GhVT2vXbRlmdTk-4

- **Background Token**: `warning/600`
- **Text Token**: `text/base/warning`
- **Icon**: `lib/assets/images/Alert Icon.svg` tinted with `warning/500` at 24×24px
- **Border Radius**: 12px
- **Padding**: 16/8/16/8 (left/top/right/bottom)
- **Font**: Noto Sans Thai
  - Title: 11px, weight 700, line-height 1.27
  - Description: 11px, weight 500, line-height 1.45
- **Gap**: 4px between icon-text and title-description

## 📦 Import

```dart
import 'package:mcp_test_app/widgets/announce/announcement_warning.dart';
```

## 🚀 Usage

### Basic Usage (With Title)

```dart
AnnouncementWarning(
  title: 'Please recheck information before proceeding',
  description: 'To prevent wrong account transfers or fraudulent activities. It cannot be changed once confirmed.',
)
```

### Usage Without Title

```dart
AnnouncementWarning(
  title: '', // Empty title
  description: '*Hold Amount means they aren\'t immediately available for use.',
)
```

### Advanced Usage (Custom Text Styling)

```dart
AnnouncementWarning(
  title: '',
  description: '', // Not used when descriptionSpans is provided
  descriptionSpans: [
    TextSpan(
      text: '*Hold Amount',
      style: TextStyle(fontWeight: FontWeight.w700), // Bold
    ),
    TextSpan(
      text: ' means they aren\'t immediately available for use.',
      style: TextStyle(fontWeight: FontWeight.w500), // Normal
    ),
  ],
)
```

## 🌟 Behaviour

- แสดงข้อความเตือนแบบคงที่ (ไม่หายไปเอง)
- ใช้สีจาก Design Tokens (`warning/600`, `warning/500`, `text/base/warning`)
- รองรับข้อความหลายบรรทัด
- ไม่มีแอนิเมชัน (static display)
- **Title แสดงเฉพาะเมื่อไม่ว่าง** (if title.isNotEmpty)
- **Icon และ text จัดชิดด้านบน** (crossAxisAlignment: start)
- **รองรับ custom text styling** ผ่าน descriptionSpans parameter

## 🎯 Properties

| Property           | Type              | Required | Default | Description                                      |
|--------------------|-------------------|----------|---------|--------------------------------------------------|
| `title`            | `String`          | Yes      | -       | หัวข้อข้อความเตือน (ตัวหนา, แสดงเฉพาะเมื่อไม่ว่าง) |
| `description`      | `String`          | Yes      | -       | รายละเอียดข้อความเตือน                          |
| `descriptionSpans` | `List<TextSpan>?` | No       | null    | Custom text spans สำหรับ description (optional) |

## 🎨 Design Tokens Used

- **Background**: `warning/600`
- **Text**: `text/base/warning`
- **Icon Tint**: `warning/500`
- **Font**: `GoogleFonts.notoSansThaiTextTheme()` for Thai language support
- **Layout**: Row layout with icon และข้อความแบบคอลัมน์เดียว

## 🔄 Comparison with AnnouncementStack

| Feature             | AnnouncementStack      | AnnouncementWarning   |
|---------------------|------------------------|-----------------------|
| **Purpose**         | Rotating announcements | Static warning alert  |
| **Animation**       | Slide/fade animations  | No animation          |
| **Dismiss**         | Auto-rotate on dismiss | ไม่รองรับการกดปิด    |
| **Multiple Items**  | Stack of 3 cards       | Single alert          |
| **Theme Support**   | Light/Dark tokens      | Fixed warning tokens  |
| **Use Case**        | News/updates           | Warnings/cautions     |

## 🧪 Preview

รันตัวอย่างพร้อมสลับธีม/ภาษาได้ที่:

```bash
flutter run lib/widgets/announce/preview_announcement_warning.dart
```

ไฟล์ preview มี:
- ตัวเลือกธีม (light/dark) - แต่ widget ใช้สีคงที่
- Selector สำหรับ locale ที่อาศัย `AppLocalizations`

## ⚠️ Notes & Recommendations

1. **Fixed Colors**: Widget ใช้สีคงที่ตาม Figma spec ไม่เปลี่ยนตามธีม
2. **Thai Font**: ใช้ Noto Sans Thai เพื่อรองรับภาษาไทย
3. **Accessibility**: ควรใช้ semantic labels สำหรับ screen readers
4. **Content Length**: ข้อความยาวจะ wrap อัตโนมัติ
5. **Dismiss State**: ไม่มีปุ่มปิด (เจ้าของหน้าจอควบคุมการแสดงผลเอง)
6. **Flexible Title**: Title เป็น optional - ส่งค่าว่าง ('') เพื่อแสดงแค่ description
7. **Custom Styling**: ใช้ descriptionSpans เพื่อ customize text style (เช่น bold บางคำ)
8. **Reusable Base Widget**: ไม่มี hardcoded logic - customize ได้ตามต้องการ

## 📱 Material Design Compliance

Widget นี้ปฏิบัติตาม Material Design guidelines สำหรับ warning states:
- ใช้สี warning standard
- มี clear visual hierarchy
- รองรับ accessibility
- ใช้ appropriate typography scale

## 🔧 Customization

### Custom Text Styling

```dart
// ทำให้บางคำเป็น bold
AnnouncementWarning(
  title: '',
  description: '',
  descriptionSpans: [
    TextSpan(
      text: 'Important: ',
      style: TextStyle(fontWeight: FontWeight.w700),
    ),
    TextSpan(
      text: 'This action cannot be undone.',
      style: TextStyle(fontWeight: FontWeight.w500),
    ),
  ],
)
```

### Create Error Variant

```dart
class AnnouncementError extends AnnouncementWarning {
  const AnnouncementError({
    super.key,
    required super.title,
    required super.description,
  });

  @override
  Widget build(BuildContext context) {
    // Override colors for error state
    // Background: #FFEBEE (Error background)
    // Text: #C62828 (Error text)
    // etc.
  }
}
```

## 💡 Usage Examples

### In DrawerBalanceDetail

```dart
// ใช้ descriptionSpans เพื่อทำ "*Hold Amount" เป็น bold
AnnouncementWarning(
  title: '',
  description: '',
  descriptionSpans: [
    TextSpan(
      text: '*Hold Amount',
      style: TextStyle(fontWeight: FontWeight.w700),
    ),
    TextSpan(
      text: ' means they aren\'t immediately available.',
    ),
  ],
)
```

### In DrawerReviewTransaction

```dart
// ใช้ title และ description ปกติ
AnnouncementWarning(
  title: 'Please recheck information',
  description: 'To prevent wrong account transfers.',
)
```

---

**Based on Figma Design**: Component ถูกสร้างตาม Figma spec node `state=warning` ใน New Wi Wallet 2.0 design system
