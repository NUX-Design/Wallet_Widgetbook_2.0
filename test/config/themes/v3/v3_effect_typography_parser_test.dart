import 'package:flutter_test/flutter_test.dart';
import 'package:mcp_test_app/config/themes/v3/v3_shadow_token_parser.dart';
import 'package:mcp_test_app/config/themes/v3/v3_token_parser.dart';
import 'package:mcp_test_app/config/themes/v3/v3_typography_token_parser.dart';

void main() {
  group('V3TypographyTokenParser', () {
    const parser = V3TypographyTokenParser();

    test('resolves font definitions and maps typography metrics', () {
      final tokens = parser.parseDocument({
        'font definitions': {
          'font-family-noto-sans': {r'$type': 'string', r'$value': 'Noto sans'},
        },
        'Heading': {
          'medium': {
            'font-family': {
              r'$type': 'string',
              r'$value': '{font definitions.font-family-noto-sans}',
            },
            'weight': {r'$type': 'string', r'$value': 'Bold'},
            'font-size': {r'$type': 'number', r'$value': 32},
            'line-height': {r'$type': 'number', r'$value': 44},
            'letter-spacing': {r'$type': 'number', r'$value': 0},
            'spacing': {r'$type': 'number', r'$value': 0},
          },
        },
      });

      expect(tokens.single.dartProperty, 'headingMedium');
      expect(tokens.single.fontFamily, 'Noto Sans');
      expect(tokens.single.fontWeight, 700);
      expect(tokens.single.lineHeight, 44);
    });

    test('rejects unsupported font weights', () {
      expect(
        () => parser.parseDocument({
          'font definitions': {
            'family': {r'$type': 'string', r'$value': 'Noto Sans'},
          },
          'Label': {
            'small': {
              'font-family': {
                r'$type': 'string',
                r'$value': '{font definitions.family}',
              },
              'weight': {r'$type': 'string', r'$value': 'SemiBold'},
              'font-size': {r'$type': 'number', r'$value': 14},
              'line-height': {r'$type': 'number', r'$value': 20},
              'letter-spacing': {r'$type': 'number', r'$value': 0},
              'spacing': {r'$type': 'number', r'$value': 0},
            },
          },
        }),
        throwsA(
          isA<V3TokenFormatException>().having(
            (error) => error.message,
            'message',
            contains('unsupported font weight'),
          ),
        ),
      );
    });
  });

  group('V3ShadowTokenParser', () {
    test('rejects incomplete shadow layer groups', () {
      expect(
        () => const V3ShadowTokenParser().parseDocument(
          const <String, dynamic>{},
          alphaColors: const [],
        ),
        throwsA(
          isA<V3TokenFormatException>().having(
            (error) => error.message,
            'message',
            contains('expected 1 layer'),
          ),
        ),
      );
    });
  });
}
