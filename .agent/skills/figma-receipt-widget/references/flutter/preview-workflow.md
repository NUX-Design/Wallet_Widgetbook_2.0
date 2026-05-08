# Flutter Preview Workflow

## Web Preview

Use the standalone preview file when you want to inspect the receipt in the browser:

- `flutter run -d web-server --web-hostname=0.0.0.0 --web-port=3001 -t lib/widgets/receipt/preview_receipt_component.dart`
- `flutter run -d web-server --web-hostname=0.0.0.0 --web-port=3001 -t lib/widgets/receipt/preview_receipt_image_component.dart`

Refresh the browser after hot restart when the web server asks for it.

## Simulator Preview

Use the iOS simulator preview when you want to inspect the widget in a device frame:

- `flutter run -d <simulator-id> -t lib/widgets/receipt/preview_receipt_component.dart`
- `flutter run -d <simulator-id> -t lib/widgets/receipt/preview_receipt_image_component.dart`

## Change Loop

1. Edit the widget or preview file.
2. Hot restart or rerun the preview.
3. Refresh the browser or simulator if the runtime asks for it.
4. Recheck the receipt layout against the Figma reference before shipping.
