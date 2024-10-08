import "package:flutter/material.dart";

class MainTheme {
  final TextTheme textTheme;

  const MainTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
        background: Colors.white,
        onBackground: Color(0xff171c1f),
        brightness: Brightness.light,
        primary: Color(0xff136682),
        surfaceTint: Color(0xff136682),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xffbee9ff),
        onPrimaryContainer: Color(0xff001f2a),
        secondary: Color(0xff4d616c),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xffd0e6f2),
        onSecondaryContainer: Color(0xff081e27),
        tertiary: Color(0xff5d5b7d),
        onTertiary: Color(0xffffffff),
        tertiaryContainer: Color(0xffe3dfff),
        onTertiaryContainer: Color(0xff1a1836),
        error: Color(0xffba1a1a),
        onError: Color(0xffffffff),
        errorContainer: Color(0xffffdad6),
        onErrorContainer: Color(0xff410002),
        surface: Color(0xfff6fafe),
        onSurface: Color(0xff171c1f),
        onSurfaceVariant: Color(0xff40484c),
        outline: Color(0xff70787d),
        outlineVariant: Color(0xffc0c8cd),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff2c3134),
        inversePrimary: Color(0xff8bd0f0));
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
        background: Colors.white,
        onBackground: Color(0xff171c1f),
        brightness: Brightness.light,
        primary: Color(0xff00495f),
        surfaceTint: Color(0xff136682),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xff347c9a),
        onPrimaryContainer: Color(0xffffffff),
        secondary: Color(0xff314650),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xff637882),
        onSecondaryContainer: Color(0xffffffff),
        tertiary: Color(0xff423f60),
        onTertiary: Color(0xffffffff),
        tertiaryContainer: Color(0xff747195),
        onTertiaryContainer: Color(0xffffffff),
        error: Color(0xff8c0009),
        onError: Color(0xffffffff),
        errorContainer: Color(0xffda342e),
        onErrorContainer: Color(0xffffffff),
        surface: Color(0xfff6fafe),
        onSurface: Color(0xff171c1f),
        onSurfaceVariant: Color(0xff3c4448),
        outline: Color(0xff586065),
        outlineVariant: Color(0xff747c81),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff2c3134),
        inversePrimary: Color(0xff8bd0f0));
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
        background: Colors.white,
        onBackground: Color(0xff171c1f),
        brightness: Brightness.light,
        primary: Color(0xff002633),
        surfaceTint: Color(0xff136682),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xff00495f),
        onPrimaryContainer: Color(0xffffffff),
        secondary: Color(0xff10252e),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xff314650),
        onSecondaryContainer: Color(0xffffffff),
        tertiary: Color(0xff211e3d),
        onTertiary: Color(0xffffffff),
        tertiaryContainer: Color(0xff423f60),
        onTertiaryContainer: Color(0xffffffff),
        error: Color(0xff4e0002),
        onError: Color(0xffffffff),
        errorContainer: Color(0xff8c0009),
        onErrorContainer: Color(0xffffffff),
        surface: Color(0xfff6fafe),
        onSurface: Color(0xff000000),
        onSurfaceVariant: Color(0xff1d2529),
        outline: Color(0xff3c4448),
        outlineVariant: Color(0xff3c4448),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff2c3134),
        inversePrimary: Color(0xffd5f0ff));
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
        background: Colors.black54,
        onBackground: Colors.white,
        brightness: Brightness.dark,
        primary: Color(0xff8bd0f0),
        surfaceTint: Color(0xff8bd0f0),
        onPrimary: Color(0xff003546),
        primaryContainer: Color(0xff004d65),
        onPrimaryContainer: Color(0xffbee9ff),
        secondary: Color(0xffb4cad6),
        onSecondary: Color(0xff1f333d),
        secondaryContainer: Color(0xff354a54),
        onSecondaryContainer: Color(0xffd0e6f2),
        tertiary: Color(0xffc7c2ea),
        onTertiary: Color(0xff2f2d4c),
        tertiaryContainer: Color(0xff464364),
        onTertiaryContainer: Color(0xffe3dfff),
        error: Color(0xffffb4ab),
        onError: Color(0xff690005),
        errorContainer: Color(0xff93000a),
        onErrorContainer: Color(0xffffdad6),
        surface: Color(0xff0f1417),
        onSurface: Color(0xffdfe3e7),
        onSurfaceVariant: Color(0xffc0c8cd),
        outline: Color(0xff8a9297),
        outlineVariant: Color(0xff40484c),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xffdfe3e7),
        inversePrimary: Color(0xff136682));
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
        background: Colors.black54,
        onBackground: Colors.white,
        brightness: Brightness.dark,
        primary: Color(0xff90d4f4),
        surfaceTint: Color(0xff8bd0f0),
        onPrimary: Color(0xff001923),
        primaryContainer: Color(0xff5499b7),
        onPrimaryContainer: Color(0xff000000),
        secondary: Color(0xffb8ceda),
        onSecondary: Color(0xff031922),
        secondaryContainer: Color(0xff7f949f),
        onSecondaryContainer: Color(0xff000000),
        tertiary: Color(0xffcbc6ef),
        onTertiary: Color(0xff151231),
        tertiaryContainer: Color(0xff908db2),
        onTertiaryContainer: Color(0xff000000),
        error: Color(0xffffbab1),
        onError: Color(0xff370001),
        errorContainer: Color(0xffff5449),
        onErrorContainer: Color(0xff000000),
        surface: Color(0xff0f1417),
        onSurface: Color(0xfff7fbff),
        onSurfaceVariant: Color(0xffc4ccd1),
        outline: Color(0xff9ca4a9),
        outlineVariant: Color(0xff7c8489),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xffdfe3e7),
        inversePrimary: Color(0xff004e66));
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
        background: Colors.black54,
        onBackground: Colors.white,
        brightness: Brightness.dark,
        primary: Color(0xfff7fbff),
        surfaceTint: Color(0xff8bd0f0),
        onPrimary: Color(0xff000000),
        primaryContainer: Color(0xff90d4f4),
        onPrimaryContainer: Color(0xff000000),
        secondary: Color(0xfff7fbff),
        onSecondary: Color(0xff000000),
        secondaryContainer: Color(0xffb8ceda),
        onSecondaryContainer: Color(0xff000000),
        tertiary: Color(0xfffef9ff),
        onTertiary: Color(0xff000000),
        tertiaryContainer: Color(0xffcbc6ef),
        onTertiaryContainer: Color(0xff000000),
        error: Color(0xfffff9f9),
        onError: Color(0xff000000),
        errorContainer: Color(0xffffbab1),
        onErrorContainer: Color(0xff000000),
        surface: Color(0xff0f1417),
        onSurface: Color(0xffffffff),
        onSurfaceVariant: Color(0xfff7fbff),
        outline: Color(0xffc4ccd1),
        outlineVariant: Color(0xffc4ccd1),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xffdfe3e7),
        inversePrimary: Color(0xff002e3e));
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
