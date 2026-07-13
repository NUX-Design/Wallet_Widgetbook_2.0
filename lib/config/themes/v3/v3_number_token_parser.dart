import 'dart:convert';
import 'dart:io';

import 'v3_number_token.dart';
import 'v3_token_parser.dart';

/// Parses primitive `$type: "number"` tokens used by spacing and radii.
final class V3NumberTokenParser {
  const V3NumberTokenParser();

  List<V3NumberToken> parseFile(File file) {
    try {
      final decoded = jsonDecode(file.readAsStringSync());
      return parseDocument(decoded, source: file.path);
    } on FormatException catch (error) {
      throw V3TokenFormatException(
        '${file.path}: invalid JSON: ${error.message}',
      );
    }
  }

  List<V3NumberToken> parseDocument(
    Object? document, {
    String source = 'tokens',
  }) {
    if (document is! Map<String, dynamic>) {
      throw V3TokenFormatException('$source: root must be a JSON object');
    }
    final tokens = <V3NumberToken>[];
    _visit(document, const [], null, source, tokens);
    final paths = <String, String>{};
    final properties = <String, String>{};
    for (final token in tokens) {
      final previous = paths[token.path];
      if (previous != null) {
        throw V3TokenFormatException(
          '${token.sourcePath}: duplicate normalized path "${token.path}"; '
          'also defined by $previous',
        );
      }
      paths[token.path] = token.sourcePath;
      final propertyOwner = properties[token.dartProperty];
      if (propertyOwner != null && propertyOwner != token.path) {
        throw V3TokenFormatException(
          '${token.sourcePath}: Dart property collision '
          '"${token.dartProperty}" for "$propertyOwner" and "${token.path}"',
        );
      }
      properties[token.dartProperty] = token.path;
    }
    return List.unmodifiable(tokens..sort((a, b) => a.path.compareTo(b.path)));
  }

  void _visit(
    Map<String, dynamic> node,
    List<String> segments,
    String? inheritedType,
    String source,
    List<V3NumberToken> output,
  ) {
    final type = node[r'$type'] as String? ?? inheritedType;
    if (node.containsKey(r'$value')) {
      final rawPath = segments.join('/');
      final sourcePath = '$source:$rawPath';
      if (rawPath.isEmpty) {
        throw V3TokenFormatException('$source: token path cannot be empty');
      }
      if (type != 'number') {
        throw V3TokenFormatException('$sourcePath: expected \$type "number"');
      }
      final value = node[r'$value'];
      if (value is! num || !value.isFinite) {
        throw V3TokenFormatException(
          '$sourcePath: number value must be finite',
        );
      }
      final path = V3TokenParser.normalizePath(rawPath);
      final extensions = node[r'$extensions'];
      final aliasData =
          extensions is Map<String, dynamic>
              ? extensions['com.figma.aliasData']
              : null;
      final figmaTarget =
          aliasData is Map<String, dynamic>
              ? aliasData['targetVariableName']
              : null;
      output.add(
        V3NumberToken(
          sourcePath: sourcePath,
          path: path,
          dartProperty: _dartPropertyFor(path),
          value: value.toDouble(),
          aliasPath:
              figmaTarget is String && figmaTarget.isNotEmpty
                  ? V3TokenParser.normalizePath(figmaTarget)
                  : null,
        ),
      );
      return;
    }

    for (final entry in node.entries) {
      if (entry.key.startsWith(r'$')) continue;
      if (entry.value is! Map<String, dynamic>) {
        throw V3TokenFormatException(
          '$source:${[...segments, entry.key].join('/')}: group must be an object',
        );
      }
      _visit(
        entry.value as Map<String, dynamic>,
        [...segments, entry.key],
        type,
        source,
        output,
      );
    }
  }

  static String _dartPropertyFor(String normalizedPath) {
    final words =
        normalizedPath
            .split(RegExp(r'[/_-]+'))
            .where((word) => word.isNotEmpty)
            .toList();
    final property =
        words.first +
        words
            .skip(1)
            .map((word) => word[0].toUpperCase() + word.substring(1))
            .join();
    return RegExp(r'^\d').hasMatch(property) ? 'value$property' : property;
  }
}
