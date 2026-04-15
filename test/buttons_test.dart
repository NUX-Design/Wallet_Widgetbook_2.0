import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mcp_test_app/config/themes/theme_color.dart';
import 'package:mcp_test_app/widgets/button/buttons.dart';

Widget _buildSubject({
  required ButtonType type,
  required bool enabled,
  VoidCallback? onPressed,
}) {
  return MaterialApp(
    theme: ThemeData.dark(),
    home: Scaffold(
      body: Center(
        child: Buttons(
          text: 'Secondary Disabled',
          type: type,
          enabled: enabled,
          onPressed: onPressed,
        ),
      ),
    ),
  );
}

void main() {
  testWidgets('Secondary disabled button matches the Figma disabled style', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      _buildSubject(type: ButtonType.secondary, enabled: false),
    );

    final container = tester.widget<Container>(
      find.descendant(
        of: find.byType(Buttons),
        matching: find.byType(Container),
      ),
    );
    final decoration = container.decoration! as BoxDecoration;

    expect(decoration.color, ThemeColors.get('dark', 'alt/base/600'));
    expect(decoration.border, isNull);
    expect(decoration.boxShadow, isNotEmpty);

    final text = tester.widget<Text>(find.text('Secondary Disabled'));
    expect(text.style?.color, ThemeColors.get('dark', 'text/base/400'));
  });

  testWidgets('Disabled button does not invoke onPressed', (
    WidgetTester tester,
  ) async {
    var pressed = false;

    await tester.pumpWidget(
      _buildSubject(
        type: ButtonType.secondary,
        enabled: false,
        onPressed: () => pressed = true,
      ),
    );

    await tester.tap(find.byType(Buttons));
    await tester.pumpAndSettle();

    expect(pressed, isFalse);
  });
}
