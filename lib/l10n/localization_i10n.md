# Workflow ระบบ Localization (i10n) ของโปรเจกต์

เอกสารนี้อธิบายขั้นตอนการทำงานของระบบ Localization ที่ใช้ในโปรเจกต์นี้ ซึ่งมีการปรับแต่งให้ทำงานร่วมกับไฟล์ `localization.json` (ที่ได้จากการ Export Google Sheets) เพื่อความสะดวกในการจัดการภาษา

## ภาพรวมของ Workflow

1.  **Source of Truth:** `localization.json` (ไฟล์ข้อมูลดิบ)
2.  **Generation Script:** `tool/generate_arb.dart` (แปลง JSON -> ARB)
3.  **Intermediate Files:** `lib/l10n/*.arb` (ไฟล์มาตรฐาน Flutter)
4.  **Flutter Generator:** `flutter gen-l10n` (แปลง ARB -> Dart Code)
5.  **Usage:** `AppLocalizations` (นำไปใช้ใน Widget)

---

## ขั้นตอนการทำงาน (Step-by-Step)

กระบวนการนี้เปรียบเสมือน **"สายพานการผลิต" (Pipeline)** ที่แปลงข้อมูลดิบให้กลายเป็นโค้ดที่แอปฯ ใช้งานได้จริง

### 1. อัปเดตข้อมูลภาษา (Source of Truth)
แก้ไขข้อมูลที่ไฟล์ `localization.json` ที่ Root ของโปรเจกต์ (ไฟล์นี้คือต้นฉบับที่เราดูแล)
*   **ทำไม:** เพื่อความสะดวกในการจัดการทุกภาษาในไฟล์เดียว ไม่ต้องเปิดแก้หลายไฟล์
*   **รูปแบบ:** JSON Array ของ Object

**ตัวอย่าง `localization.json`:**
```json
[
  {
    "Name": "welcomeMessage",
    "EN": "Welcome {name}",
    "TH": "ยินดีต้อนรับ {name}",
    "description": "Greeting message on home screen"
  }
]
```

### 2. แปลงเป็นมาตรฐาน Flutter (Generate ARB)
รันคำสั่งเพื่อแปลง `localization.json` ให้เป็นไฟล์ `.arb` (Application Resource Bundle)

**คำสั่ง:**
```bash
dart run tool/generate_arb.dart
```

*   **ทำไมต้องทำ:** Flutter ไม่รู้จักไฟล์ JSON ของเราโดยตรง แต่ใช้มาตรฐาน ARB ในการทำงาน
*   **สิ่งที่เกิดขึ้น:**
    *   อ่าน `localization.json`
    *   สร้าง/อัปเดตไฟล์ `lib/l10n/app_en.arb`, `app_th.arb` ฯลฯ
    *   *ณ จุดนี้: เราได้ไฟล์ข้อมูลมาตรฐานแล้ว แต่โค้ด Dart ยังไม่รู้จักตัวแปรใหม่*

### 3. สร้างโค้ด Dart (Generate Dart Code)
รันคำสั่งของ Flutter เพื่อสร้างคลาส `AppLocalizations` จากไฟล์ `.arb`

**คำสั่ง:**
```bash
flutter gen-l10n
```

*   **ทำไมต้องทำ:** เพื่อให้เราสามารถเรียกใช้ตัวแปรในโค้ดได้ (เช่น `AppLocalizations.of(context)!.welcomeMessage`)
*   **สิ่งที่เกิดขึ้น:**
    *   Flutter อ่านไฟล์ `.arb` ทั้งหมด
    *   สร้างไฟล์ Dart จริงๆ (Generated Code) ที่มี Getter method สำหรับทุก Key
    *   *ณ จุดนี้: IDE จะรู้จักตัวแปรใหม่ และ Auto-complete จะทำงาน*

### 4. ตรวจสอบความถูกต้อง (Verify)
รันคำสั่งตรวจสอบคุณภาพโค้ด

**คำสั่ง:**
```bash
flutter analyze
```

*   **ทำไมต้องทำ:** เพื่อเช็คว่าเราไม่ได้ลบ Key ที่ยังถูกเรียกใช้อยู่ในโค้ด หรือมีการเรียกใช้ Key ที่ไม่มีอยู่จริง
*   **สิ่งที่เกิดขึ้น:** หากมี Error (เช่น Undefined getter) จะแจ้งเตือนทันที

---

## การนำไปใช้งานใน Widget (Usage)

เมื่อผ่านขั้นตอนข้างต้นแล้ว สามารถเรียกใช้ข้อความในโค้ดได้ทันทีผ่าน `AppLocalizations`

### การเรียกใช้ทั่วไป
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ใน build method
Text(AppLocalizations.of(context)!.welcomeMessage('Tony'))
```

### การตั้งค่าใน `MaterialApp` (ทำครั้งเดียว)
ในไฟล์ `lib/main.dart`:
```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

MaterialApp(
  title: 'Wi Wallet',
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  // ...
);
```

---

## สรุปคำสั่งที่ต้องใช้ (Cheatsheet)

เมื่อมีการแก้ `localization.json`:

1.  `dart run tool/generate_arb.dart` (สร้าง ARB)
2.  `flutter gen-l10n` (สร้าง Dart)
3.  `flutter analyze` (ตรวจสอบ)
