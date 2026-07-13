import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mcp_test_app/config/themes/v3/v3_theme_generator.dart';
import 'package:mcp_test_app/config/themes/v3/v3_number_token_parser.dart';
import 'package:mcp_test_app/config/themes/v3/v3_number_token_resolver.dart';
import 'package:mcp_test_app/config/themes/v3/v3_primitives.dart';
import 'package:mcp_test_app/config/themes/v3/v3_dimensions.dart';
import 'package:mcp_test_app/config/themes/v3/v3_shadow_token_parser.dart';
import 'package:mcp_test_app/config/themes/v3/v3_token_parser.dart';
import 'package:mcp_test_app/config/themes/v3/v3_token_resolver.dart';
import 'package:mcp_test_app/config/themes/v3/v3_typography.dart';
import 'package:mcp_test_app/config/themes/v3/v3_typography_token_parser.dart';

void main() {
  final repoRoot = Directory.current;
  final themeRoot = Directory('${repoRoot.path}/lib/config/themes/v3');

  test('source token counts and Light/Dark parity match the contract', () {
    const parser = V3TokenParser();
    const resolver = V3TokenResolver();
    final primitives = parser.parseFile(
      File('${themeRoot.path}/tokens/primitive/primitive.tokens.json'),
    );
    final alphaColors = parser.parseFile(
      File('${themeRoot.path}/tokens/primitive/color.alpha.json'),
    );
    final shadows = const V3ShadowTokenParser().parseFile(
      File('${themeRoot.path}/tokens/primitive/shadow.effect.json'),
      alphaColors: alphaColors,
    );
    final typography = const V3TypographyTokenParser().parseFile(
      File('${themeRoot.path}/tokens/semantic/typography.json'),
    );
    const numberParser = V3NumberTokenParser();
    const numberResolver = V3NumberTokenResolver();
    final radii = numberParser.parseFile(
      File('${themeRoot.path}/tokens/primitive/radius.json'),
    );
    final spacing = numberParser.parseFile(
      File('${themeRoot.path}/tokens/primitive/space.json'),
    );
    final semanticRadii = numberParser.parseFile(
      File('${themeRoot.path}/tokens/semantic/radius.json'),
    );
    final semanticSpacing = numberParser.parseFile(
      File('${themeRoot.path}/tokens/semantic/space.json'),
    );
    final light = parser.parseFile(
      File('${themeRoot.path}/tokens/semantic/light.tokens.json'),
    );
    final dark = parser.parseFile(
      File('${themeRoot.path}/tokens/semantic/dark.tokens.json'),
    );

    expect(primitives, hasLength(145));
    expect(alphaColors, hasLength(52));
    expect(shadows, hasLength(6));
    expect(shadows.expand((shadow) => shadow.layers), hasLength(10));
    expect(typography, hasLength(18));
    expect(radii, hasLength(9));
    expect(spacing, hasLength(18));
    expect(semanticRadii, hasLength(9));
    expect(semanticSpacing, hasLength(18));
    expect(
      numberResolver.resolve(primitives: radii, semantics: semanticRadii),
      hasLength(9),
    );
    expect(
      numberResolver.resolve(primitives: spacing, semantics: semanticSpacing),
      hasLength(18),
    );
    expect(light, hasLength(55));
    expect(dark, hasLength(55));
    expect(() => resolver.validateModeParity(light, dark), returnsNormally);
    expect(
      resolver.resolve(primitives: primitives, semantics: light),
      hasLength(55),
    );
    expect(
      resolver.resolve(primitives: primitives, semantics: dark),
      hasLength(55),
    );
  });

  test('checked-in generated files match the generator snapshot', () {
    const parser = V3TokenParser();
    const resolver = V3TokenResolver();
    final generator = V3ThemeGenerator(repoRoot: repoRoot);
    final primitives = parser.parseFile(
      File('${themeRoot.path}/tokens/primitive/primitive.tokens.json'),
    );
    final alphaColors = parser.parseFile(
      File('${themeRoot.path}/tokens/primitive/color.alpha.json'),
    );
    final shadows = const V3ShadowTokenParser().parseFile(
      File('${themeRoot.path}/tokens/primitive/shadow.effect.json'),
      alphaColors: alphaColors,
    );
    final typography = const V3TypographyTokenParser().parseFile(
      File('${themeRoot.path}/tokens/semantic/typography.json'),
    );
    const numberParser = V3NumberTokenParser();
    const numberResolver = V3NumberTokenResolver();
    final radii = numberParser.parseFile(
      File('${themeRoot.path}/tokens/primitive/radius.json'),
    );
    final spacing = numberParser.parseFile(
      File('${themeRoot.path}/tokens/primitive/space.json'),
    );
    final semanticRadii = numberParser.parseFile(
      File('${themeRoot.path}/tokens/semantic/radius.json'),
    );
    final semanticSpacing = numberParser.parseFile(
      File('${themeRoot.path}/tokens/semantic/space.json'),
    );
    final light = parser.parseFile(
      File('${themeRoot.path}/tokens/semantic/light.tokens.json'),
    );
    final dark = parser.parseFile(
      File('${themeRoot.path}/tokens/semantic/dark.tokens.json'),
    );

    expect(
      File(
        '${themeRoot.path}/generated/v3_primitive_colors.g.dart',
      ).readAsStringSync(),
      generator.buildPrimitiveSource([...primitives, ...alphaColors]),
    );
    expect(
      File(
        '${themeRoot.path}/generated/v3_primitive_dimensions.g.dart',
      ).readAsStringSync(),
      generator.buildDimensionSource(radii: radii, spacing: spacing),
    );
    expect(
      File(
        '${themeRoot.path}/generated/v3_primitive_shadows.g.dart',
      ).readAsStringSync(),
      generator.buildShadowSource(shadows),
    );
    expect(
      File(
        '${themeRoot.path}/generated/v3_semantic_dimensions.g.dart',
      ).readAsStringSync(),
      generator.buildSemanticDimensionSource(
        radii: numberResolver.resolve(
          primitives: radii,
          semantics: semanticRadii,
        ),
        spacing: numberResolver.resolve(
          primitives: spacing,
          semantics: semanticSpacing,
        ),
      ),
    );
    expect(
      File(
        '${themeRoot.path}/generated/v3_semantic_colors.g.dart',
      ).readAsStringSync(),
      generator.buildSemanticSource(
        resolver.resolve(primitives: primitives, semantics: light),
        resolver.resolve(primitives: primitives, semantics: dark),
      ),
    );
    expect(
      File(
        '${themeRoot.path}/generated/v3_typography.g.dart',
      ).readAsStringSync(),
      generator.buildTypographySource(typography),
    );
  });

  test('second generation is deterministic and produces no writes', () {
    final first = V3ThemeGenerator(repoRoot: repoRoot).generate();
    final second = V3ThemeGenerator(repoRoot: repoRoot).generate();

    expect(first.changedFiles, 0);
    expect(second.changedFiles, 0);
    expect(first.primitiveCount, 145);
    expect(first.alphaColorCount, 52);
    expect(first.radiusCount, 9);
    expect(first.spacingCount, 18);
    expect(first.semanticRadiusCount, 9);
    expect(first.semanticSpacingCount, 18);
    expect(first.shadowCount, 6);
    expect(first.typographyCount, 18);
    expect(first.lightCount, 55);
    expect(first.darkCount, 55);
  });

  test('public primitive APIs expose generated alpha and dimension values', () {
    expect(V3PrimitiveColors.blackAlpha20.a, closeTo(0.2, 0.002));
    expect(V3PrimitiveRadii.radius12, 12);
    expect(V3PrimitiveRadii.radiusFull, 999);
    expect(V3PrimitiveSpacing.space16, 16);
  });

  test('public semantic dimension APIs map to primitive values', () {
    expect(V3Radii.roundedBase, V3PrimitiveRadii.radius6);
    expect(V3Radii.roundedFull, V3PrimitiveRadii.radiusFull);
    expect(V3Spacing.space16, V3PrimitiveSpacing.space16);
  });

  test('public typography and shadow APIs expose generated values', () {
    expect(V3Typography.headingMedium.fontSize, 32);
    expect(V3Typography.headingMedium.height, 1.375);
    expect(V3PrimitiveShadows.md, hasLength(2));
    expect(V3PrimitiveShadows.xl2.single.blurRadius, 50);
  });
}
