import "package:flutter/material.dart";

const Color green = Color(0xffb1df7f);
const Color grey = Color(0xff606787);
const Color yellow = Color(0xfff8ffbf);
const Color lightGreen = Color(0xffefff8d);
const Color red = Color(0xffe63f58);

class Green {
  final TextTheme textTheme;

  const Green(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4e5b92),
      surfaceTint: Color(0xff4e5b92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffdce1ff),
      onPrimaryContainer: Color(0xff364479),
      secondary: Color(0xff4a662c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcceda5),
      onSecondaryContainer: Color(0xff344e17),
      tertiary: Color(0xff8f4a4f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdada),
      onTertiaryContainer: Color(0xff723338),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffcfaed),
      onSurface: Color(0xff1b1c15),
      onSurfaceVariant: Color(0xff47483b),
      outline: Color(0xff78786a),
      outlineVariant: Color(0xffc8c7b7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303129),
      inversePrimary: Color(0xffb7c4ff),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff05164b),
      primaryFixedDim: Color(0xffb7c4ff),
      onPrimaryFixedVariant: Color(0xff364479),
      secondaryFixed: Color(0xffcceda5),
      onSecondaryFixed: Color(0xff0f2000),
      secondaryFixedDim: Color(0xffb0d18b),
      onSecondaryFixedVariant: Color(0xff344e17),
      tertiaryFixed: Color(0xffffdada),
      onTertiaryFixed: Color(0xff3b0810),
      tertiaryFixedDim: Color(0xffffb3b6),
      onTertiaryFixedVariant: Color(0xff723338),
      surfaceDim: Color(0xffdcdace),
      surfaceBright: Color(0xfffcfaed),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f4e7),
      surfaceContainer: Color(0xffc1e699),
      surfaceContainerHigh: Color(0xffdaf0c2),
      surfaceContainerHighest: Color(0xfff3faeb),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff243367),
      surfaceTint: Color(0xff4e5b92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5d6aa2),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff243d06),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff59763a),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5e2328),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffa1585d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcfaed),
      onSurface: Color(0xff11120b),
      onSurfaceVariant: Color(0xff36372b),
      outline: Color(0xff535346),
      outlineVariant: Color(0xff6d6e60),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303129),
      inversePrimary: Color(0xffb7c4ff),
      primaryFixed: Color(0xff5d6aa2),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff445288),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff59763a),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff415d24),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xffa1585d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff844045),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffc8c7bb),
      surfaceBright: Color(0xfffcfaed),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f4e7),
      surfaceContainer: Color(0xffc1e699),
      surfaceContainerHigh: Color(0xffdaf0c2),
      surfaceContainerHighest: Color(0xfff3faeb),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff19285c),
      surfaceTint: Color(0xff4e5b92),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff38467b),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff1a3200),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff365119),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff51191f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff75353a),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcfaed),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2c2d22),
      outlineVariant: Color(0xff494a3d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff303129),
      inversePrimary: Color(0xffb7c4ff),
      primaryFixed: Color(0xff38467b),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff212f63),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff365119),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff203903),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff75353a),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff591f25),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbab9ad),
      surfaceBright: Color(0xfffcfaed),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff3f1e4),
      surfaceContainer: Color(0xffc1e699),
      surfaceContainerHigh: Color(0xffdaf0c2),
      surfaceContainerHighest: Color(0xfff3faeb),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffb7c4ff),
      surfaceTint: Color(0xffb7c4ff),
      onPrimary: Color(0xff1e2d61),
      primaryContainer: Color(0xff364479),
      onPrimaryContainer: Color(0xffdce1ff),
      secondary: Color(0xffb0d18b),
      onSecondary: Color(0xff1e3702),
      secondaryContainer: Color(0xff344e17),
      onSecondaryContainer: Color(0xffcceda5),
      tertiary: Color(0xffffb3b6),
      onTertiary: Color(0xff561d23),
      tertiaryContainer: Color(0xff723338),
      onTertiaryContainer: Color(0xffffdada),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff13140d),
      onSurface: Color(0xffe4e3d6),
      onSurfaceVariant: Color(0xffc8c7b7),
      outline: Color(0xff919283),
      outlineVariant: Color(0xff47483b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e3d6),
      inversePrimary: Color(0xff4e5b92),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff05164b),
      primaryFixedDim: Color(0xffb7c4ff),
      onPrimaryFixedVariant: Color(0xff364479),
      secondaryFixed: Color(0xffcceda5),
      onSecondaryFixed: Color(0xff0f2000),
      secondaryFixedDim: Color(0xffb0d18b),
      onSecondaryFixedVariant: Color(0xff344e17),
      tertiaryFixed: Color(0xffffdada),
      onTertiaryFixed: Color(0xff3b0810),
      tertiaryFixedDim: Color(0xffffb3b6),
      onTertiaryFixedVariant: Color(0xff723338),
      surfaceDim: Color(0xff13140d),
      surfaceBright: Color(0xff393a31),
      surfaceContainerLowest: Color(0xff0e0f08),
      surfaceContainerLow: Color(0xff1b1c15),
      surfaceContainer: Color(0xff273d0f),
      surfaceContainerHigh: Color(0xff416619),
      surfaceContainerHighest: Color(0xff5b8f24),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffd4dbff),
      surfaceTint: Color(0xffb7c4ff),
      onPrimary: Color(0xff122155),
      primaryContainer: Color(0xff808ec8),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffc6e79f),
      onSecondary: Color(0xff162b00),
      secondaryContainer: Color(0xff7b9a5a),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd1d2),
      onTertiary: Color(0xff481219),
      tertiaryContainer: Color(0xffca7a7f),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff13140d),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffdeddcc),
      outline: Color(0xffb3b3a3),
      outlineVariant: Color(0xff919182),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e3d6),
      inversePrimary: Color(0xff37457a),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff000c39),
      primaryFixedDim: Color(0xffb7c4ff),
      onPrimaryFixedVariant: Color(0xff243367),
      secondaryFixed: Color(0xffcceda5),
      onSecondaryFixed: Color(0xff081400),
      secondaryFixedDim: Color(0xffb0d18b),
      onSecondaryFixedVariant: Color(0xff243d06),
      tertiaryFixed: Color(0xffffdada),
      onTertiaryFixed: Color(0xff2c0006),
      tertiaryFixedDim: Color(0xffffb3b6),
      onTertiaryFixedVariant: Color(0xff5e2328),
      surfaceDim: Color(0xff13140d),
      surfaceBright: Color(0xff45453c),
      surfaceContainerLowest: Color(0xff070803),
      surfaceContainerLow: Color(0xff1d1e16),
      surfaceContainer: Color(0xff273d0f),
      surfaceContainerHigh: Color(0xff416619),
      surfaceContainerHighest: Color(0xff5b8f24),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeeefff),
      surfaceTint: Color(0xffb7c4ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffb2c0fd),
      onPrimaryContainer: Color(0xff00072c),
      secondary: Color(0xffd9fbb1),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffaccd87),
      onSecondaryContainer: Color(0xff050e00),
      tertiary: Color(0xffffeceb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffffadb1),
      onTertiaryContainer: Color(0xff210004),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff13140d),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff2f1df),
      outlineVariant: Color(0xffc4c3b3),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe4e3d6),
      inversePrimary: Color(0xff37457a),
      primaryFixed: Color(0xffdce1ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffb7c4ff),
      onPrimaryFixedVariant: Color(0xff000c39),
      secondaryFixed: Color(0xffcceda5),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb0d18b),
      onSecondaryFixedVariant: Color(0xff081400),
      tertiaryFixed: Color(0xffffdada),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb3b6),
      onTertiaryFixedVariant: Color(0xff2c0006),
      surfaceDim: Color(0xff13140d),
      surfaceBright: Color(0xff505147),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff1f2018),
      surfaceContainer: Color(0xff273d0f),
      surfaceContainerHigh: Color(0xff416619),
      surfaceContainerHighest: Color(0xff5b8f24),
    );
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
        scaffoldBackgroundColor: colorScheme.surfaceContainer,
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
