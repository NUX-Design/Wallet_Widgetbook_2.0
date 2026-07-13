import 'dart:convert';
import 'dart:io';

import 'v3_token_parser.dart';
import 'v3_typography_token.dart';

final class V3TypographyTokenParser {
  const V3TypographyTokenParser();

  static const _weightValues = <String, int>{
    'Regular': 400,
    'Medium': 500,
    'Bold': 700,
    'ExtraBold': 800,
  };

  List<V3TypographyToken> parseFile(File file) {
    try {
      return parseDocument(
        jsonDecode(file.readAsStringSync()),
        source: file.path,
      );
    } on FormatException catch (error) {
      throw V3TokenFormatException(
        '${file.path}: invalid JSON: ${error.message}',
      );
    }
  }

  List<V3TypographyToken> parseDocument(
    Object? document, {
    String source = 'typography.json',
  }) {
    if (document is! Map<String, dynamic>) {
      throw V3TokenFormatException('$source: root must be a JSON object');
    }
    final definitions = document['font definitions'];
    if (definitions is! Map<String, dynamic>) {
      throw V3TokenFormatException('$source: missing "font definitions"');
    }
    final families = <String, String>{};
    for (final entry in definitions.entries) {
      if (entry.key.startsWith(r'$')) continue;
      final node = _object(
        entry.value,
        '$source:font definitions/${entry.key}',
      );
      final value = _value(
        node,
        'string',
        '$source:font definitions/${entry.key}',
      );
      if (value is! String || value.trim().isEmpty) {
        throw V3TokenFormatException(
          '$source:font definitions/${entry.key}: font family must be a non-empty string',
        );
      }
      families[V3TokenParser.normalizePath(
        'font definitions/${entry.key}',
      )] = _canonicalFontFamily(value);
    }

    final output = <V3TypographyToken>[];
    final properties = <String, String>{};
    for (final category in document.entries) {
      if (category.key.startsWith(r'$') || category.key == 'font definitions') {
        continue;
      }
      final styles = _object(category.value, '$source:${category.key}');
      for (final style in styles.entries) {
        if (style.key.startsWith(r'$')) continue;
        final rawPath = '${category.key}/${style.key}';
        final sourcePath = '$source:$rawPath';
        final fields = _object(style.value, sourcePath);
        final familyAlias = _stringField(fields, 'font-family', sourcePath);
        if (!familyAlias.startsWith('{') || !familyAlias.endsWith('}')) {
          throw V3TokenFormatException(
            '$sourcePath/font-family: expected a font definition alias',
          );
        }
        final familyPath = V3TokenParser.normalizePath(
          familyAlias.substring(1, familyAlias.length - 1),
        );
        final fontFamily = families[familyPath];
        if (fontFamily == null) {
          throw V3TokenFormatException(
            '$sourcePath/font-family: missing font definition "$familyPath"',
          );
        }
        final weightName = _stringField(fields, 'weight', sourcePath);
        final fontWeight = _weightValues[weightName];
        if (fontWeight == null) {
          throw V3TokenFormatException(
            '$sourcePath/weight: unsupported font weight "$weightName"',
          );
        }
        final spacing = _numberField(fields, 'spacing', sourcePath);
        if (spacing != 0) {
          throw V3TokenFormatException(
            '$sourcePath/spacing: non-zero paragraph spacing is not supported by TextStyle',
          );
        }
        final path = V3TokenParser.normalizePath(rawPath);
        final property = V3TokenParser.dartPropertyFor(path);
        final previous = properties[property];
        if (previous != null) {
          throw V3TokenFormatException(
            '$sourcePath: Dart property collision "$property" for "$previous" and "$path"',
          );
        }
        properties[property] = path;
        output.add(
          V3TypographyToken(
            sourcePath: sourcePath,
            path: path,
            dartProperty: property,
            fontFamily: fontFamily,
            fontWeight: fontWeight,
            fontSize: _numberField(fields, 'font-size', sourcePath),
            lineHeight: _numberField(fields, 'line-height', sourcePath),
            letterSpacing: _numberField(fields, 'letter-spacing', sourcePath),
          ),
        );
      }
    }
    return List.unmodifiable(output..sort((a, b) => a.path.compareTo(b.path)));
  }

  Map<String, dynamic> _object(Object? value, String sourcePath) {
    if (value is! Map<String, dynamic>) {
      throw V3TokenFormatException('$sourcePath: expected an object');
    }
    return value;
  }

  Object? _value(Map<String, dynamic> node, String type, String sourcePath) {
    if (node[r'$type'] != type) {
      throw V3TokenFormatException('$sourcePath: expected \$type "$type"');
    }
    return node[r'$value'];
  }

  String _stringField(
    Map<String, dynamic> fields,
    String name,
    String sourcePath,
  ) {
    final node = _object(fields[name], '$sourcePath/$name');
    final value = _value(node, 'string', '$sourcePath/$name');
    if (value is! String) {
      throw V3TokenFormatException('$sourcePath/$name: expected a string');
    }
    return value;
  }

  double _numberField(
    Map<String, dynamic> fields,
    String name,
    String sourcePath,
  ) {
    final node = _object(fields[name], '$sourcePath/$name');
    final value = _value(node, 'number', '$sourcePath/$name');
    if (value is! num || !value.isFinite) {
      throw V3TokenFormatException(
        '$sourcePath/$name: expected a finite number',
      );
    }
    return value.toDouble();
  }

  String _canonicalFontFamily(String value) {
    return value.trim().toLowerCase() == 'noto sans'
        ? 'Noto Sans'
        : value.trim();
  }
}
