/// One semantic typography style resolved from the Figma export.
final class V3TypographyToken {
  const V3TypographyToken({
    required this.sourcePath,
    required this.path,
    required this.dartProperty,
    required this.fontFamily,
    required this.fontWeight,
    required this.fontSize,
    required this.lineHeight,
    required this.letterSpacing,
  });

  final String sourcePath;
  final String path;
  final String dartProperty;
  final String fontFamily;
  final int fontWeight;
  final double fontSize;
  final double lineHeight;
  final double letterSpacing;
}
