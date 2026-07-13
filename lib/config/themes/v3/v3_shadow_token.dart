import 'v3_color_token.dart';

final class V3ShadowLayerToken {
  const V3ShadowLayerToken({
    required this.sourcePath,
    required this.color,
    required this.x,
    required this.y,
    required this.blur,
    required this.spread,
  });

  final String sourcePath;
  final V3ColorToken color;
  final double x;
  final double y;
  final double blur;
  final double spread;
}

final class V3ShadowToken {
  const V3ShadowToken({
    required this.path,
    required this.dartProperty,
    required this.layers,
  });

  final String path;
  final String dartProperty;
  final List<V3ShadowLayerToken> layers;
}
