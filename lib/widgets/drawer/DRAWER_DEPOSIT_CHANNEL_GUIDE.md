# DrawerDepositChannel Widget

Bottom-sheet drawer presenting a list of supported deposit channels (mobile banking) with theme-aware styling.

## 📋 Overview

`DrawerDepositChannel` แสดงรายการธนาคารด้วยโลโก้ ชื่อ และปุ่มปิดด้านบน เหมาะสำหรับใช้เป็น modal bottom sheet เมื่อผู้ใช้ต้องเลือกช่องทางฝากเงินก่อนดำเนินการต่อ

## 🎨 Layout & Design Tokens

https://www.figma.com/design/D7WVaC8n3foVLo6S3HuPn8/New-Wi-Wallet-2.0?node-id=7066-12327&t=sYCnD6dsF9QpTyn1-4

- Height: `min(MediaQuery.of(context).size.height * 0.80, 640)` เพื่อไม่ให้สูงเกิน design spec
- Padding: `EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 0)`
- Border radius: 16 px เฉพาะด้านบน `Radius.circular(16)`
- Background: `ThemeColors.get(brightnessKey, 'fill/base/100')`
- Header text: `GoogleFonts.notoSansThai` 15 px, weight 600, สี `text/base/600`
- Label "Mobile Banking":
  - Background: `fill/base/600`
  - Text: 10 px, weight 600, สี `text/base/600`
- Bank item container:
  - Height 56 px, padding `EdgeInsets.symmetric(horizontal: 16, vertical: 8)`
  - Background: `fill/base/300`, radius 12 px
  - Text: 13 px, weight 600, สี `text/base/600`
- Icons:
  - Close button: `cancel-01.svg` 24 px, สี `text/base/600`
  - Bank logos: SVG assets ที่ crop จาก Figma export โดยตรงใน `lib/assets/images/figma_banks/`
  - ไม่มี trailing arrow ในแต่ละแถวตาม Figma

## 🚀 Usage Example

### Using Static Show Method (Recommended)

```dart
DrawerDepositChannel.show(
  context,
  onBankSelected: (bank) {
    Navigator.pop(context);
    // Handle selected bank type
    print('Selected: ${bank.name}');
  },
);
```

### Manual Implementation

```dart
showModalBottomSheet(
  context: context,
  backgroundColor: Colors.transparent,
  isScrollControlled: true,
  barrierColor: const Color.fromRGBO(0, 0, 0, 0.5),
  builder: (context) => BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
    child: DrawerDepositChannel(
      onClose: () => Navigator.pop(context),
      onBankSelected: (bank) {
        // Handle selected bank type
      },
    ),
  ),
);
```

## 🔧 Preview Utilities

รันตัวอย่างพร้อมธีมมืดเป็นค่าเริ่มต้นได้ที่:

```bash
flutter run lib/widgets/drawer/preview_drawer_deposit_channel.dart
```

ไฟล์ preview มี:
- ปุ่ม "Show Drawer" ที่เรียก `DrawerDepositChannel.show()` method
- Theme toggle (light/dark) ผ่าน `ThemeProvider`
- ใช้ locale อังกฤษเป็นค่าเริ่มต้นเพื่อให้ตรงกับ Figma node นี้
- เปิด drawer อัตโนมัติครั้งแรกเพื่อใช้ตรวจ visual บน simulator ได้ทันที
- Overlay style (background blur + barrierColor) จัดการโดย show method

## 🎯 Properties

### Widget Properties

| Property          | Type                      | Required | Description                                          |
|-------------------|---------------------------|----------|------------------------------------------------------|
| `onClose`         | `VoidCallback?`           | No       | เรียกเมื่อผู้ใช้กดไอคอนปิด                          |
| `onBankSelected`  | `Function(BankType)?`     | No       | คืนค่า enum `BankType` เมื่อเลือกธนาคารแต่ละแถว      |

### Static Show Method

| Parameter         | Type                      | Required | Description                                          |
|-------------------|---------------------------|----------|------------------------------------------------------|
| `context`         | `BuildContext`            | Yes      | Build context สำหรับแสดง modal                      |
| `onBankSelected`  | `Function(BankType)?`     | No       | Callback เมื่อเลือกธนาคาร                           |

## 🗂️ BankType Enum

```dart
enum BankType { scb, kbank, bbl, krungsri }
```

การ mapping ถูกจัดการผ่านเมธอด `_getBankName` และ `_getBankLogo` ที่คืนค่าข้อความและพาธ asset ตาม enum

## ♻️ Behaviour Notes

- รายการธนาคารถูกจัดเป็น 4 ธนาคารตามลำดับใน Figma: `SCB`, `Bangkok Bank`, `Krungsri`, `Kasikorn`
- item แต่ละแถวเป็น `GestureDetector` ที่เรียก `onBankSelected?.call(bank)` เมื่อแตะ
- ตัว drawer ไม่ปิดอัตโนมัติเมื่อเลือก จำเป็นต้องจัดการใน callback (ดูตัวอย่าง preview ที่เรียก `Navigator.pop`)
- ไม่มีสถานะเลือก/hover ให้เพิ่มได้หากต้องการความชัดเจนเพิ่มเติม

## 📝 Implementation Highlights

- ใช้ `ThemeColors` เพื่อให้สอดคล้องกับ design tokens ของโปรเจกต์
- พึ่งพา `GoogleFonts.notoSansThai` เพื่อความคงที่ของ typography
- ใช้ `SvgPicture.asset` ทั้งสำหรับโลโก้ธนาคารที่ export มาจาก Figma และปุ่มปิด เพื่อให้คมชัดบนทุกขนาดจอ
- ความสูงของ drawer ถูก cap ที่ 640 px ให้ใกล้ Figma มากขึ้น
- **Static show method**: มี overlay style (barrierColor + BackdropFilter blur 10px) ตาม Figma specs
- **Consistent pattern**: ใช้ pattern เดียวกับ DrawerReviewTransaction และ DrawerBalanceDetail
- **Height**: `min(80% ของหน้าจอ, 640)`

## 📱 Edge-to-Edge & Gesture Navigation Support

Widget นี้รองรับการแสดงผลแบบ **Edge-to-Edge** บนอุปกรณ์ทั้ง Android และ iOS:

1.  **Gesture Navigation Bar (Android) / Home Indicator (iOS)**:
    - มีการคำนวณ `bottomPadding` จาก `MediaQuery.of(context).viewPadding.bottom`
    - เพิ่มพื้นที่ด้านล่างสุดของ Drawer เพื่อไม่ให้ปุ่มกดทับซ้อนกับ System Navigation Bar
    - พื้นที่นี้ใช้สี `fill/base/100` (สีเดียวกับ Background) พร้อม `BackdropFilter` (Blur 10px) เพื่อความสวยงามและ Seamless

2.  **Safe Area**:
    - เนื้อหาและปุ่มกดจะถูกดันขึ้นมาจากขอบล่างโดยอัตโนมัติเมื่ออยู่บนอุปกรณ์ที่มี Notch หรือ Gesture Bar

```dart
// ตัวอย่างการคำนวณในโค้ด
final bottomPadding = mediaQuery.viewPadding.bottom > 0
    ? mediaQuery.viewPadding.bottom
    : mediaQuery.padding.bottom;

// ...

if (bottomPadding > 0)
  ClipRRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        height: bottomPadding,
        color: ThemeColors.get(brightnessKey, 'fill/base/100').withValues(alpha: 0.9),
      ),
    ),
  ),
```

## 🔄 Recent Updates

**v2.1 - Figma Logo Import + Spec Alignment**
- ใช้โลโก้ธนาคารจาก Figma export จริงใน `lib/assets/images/figma_banks/` แบบ SVG
- ปรับหัวข้อเป็น `Deposit Channel`
- ลดรายการเหลือ 4 แถวตาม Figma และเอา trailing arrow ออก
- ปรับ typography ของ bank rows เป็น 13 px / 600
- จำกัดความสูง drawer ไม่เกิน 640 px
- อัปเดต preview ให้เปิด drawer อัตโนมัติสำหรับ visual review

## ✅ Checklist ก่อนใช้งานจริง

1. ตรวจสอบว่า assets ใน `lib/assets/images/figma_banks/` และ `cancel-01.svg` ถูก include ใน `pubspec.yaml`
2. หากโลโก้ใน Figma เปลี่ยน ควร export/crop ชุดใหม่แทนการแก้สีในโค้ด
3. เพิ่ม localization สำหรับชื่อธนาคารหากต้องรองรับหลายภาษา
4. ทดสอบในธีมมืด/สว่างว่า contrast ของสีอ่านได้ชัดเจน
5. **แนะนำ**: ใช้ `DrawerDepositChannel.show()` method แทน manual implementation

---

**Design Source**: สร้างตามแนวทาง bottom-sheet และ design tokens ที่กำหนดใน Wi Wallet design system
