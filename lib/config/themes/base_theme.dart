import 'package:flutter/material.dart';
import 'theme_color.dart';

class BaseTheme {
  static final ColorScheme lightColorScheme = ColorScheme(
    primary: ThemeColors.get('light', 'fill/base/300'),
    primaryContainer: ThemeColors.get('light', 'fill/contrast/600'),
    onPrimary: ThemeColors.get('light', 'text/base/600'),
    secondary: ThemeColors.get('light', 'fill/base/300'),
    secondaryContainer: ThemeColors.get('light', 'fill/base/300'),
    onSecondary: ThemeColors.get('light', 'text/base/600'),
    error: ThemeColors.get('light', 'danger/500'),
    onError: ThemeColors.get('light', 'text/base/danger'),
    surface: ThemeColors.get('light', 'fill/base/100'),
    surfaceContainerHighest: ThemeColors.get('light', 'fill/base/100'),
    onSurface: ThemeColors.get('light', 'text/base/600'),
    outline: ThemeColors.get('light', 'stroke/base/100'),
    brightness: Brightness.light,
  );

  static final ColorScheme darkColorScheme = ColorScheme(
    primary: ThemeColors.get('dark', 'fill/base/300'),
    primaryContainer: ThemeColors.get('dark', 'fill/contrast/600'),
    onPrimary: ThemeColors.get('dark', 'text/base/600'),
    secondary: ThemeColors.get('dark', 'fill/base/300'),
    secondaryContainer: ThemeColors.get('dark', 'fill/base/300'),
    onSecondary: ThemeColors.get('dark', 'text/base/600'),
    error: ThemeColors.get('dark', 'danger/500'),
    onError: ThemeColors.get('dark', 'text/base/danger'),
    surface: ThemeColors.get('dark', 'fill/base/100'),
    surfaceContainerHighest: ThemeColors.get('dark', 'fill/base/100'),
    onSurface: ThemeColors.get('dark', 'text/base/600'),
    outline: ThemeColors.get('dark', 'stroke/base/100'),
    brightness: Brightness.dark,
  );

  static final TextTheme lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.125,
      color: ThemeColors.get('light', 'text/base/600'),
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.111,
      color: ThemeColors.get('light', 'text/base/600'),
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.167,
      color: ThemeColors.get('light', 'text/base/600'),
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.25,
      color: ThemeColors.get('light', 'text/base/600'),
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.286,
      color: ThemeColors.get('light', 'text/base/600'),
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.333,
      color: ThemeColors.get('light', 'text/base/600'),
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      height: 1.273,
      color: ThemeColors.get('light', 'text/base/600'),
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      height: 1.5,
      color: ThemeColors.get('light', 'text/base/600'),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.429,
      color: ThemeColors.get('light', 'text/base/500'),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
      color: ThemeColors.get('light', 'text/base/600'),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.429,
      color: ThemeColors.get('light', 'text/base/500'),
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.333,
      color: ThemeColors.get('light', 'text/base/400'),
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.429,
      color: ThemeColors.get('light', 'text/base/500'),
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.333,
      color: ThemeColors.get('light', 'text/base/500'),
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.455,
      color: ThemeColors.get('light', 'text/base/400'),
    ),
  );

  static final TextTheme darkTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 57,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.125,
      color: ThemeColors.get('dark', 'text/base/600'),
    ),
    displayMedium: TextStyle(
      fontSize: 45,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.111,
      color: ThemeColors.get('dark', 'text/base/600'),
    ),
    displaySmall: TextStyle(
      fontSize: 36,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.167,
      color: ThemeColors.get('dark', 'text/base/600'),
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.25,
      color: ThemeColors.get('dark', 'text/base/600'),
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.286,
      color: ThemeColors.get('dark', 'text/base/600'),
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.333,
      color: ThemeColors.get('dark', 'text/base/600'),
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.w500,
      letterSpacing: 0,
      height: 1.273,
      color: ThemeColors.get('dark', 'text/base/600'),
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.25,
      height: 1.5,
      color: ThemeColors.get('dark', 'text/base/600'),
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.429,
      color: ThemeColors.get('dark', 'text/base/500'),
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
      height: 1.5,
      color: ThemeColors.get('dark', 'text/base/600'),
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.429,
      color: ThemeColors.get('dark', 'text/base/500'),
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.333,
      color: ThemeColors.get('dark', 'text/base/400'),
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.429,
      color: ThemeColors.get('dark', 'text/base/500'),
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.333,
      color: ThemeColors.get('dark', 'text/base/500'),
    ),
    labelSmall: TextStyle(
      fontSize: 11,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
      height: 1.455,
      color: ThemeColors.get('dark', 'text/base/400'),
    ),
  );

  static TextTheme textTheme(ThemeMode mode) {
    return mode == ThemeMode.light ? lightTextTheme : darkTextTheme;
  }

  static const EdgeInsetsGeometry padding = EdgeInsets.all(16);
  static const double borderRadius = 12;
  static const double elevation = 1;
  static const double spacing = 8;
}
