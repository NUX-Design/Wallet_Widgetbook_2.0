import 'dart:convert';
import 'dart:io';

import 'v3_color_token.dart';
import 'v3_shadow_token.dart';
import 'v3_token_parser.dart';

final class V3ShadowTokenParser {
  const V3ShadowTokenParser();

  List<V3ShadowToken> parseFile(
    File file, {
    required List<V3ColorToken> alphaColors,
  }) {
    try {
      return parseDocument(
        jsonDecode(file.readAsStringSync()),
        alphaColors: alphaColors,
        source: file.path,
      );
    } on FormatException catch (error) {
      throw V3TokenFormatException(
        '${file.path}: invalid JSON: ${error.message}',
      );
    }
  }

  List<V3ShadowToken> parseDocument(
    Object? document, {
    required List<V3ColorToken> alphaColors,
    String source = 'shadow.effect.json',
  }) {
    if (document is! Map<String, dynamic>) {
      throw V3TokenFormatException('$source: root must be a JSON object');
    }
    final alphaByPath = {for (final token in alphaColors) token.path: token};
    final grouped = <String, List<(int, V3ShadowLayerToken)>>{};
    final pattern = RegExp(r'^shadow-(sm|base|md|lg|xl|2xl)([12])?$');
    for (final entry in document.entries) {
      if (entry.key.startsWith(r'$')) continue;
      final match = pattern.firstMatch(entry.key);
      if (match == null) {
        throw V3TokenFormatException(
          '$source:${entry.key}: unsupported shadow layer name',
        );
      }
      final node = _object(entry.value, '$source:${entry.key}');
      final colorNode = _object(node['color'], '$source:${entry.key}/color');
      final parsedColor =
          const V3TokenParser().parseDocument({
            entry.key: {'color': colorNode},
          }, source: source).single;
      final alias = parsedColor.aliasPath;
      final primitive = alias == null ? null : alphaByPath[alias];
      if (primitive == null) {
        throw V3TokenFormatException(
          '$source:${entry.key}/color: missing alpha color target "$alias"',
        );
      }
      if (parsedColor.hex != primitive.hex ||
          (parsedColor.alpha - primitive.alpha).abs() > 0.000001) {
        throw V3TokenFormatException(
          '$source:${entry.key}/color: resolved color does not match "$alias"',
        );
      }
      final group = match.group(1)!;
      final layerIndex = int.tryParse(match.group(2) ?? '') ?? 1;
      grouped.putIfAbsent(group, () => []).add((
        layerIndex,
        V3ShadowLayerToken(
          sourcePath: '$source:${entry.key}',
          color: primitive,
          x: _number(node, 'x', source, entry.key),
          y: _number(node, 'y', source, entry.key),
          blur: _number(node, 'blur', source, entry.key),
          spread: _number(node, 'spread', source, entry.key),
        ),
      ));
    }

    const expectedLayers = {
      'sm': 1,
      'base': 2,
      'md': 2,
      'lg': 2,
      'xl': 2,
      '2xl': 1,
    };
    final output = <V3ShadowToken>[];
    for (final entry in expectedLayers.entries) {
      final layers = grouped[entry.key] ?? const [];
      if (layers.length != entry.value) {
        throw V3TokenFormatException(
          '$source: shadow-${entry.key} expected ${entry.value} layer(s), found ${layers.length}',
        );
      }
      final sorted = [...layers]..sort((a, b) => a.$1.compareTo(b.$1));
      output.add(
        V3ShadowToken(
          path: 'shadow-${entry.key}',
          dartProperty: entry.key == '2xl' ? 'xl2' : entry.key,
          layers: List.unmodifiable(sorted.map((item) => item.$2)),
        ),
      );
    }
    return List.unmodifiable(output);
  }

  Map<String, dynamic> _object(Object? value, String sourcePath) {
    if (value is! Map<String, dynamic>) {
      throw V3TokenFormatException('$sourcePath: expected an object');
    }
    return value;
  }

  double _number(
    Map<String, dynamic> node,
    String field,
    String source,
    String name,
  ) {
    final fieldNode = _object(node[field], '$source:$name/$field');
    if (fieldNode[r'$type'] != 'number') {
      throw V3TokenFormatException(
        '$source:$name/$field: expected \$type "number"',
      );
    }
    final value = fieldNode[r'$value'];
    if (value is! num || !value.isFinite) {
      throw V3TokenFormatException(
        '$source:$name/$field: expected a finite number',
      );
    }
    return value.toDouble();
  }
}
