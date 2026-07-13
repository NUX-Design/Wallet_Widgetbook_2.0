import 'dart:io';

import 'v3_color_token.dart';
import 'v3_number_token.dart';
import 'v3_number_token_parser.dart';
import 'v3_number_token_resolver.dart';
import 'v3_shadow_token.dart';
import 'v3_shadow_token_parser.dart';
import 'v3_token_parser.dart';
import 'v3_token_resolver.dart';
import 'v3_typography_token.dart';
import 'v3_typography_token_parser.dart';

final class V3GenerationResult {
  const V3GenerationResult({
    required this.primitiveCount,
    required this.alphaColorCount,
    required this.radiusCount,
    required this.spacingCount,
    required this.semanticRadiusCount,
    required this.semanticSpacingCount,
    required this.shadowCount,
    required this.typographyCount,
    required this.lightCount,
    required this.darkCount,
    required this.changedFiles,
  });

  final int primitiveCount;
  final int alphaColorCount;
  final int radiusCount;
  final int spacingCount;
  final int semanticRadiusCount;
  final int semanticSpacingCount;
  final int shadowCount;
  final int typographyCount;
  final int lightCount;
  final int darkCount;
  final int changedFiles;
}

final class V3ThemeGenerator {
  const V3ThemeGenerator({required this.repoRoot});

  final Directory repoRoot;

  V3GenerationResult generate() {
    final themeRoot = Directory('${repoRoot.path}/lib/config/themes/v3');
    final parser = const V3TokenParser();
    final numberParser = const V3NumberTokenParser();
    final numberResolver = const V3NumberTokenResolver();
    final resolver = const V3TokenResolver();
    final shadowParser = const V3ShadowTokenParser();
    final typographyParser = const V3TypographyTokenParser();
    final primitives = parser.parseFile(
      File('${themeRoot.path}/tokens/primitive/primitive.tokens.json'),
    );
    final alphaColors = parser.parseFile(
      File('${themeRoot.path}/tokens/primitive/color.alpha.json'),
    );
    final shadows = shadowParser.parseFile(
      File('${themeRoot.path}/tokens/primitive/shadow.effect.json'),
      alphaColors: alphaColors,
    );
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
    final typography = typographyParser.parseFile(
      File('${themeRoot.path}/tokens/semantic/typography.json'),
    );
    final resolvedRadii = numberResolver.resolve(
      primitives: radii,
      semantics: semanticRadii,
    );
    final resolvedSpacing = numberResolver.resolve(
      primitives: spacing,
      semantics: semanticSpacing,
    );
    final allPrimitiveColors = [...primitives, ...alphaColors];
    _validateUniqueColorProperties(allPrimitiveColors);
    final light = parser.parseFile(
      File('${themeRoot.path}/tokens/semantic/light.tokens.json'),
    );
    final dark = parser.parseFile(
      File('${themeRoot.path}/tokens/semantic/dark.tokens.json'),
    );
    resolver.validateModeParity(light, dark);
    final resolvedLight = resolver.resolve(
      primitives: primitives,
      semantics: light,
    );
    final resolvedDark = resolver.resolve(
      primitives: primitives,
      semantics: dark,
    );

    final generatedDir = Directory('${themeRoot.path}/generated')
      ..createSync(recursive: true);
    var changed = 0;
    changed += _writeIfChanged(
      File('${generatedDir.path}/v3_primitive_colors.g.dart'),
      buildPrimitiveSource(allPrimitiveColors),
    );
    changed += _writeIfChanged(
      File('${generatedDir.path}/v3_primitive_dimensions.g.dart'),
      buildDimensionSource(radii: radii, spacing: spacing),
    );
    changed += _writeIfChanged(
      File('${generatedDir.path}/v3_primitive_shadows.g.dart'),
      buildShadowSource(shadows),
    );
    changed += _writeIfChanged(
      File('${generatedDir.path}/v3_semantic_dimensions.g.dart'),
      buildSemanticDimensionSource(
        radii: resolvedRadii,
        spacing: resolvedSpacing,
      ),
    );
    changed += _writeIfChanged(
      File('${generatedDir.path}/v3_semantic_colors.g.dart'),
      buildSemanticSource(resolvedLight, resolvedDark),
    );
    changed += _writeIfChanged(
      File('${generatedDir.path}/v3_typography.g.dart'),
      buildTypographySource(typography),
    );
    return V3GenerationResult(
      primitiveCount: primitives.length,
      alphaColorCount: alphaColors.length,
      radiusCount: radii.length,
      spacingCount: spacing.length,
      semanticRadiusCount: semanticRadii.length,
      semanticSpacingCount: semanticSpacing.length,
      shadowCount: shadows.length,
      typographyCount: typography.length,
      lightCount: light.length,
      darkCount: dark.length,
      changedFiles: changed,
    );
  }

  String buildShadowSource(List<V3ShadowToken> shadows) {
    final buffer =
        StringBuffer()
          ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND.')
          ..writeln('// Generated by v3_theme_generator.dart from tokens/**.')
          ..writeln()
          ..writeln("import 'package:flutter/material.dart';")
          ..writeln()
          ..writeln("import 'v3_primitive_colors.g.dart';")
          ..writeln()
          ..writeln('abstract final class V3PrimitiveShadows {');
    for (final shadow in shadows) {
      buffer.writeln(
        '  static const List<BoxShadow> ${shadow.dartProperty} = <BoxShadow>[',
      );
      for (final layer in shadow.layers) {
        buffer
          ..writeln('    BoxShadow(')
          ..writeln(
            '      color: V3PrimitiveColors.${layer.color.dartProperty},',
          )
          ..writeln(
            '      offset: Offset(${_numberLiteral(layer.x)}, ${_numberLiteral(layer.y)}),',
          )
          ..writeln('      blurRadius: ${_numberLiteral(layer.blur)},')
          ..writeln('      spreadRadius: ${_numberLiteral(layer.spread)},')
          ..writeln('    ),');
      }
      buffer.writeln('  ];');
    }
    buffer.writeln('}');
    return buffer.toString();
  }

  String buildTypographySource(List<V3TypographyToken> typography) {
    final buffer =
        StringBuffer()
          ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND.')
          ..writeln('// Generated by v3_theme_generator.dart from tokens/**.')
          ..writeln()
          ..writeln("import 'package:flutter/material.dart';")
          ..writeln()
          ..writeln('abstract final class V3Typography {');
    for (final token in typography) {
      final height = token.lineHeight / token.fontSize;
      buffer
        ..writeln('  static const ${token.dartProperty} = TextStyle(')
        ..writeln("    fontFamily: '${token.fontFamily}',")
        ..writeln('    fontSize: ${_numberLiteral(token.fontSize)},')
        ..writeln('    fontWeight: FontWeight.w${token.fontWeight},')
        ..writeln('    height: ${_decimalLiteral(height)},')
        ..writeln('    letterSpacing: ${_numberLiteral(token.letterSpacing)},')
        ..writeln('  );');
    }
    buffer.writeln('}');
    return buffer.toString();
  }

  String _decimalLiteral(double value) {
    final fixed = value.toStringAsFixed(8);
    return fixed
        .replaceFirst(RegExp(r'0+$'), '')
        .replaceFirst(RegExp(r'\.$'), '.0');
  }

  String buildSemanticDimensionSource({
    required List<V3ResolvedNumberToken> radii,
    required List<V3ResolvedNumberToken> spacing,
  }) {
    final buffer =
        StringBuffer()
          ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND.')
          ..writeln('// Generated by v3_theme_generator.dart from tokens/**.')
          ..writeln()
          ..writeln("import 'v3_primitive_dimensions.g.dart';")
          ..writeln()
          ..writeln('abstract final class V3Radii {');
    _writeSemanticNumberConstants(
      buffer,
      radii,
      primitiveClass: 'V3PrimitiveRadii',
    );
    buffer
      ..writeln('}')
      ..writeln()
      ..writeln('abstract final class V3Spacing {');
    _writeSemanticNumberConstants(
      buffer,
      spacing,
      primitiveClass: 'V3PrimitiveSpacing',
      primitivePropertyPrefix: 'space',
    );
    buffer.writeln('}');
    return buffer.toString();
  }

  void _writeSemanticNumberConstants(
    StringBuffer buffer,
    List<V3ResolvedNumberToken> tokens, {
    required String primitiveClass,
    String? primitivePropertyPrefix,
  }) {
    for (final item in tokens) {
      final primitiveProperty = _numberProperty(
        item.primitive,
        propertyPrefix: primitivePropertyPrefix,
      );
      buffer.writeln(
        '  static const double ${item.token.dartProperty} = '
        '$primitiveClass.$primitiveProperty;',
      );
    }
  }

  String buildDimensionSource({
    required List<V3NumberToken> radii,
    required List<V3NumberToken> spacing,
  }) {
    final buffer =
        StringBuffer()
          ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND.')
          ..writeln('// Generated by v3_theme_generator.dart from tokens/**.')
          ..writeln()
          ..writeln('abstract final class V3PrimitiveRadii {');
    _writeNumberConstants(buffer, radii);
    buffer
      ..writeln('}')
      ..writeln()
      ..writeln('abstract final class V3PrimitiveSpacing {');
    _writeNumberConstants(buffer, spacing, propertyPrefix: 'space');
    buffer.writeln('}');
    return buffer.toString();
  }

  void _writeNumberConstants(
    StringBuffer buffer,
    List<V3NumberToken> tokens, {
    String? propertyPrefix,
  }) {
    for (final token in tokens) {
      final property = _numberProperty(token, propertyPrefix: propertyPrefix);
      buffer.writeln(
        '  static const double $property = '
        '${_numberLiteral(token.value)};',
      );
    }
  }

  String _numberProperty(V3NumberToken token, {String? propertyPrefix}) {
    return propertyPrefix == null
        ? token.dartProperty
        : '$propertyPrefix${token.path[0].toUpperCase()}${token.path.substring(1)}';
  }

  String _numberLiteral(double value) {
    return value == value.truncateToDouble()
        ? '${value.toInt()}.0'
        : value.toString();
  }

  void _validateUniqueColorProperties(List<V3ColorToken> tokens) {
    final properties = <String, String>{};
    for (final token in tokens) {
      final previous = properties[token.dartProperty];
      if (previous != null) {
        throw V3TokenFormatException(
          '${token.sourcePath}: Dart property collision '
          '"${token.dartProperty}" for "$previous" and "${token.path}"',
        );
      }
      properties[token.dartProperty] = token.path;
    }
  }

  String buildPrimitiveSource(List<V3ColorToken> primitives) {
    final buffer =
        StringBuffer()
          ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND.')
          ..writeln('// Generated by v3_theme_generator.dart from tokens/**.')
          ..writeln()
          ..writeln("import 'package:flutter/material.dart';")
          ..writeln()
          ..writeln('abstract final class V3PrimitiveColors {');
    for (final token in primitives) {
      if (token.isAlias) continue;
      buffer.writeln(
        '  static const ${token.dartProperty} = Color(${_colorLiteral(token)});',
      );
    }
    buffer.writeln('}');
    return buffer.toString();
  }

  String buildSemanticSource(
    List<V3ResolvedColorToken> light,
    List<V3ResolvedColorToken> dark,
  ) {
    final buffer =
        StringBuffer()
          ..writeln('// GENERATED CODE - DO NOT MODIFY BY HAND.')
          ..writeln('// Generated by v3_theme_generator.dart from tokens/**.')
          ..writeln()
          ..writeln("import 'package:flutter/material.dart';")
          ..writeln()
          ..writeln("import 'v3_primitive_colors.g.dart';")
          ..writeln()
          ..writeln('final class V3ColorPalette {')
          ..writeln('  const V3ColorPalette({');
    for (final item in light) {
      buffer.writeln('    required this.${item.token.dartProperty},');
    }
    buffer
      ..writeln('  });')
      ..writeln();
    for (final item in light) {
      buffer.writeln('  final Color ${item.token.dartProperty};');
    }
    buffer
      ..writeln()
      ..writeln('  static const light = V3ColorPalette(');
    _writePaletteValues(buffer, light);
    buffer
      ..writeln('  );')
      ..writeln()
      ..writeln('  static const dark = V3ColorPalette(');
    _writePaletteValues(buffer, dark);
    buffer
      ..writeln('  );')
      ..writeln('}');
    return buffer.toString();
  }

  void _writePaletteValues(
    StringBuffer buffer,
    List<V3ResolvedColorToken> tokens,
  ) {
    for (final item in tokens) {
      buffer.writeln(
        '    ${item.token.dartProperty}: '
        'V3PrimitiveColors.${item.primitive.dartProperty},',
      );
    }
  }

  String _colorLiteral(V3ColorToken token) {
    final hex = token.hex!.substring(1);
    final alpha = (token.alpha * 255).round().clamp(0, 255);
    return '0x${alpha.toRadixString(16).padLeft(2, '0').toUpperCase()}$hex';
  }

  int _writeIfChanged(File file, String content) {
    if (file.existsSync() && file.readAsStringSync() == content) return 0;
    file.writeAsStringSync(content);
    return 1;
  }
}

void main() {
  final scriptDirectory = File.fromUri(Platform.script).parent;
  final repoRoot = scriptDirectory.parent.parent.parent.parent;
  final result = V3ThemeGenerator(repoRoot: repoRoot).generate();
  stdout.writeln(
    'Theme V3 generated: primitives=${result.primitiveCount}, '
    'alphaColors=${result.alphaColorCount}, '
    'radii=${result.radiusCount}, spacing=${result.spacingCount}, '
    'semanticRadii=${result.semanticRadiusCount}, '
    'semanticSpacing=${result.semanticSpacingCount}, '
    'shadows=${result.shadowCount}, typography=${result.typographyCount}, '
    'light=${result.lightCount}, dark=${result.darkCount}, '
    'changedFiles=${result.changedFiles}',
  );
}
