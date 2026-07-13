/// Parsed representation of one Theme V3 numeric primitive token.
final class V3NumberToken {
  const V3NumberToken({
    required this.sourcePath,
    required this.path,
    required this.dartProperty,
    required this.value,
    this.aliasPath,
  });

  final String sourcePath;
  final String path;
  final String dartProperty;
  final double value;
  final String? aliasPath;
}

/// A semantic numeric token together with its resolved primitive token.
final class V3ResolvedNumberToken {
  const V3ResolvedNumberToken({required this.token, required this.primitive});

  final V3NumberToken token;
  final V3NumberToken primitive;
}
