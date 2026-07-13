import 'v3_number_token.dart';
import 'v3_token_parser.dart';

/// Resolves semantic number tokens to primitive spacing or radius tokens.
final class V3NumberTokenResolver {
  const V3NumberTokenResolver();

  List<V3ResolvedNumberToken> resolve({
    required List<V3NumberToken> primitives,
    required List<V3NumberToken> semantics,
  }) {
    final primitiveByPath = {for (final token in primitives) token.path: token};
    final resolved = <V3ResolvedNumberToken>[];
    for (final semantic in semantics) {
      final alias = semantic.aliasPath;
      if (alias == null) {
        throw V3TokenFormatException(
          '${semantic.sourcePath}: semantic number token must alias a primitive token',
        );
      }
      final primitive = primitiveByPath[alias];
      if (primitive == null) {
        throw V3TokenFormatException(
          '${semantic.sourcePath}: missing primitive number target "$alias"',
        );
      }
      if (semantic.value != primitive.value) {
        throw V3TokenFormatException(
          '${semantic.sourcePath}: resolved value ${semantic.value} does not '
          'match primitive "$alias" value ${primitive.value}',
        );
      }
      resolved.add(
        V3ResolvedNumberToken(token: semantic, primitive: primitive),
      );
    }
    return List.unmodifiable(
      resolved..sort((a, b) => a.token.path.compareTo(b.token.path)),
    );
  }
}
