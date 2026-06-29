# Widget Test Plan

เอกสารนี้สรุปการวิเคราะห์ widget ทั้งหมดใน repo และแปลงเป็นแผนทดสอบแบบ production-ready

## เป้าหมาย

- ยืนยันว่า widget แต่ละตัว render ได้ถูกต้องทั้ง light/dark
- ยืนยัน interaction หลัก เช่น tap, focus, clear, close, select, show modal
- ป้องกัน regression ของ layout, callback, state transition, และ localization
- แยก widget ที่ควรใช้ widget test, integration test, หรือ golden test ให้ชัด

## ภาพรวมสถานะปัจจุบัน

### มี test อยู่แล้ว

- `Buttons`
- `ItemList`
- `DrawerBalanceDetail`
- `DrawerDepositChannel`
- `SnackBarWidget`
- `ImageCarousel`
- App/theme bootstrap
- Font localization

### ยังขาดหรือ coverage บางมาก

- `FullAmountInput`
- `MobileCodeInput`
- `SearchInput`
- `NavigatorBar`
- `Avatar`
- `AnnouncementStack`
- `AnnouncementWarning`
- `AnnouncementDanger`
- `CardReviewTransaction`
- `DrawerCountryCode`
- `DrawerReviewTransaction`
- `ReceiptComponent`
- `ReceiptImageComponent`
- `PreLoading`
- `LottieSkeleton`
- `HorizontalTabs`
- `ShortcutMenuItem`
- `VisaCard`

## หลักการทดสอบที่แนะนำ

### 1. Widget Test

ใช้กับ widget ที่มี state, callback, text, icon, focus, หรือ conditional rendering

### 2. Integration-style Widget Test

ใช้กับ modal sheet, `show()` helper, snackbar, navigation pop/push, และ flow ที่มี side effect

### 3. Golden Test

ใช้กับ widget ที่ layout ซับซ้อนมากและเน้นภาพ เช่น receipt, visa card, loading overlay, announcement stack

### 4. Shared Test Harness

- wrapper `MaterialApp`
- wrapper theme light/dark
- wrapper localization ที่ต้องใช้ `AppLocalizations`
- helper สำหรับ pump modal bottom sheet
- helper สำหรับ fake timer / auto-play
- helper สำหรับ asset-heavy widgets

## วิเคราะห์ราย Widget

### `Buttons`

สถานะ: มี test บางส่วนแล้ว

ควรเพิ่ม:
- render test ครบทุก type: `primary`, `secondary`, `amount`
- enabled/disabled style ใน light/dark
- pressed state animation
- callback invocation เมื่อ enabled
- amount text normalization เช่น ตัด `฿`

ความเสี่ยง:
- style regression จาก token
- pressed interaction เสียโดยไม่รู้ตัว

Priority: สูง

### `ItemList`

สถานะ: มี test พื้นฐานแล้ว

ควรเพิ่ม:
- common item พร้อม `iconPath`
- selected/unselected radio state
- transaction in/out icon mapping
- trailing text vs amount precedence
- callback `onTap`
- overflow/ellipsis เมื่อ title หรือ subtitle ยาว

ความเสี่ยง:
- asset mapping ผิด
- trailing widget precedence ผิด
- transaction state แสดงผิดสี/ผิด icon

Priority: สูง

### `FullAmountInput`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- default state render ถูกต้อง
- input รับเฉพาะตัวเลขและจุดทศนิยม
- clear button ปรากฏเมื่อมี text และล้างค่าได้จริง
- `onChanged` ถูกเรียกถูกต้อง
- focus state เปลี่ยน border color
- error state เมื่อค่าน้อยกว่า 100
- success state เมื่อค่ามากกว่าหรือเท่ากับ 100
- disabled state

ความเสี่ยง:
- validation logic หลุด
- focus/error state แสดงผิด

Priority: สูง

### `MobileCodeInput`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- render country code, flag, placeholder, counter
- input รับได้เฉพาะตัวเลข
- `maxLength` บังคับจริง
- clear button ล้างค่าได้
- `onCountryCodeTap` ถูกเรียก
- error state แสดงข้อความและ border สีผิด
- focus state

ความเสี่ยง:
- counter ไม่ตรง
- input format หลุด
- flow เลือก country code ใช้งานไม่ได้

Priority: สูง

### `SearchInput`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- placeholder render
- focus border/icon state
- clear button behavior
- `onChanged` callback
- controller sync

ความเสี่ยง:
- search UX เสียเมื่อ clear/focus ไม่ทำงาน

Priority: สูง

### `NavigatorBar`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- render 5 items ครบ
- scan button ตรงกลางแสดงถูก
- localized label ของแต่ละ locale
- theme light/dark
- bottom safe area / padding
- `opacity` มีผลจริง

ความเสี่ยง:
- navigation shell เสียทั้งแถบ
- localization หลุด

Priority: สูง

### `Avatar`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- network image vs asset image precedence
- fallback icon เมื่อไม่มี image
- status badge: `none`, `danger`, `warning`
- loading skeleton state
- radius scaling

ความเสี่ยง:
- loading skeleton ครอบ layout ผิด
- badge อาจซ้อน/หาย

Priority: กลาง

### `AnnouncementStack`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- render 1, 2, 3 messages
- close action rotate message stack ถูกต้อง
- `onClose` ถูกเรียก
- close button หายเมื่อมี message เดียว
- `didUpdateWidget` เปลี่ยน messages แล้วอัปเดตจริง
- loading state
- locale font ไทย/เมียนมา/อื่นๆ

ความเสี่ยง:
- animation/state transition ผิด
- stack rotation เสีย

Priority: สูง

### `AnnouncementWarning`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- warning state colors
- danger state colors ผ่าน `state`
- title optional
- `descriptionSpans` render เป็น RichText
- long text wrap/ellipsis behavior

ความเสี่ยง:
- alert style ผิด token
- rich text แตก

Priority: กลาง

### `AnnouncementDanger`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- danger colors override ถูก
- title optional
- `descriptionSpans` ใช้งานได้เหมือน warning

Priority: กลาง

### `CardReviewTransaction`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- total section
- fee label/value
- detail rows ครบทุก label/value
- divider spacing
- long value ไม่ล้น
- light/dark token match

Priority: กลาง

### `DrawerBalanceDetail`

สถานะ: มี test หลักแล้ว

ควรเพิ่ม:
- loading state
- `showButton = false`
- bottom safe area
- warning text prefix/suffix parsing
- custom `onViewHistory`
- `show()` helper path
- max height clamp

Priority: สูง

### `DrawerDepositChannel`

สถานะ: มี test บางส่วนแล้ว

ควรเพิ่ม:
- close callback
- `show()` helper path
- bottom safe area
- locale-aware title เมื่อมี `AppLocalizations`
- bank order ตรง spec

Priority: สูง

### `DrawerCountryCode`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- list render ตาม input countries
- search filter by name/code
- empty state
- tap country -> callback + pop
- close button behavior
- `show()` helper

ความเสี่ยง:
- search/filter หลุด
- modal flow ใช้งานจริงไม่ได้

Priority: สูง

### `DrawerReviewTransaction`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- warning section render
- card section render
- object label/value render
- confirm button callback
- close button behavior
- `show()` helper

ความเสี่ยง:
- final confirmation flow หลุด

Priority: สูง

### `ReceiptComponent`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- golden test อย่างน้อย light rendering baseline
- data section ครบ
- optional assets fallback
- `transactionDetailRowCount` clamp / row visibility
- long text wrapping
- background asset missing fallback

ความเสี่ยง:
- visual regression สูงมาก

Priority: สูงมาก

### `ReceiptImageComponent`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- golden test baseline
- header logo fallback
- optional background image vs svg
- transaction details render
- long content layout

ความเสี่ยง:
- visual regression สูงมาก

Priority: สูงมาก

### `ImageCarousel`

สถานะ: มี test แล้ว

ควรเพิ่ม:
- empty pages guard
- single page behavior
- autoPlay timer stop on dispose
- page indicator state transition
- `height` / `imageHeight`

Priority: กลาง

### `PreLoading`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- render blur overlay
- Lottie asset path
- positioning center

Priority: ต่ำ-กลาง

### `LottieSkeleton`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- `isLoading = false` คืน child ตรงๆ
- `isLoading = true` ซ่อน child และแสดง skeleton
- borderRadius propagation
- custom asset path

Priority: กลาง

### `HorizontalTabs`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- selected tab render
- tap แล้วเรียก `onTabChanged`
- pressed scale state
- showDot indicator
- 2-tab / 3-tab layout

Priority: สูง

### `ShortcutMenuItem`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- async SVG load แล้ว render ได้
- custom icon override
- loading skeleton state
- top/bottom arrow color replacement
- label render

ความเสี่ยง:
- asset load async ทำให้ UI ว่าง
- color replacement หลุด

Priority: กลาง

### `SnackBarWidget`

สถานะ: มี test แล้ว

ควรเพิ่ม:
- text/icon/background colors ครบทุก type
- `show()` integration path
- duration / floating behavior

Priority: กลาง

### `VisaCard`

สถานะ: ยังไม่มี test

ควรเพิ่ม:
- golden test baseline
- logo render
- expiry date / card label / masked number render
- gradient and rounded card consistency

Priority: กลาง

## แผนลงมือทำที่แนะนำ

### Phase 1: ปิดช่องโหว่ฟังก์ชันหลัก

- `FullAmountInput`
- `MobileCodeInput`
- `SearchInput`
- `DrawerCountryCode`
- `DrawerReviewTransaction`
- `AnnouncementStack`
- `HorizontalTabs`

### Phase 2: เพิ่ม coverage ให้ core display widgets

- `Buttons`
- `ItemList`
- `NavigatorBar`
- `Avatar`
- `AnnouncementWarning`
- `AnnouncementDanger`
- `CardReviewTransaction`
- `DrawerBalanceDetail`
- `DrawerDepositChannel`
- `SnackBarWidget`

### Phase 3: เก็บ visual regression

- `ReceiptComponent`
- `ReceiptImageComponent`
- `VisaCard`
- `PreLoading`
- `LottieSkeleton`
- `ImageCarousel`
- `ShortcutMenuItem`

## รูปแบบ test ที่ควรใช้ซ้ำ

- ใช้ `MaterialApp` wrapper เดียวกันทุก test ที่มี theme/token
- ใช้ helper สร้าง `Locale` และ `ThemeMode`
- ใช้ `find.byType` + `tester.widget<>` กับ style assertions ที่สำคัญ
- ใช้ `pumpAndSettle` เฉพาะเคสที่มี animation หรือ modal
- ใช้ `golden` เฉพาะ widget ที่ layout คงที่และซับซ้อน

## เกณฑ์ว่า production-ready

- มี test ครอบคลุม behavior สำคัญของ widget ทุกตัว
- มี test สำหรับ modal/show helper ของทุก drawer/snackbar
- มี golden baseline สำหรับ component ที่ visual-sensitive
- มี coverage light/dark และ locale ที่เกี่ยวข้อง
- ไม่มี widget สำคัญใดเหลือเป็น preview-only โดยไม่มี test อย่างน้อยหนึ่งแบบ

