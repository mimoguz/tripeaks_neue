import 'package:material_ui/material_ui.dart';

const _lightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff005cac),
  surfaceTint: Color(0xff005fb0),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xff0075d7),
  onPrimaryContainer: Color(0xfffefcff),
  secondary: Color(0xff435f89),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xffDBE2F7),
  onSecondaryContainer: Color(0xFF282832),
  tertiary: Color(0xFFC62C24),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xffff665a),
  onTertiaryContainer: Color(0xff690005),
  error: Color(0xffb60e45),
  onError: Color(0xffffffff),
  errorContainer: Color(0xffd9305d),
  onErrorContainer: Color(0xfffffbff),
  surface: Color(0xfff9f9fc),
  onSurface: Color(0xff181c22),
  onSurfaceVariant: Color(0xff404753),
  outline: Color(0xff717785),
  outlineVariant: Color(0xffc0c7d5),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2d3038),
  inversePrimary: Color(0xffa6c8ff),
  primaryFixed: Color(0xffd5e3ff),
  onPrimaryFixed: Color(0xff001c3b),
  primaryFixedDim: Color(0xffa6c8ff),
  onPrimaryFixedVariant: Color(0xff004787),
  secondaryFixed: Color(0xffd5e3ff),
  onSecondaryFixed: Color(0xff001c3b),
  secondaryFixedDim: Color(0xffabc8f8),
  onSecondaryFixedVariant: Color(0xff2a4870),
  tertiaryFixed: Color(0xffffdad6),
  onTertiaryFixed: Color(0xff410002),
  tertiaryFixedDim: Color(0xffffb4ab),
  onTertiaryFixedVariant: Color(0xff8e1213),
  surfaceDim: Color(0xffd7dae3),
  surfaceBright: Color(0xfff9f9ff),
  surfaceContainerLowest: Color(0xfffefeff),
  surfaceContainerLow: Color(0xfff1f3fd),
  surfaceContainer: Color(0xffebeef7),
  surfaceContainerHigh: Color(0xffe5e8f1),
  surfaceContainerHighest: Color(0xffe0e2e5),
);

const _lightHighContrastScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xff002c58),
  surfaceTint: Color(0xff005fb0),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xff00498b),
  onPrimaryContainer: Color(0xffffffff),
  secondary: Color(0xff082c54),
  onSecondary: Color(0xffffffff),
  secondaryContainer: Color(0xff2c4a73),
  onSecondaryContainer: Color(0xffffffff),
  tertiary: Color(0xff600004),
  onTertiary: Color(0xffffffff),
  tertiaryContainer: Color(0xff921515),
  onTertiaryContainer: Color(0xffffffff),
  error: Color(0xff5f001f),
  onError: Color(0xffffffff),
  errorContainer: Color(0xff950036),
  onErrorContainer: Color(0xffffffff),
  surface: Color(0xfff9f9ff),
  onSurface: Color(0xff000000),
  onSurfaceVariant: Color(0xff000000),
  outline: Color(0xff262c38),
  outlineVariant: Color(0xff434956),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xff2d3038),
  inversePrimary: Color(0xffa6c8ff),
  primaryFixed: Color(0xff00498b),
  onPrimaryFixed: Color(0xffffffff),
  primaryFixedDim: Color(0xff003363),
  onPrimaryFixedVariant: Color(0xffffffff),
  secondaryFixed: Color(0xff2c4a73),
  onSecondaryFixed: Color(0xffffffff),
  secondaryFixedDim: Color(0xff12335b),
  onSecondaryFixedVariant: Color(0xffffffff),
  tertiaryFixed: Color(0xff921515),
  onTertiaryFixed: Color(0xffffffff),
  tertiaryFixedDim: Color(0xff6d0006),
  onTertiaryFixedVariant: Color(0xffffffff),
  surfaceDim: Color(0xffb6b9c2),
  surfaceBright: Color(0xfff9f9ff),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceContainerLow: Color(0xffeef0fa),
  surfaceContainer: Color(0xffe0e2ec),
  surfaceContainerHigh: Color(0xffd3d5d8),
  surfaceContainerHighest: Color(0xffc5c6ca),
);

const _darkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffa6c8ff),
  surfaceTint: Color(0xffa6c8ff),
  onPrimary: Color(0xff00315f),
  primaryContainer: Color(0xff2b91ff),
  onPrimaryContainer: Color(0xff002953),
  secondary: Color(0xffabc8f8),
  onSecondary: Color(0xff0f3158),
  secondaryContainer: Color(0xFF353845),
  onSecondaryContainer: Color(0xff9dbaf0),
  tertiary: Color(0xFFF49085),
  onTertiary: Color(0xff690005),
  tertiaryContainer: Color(0xffff665a),
  onTertiaryContainer: Color(0xff690005),
  error: Color(0xffffb2bc),
  onError: Color(0xff670023),
  errorContainer: Color(0xffff4f77),
  onErrorContainer: Color(0xff5a001d),
  surface: Color(0xff10141a),
  onSurface: Color(0xffe0e2ec),
  onSurfaceVariant: Color(0xFFD6D8E2),
  outline: Color(0xff8a919f),
  outlineVariant: Color(0xff404753),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe0e2ec),
  inversePrimary: Color(0xff005fb0),
  primaryFixed: Color(0xffd5e3ff),
  onPrimaryFixed: Color(0xff001c3b),
  primaryFixedDim: Color(0xffa6c8ff),
  onPrimaryFixedVariant: Color(0xff004787),
  secondaryFixed: Color(0xffd5e3ff),
  onSecondaryFixed: Color(0xff001c3b),
  secondaryFixedDim: Color(0xffabc8f8),
  onSecondaryFixedVariant: Color(0xff2a4870),
  tertiaryFixed: Color(0xffffdad6),
  onTertiaryFixed: Color(0xff410002),
  tertiaryFixedDim: Color(0xffffb4ab),
  onTertiaryFixedVariant: Color(0xff8e1213),
  surfaceDim: Color(0xff10141a),
  surfaceBright: Color(0xff363941),
  surfaceContainerLowest: Color(0xff0b0e15),
  surfaceContainerLow: Color(0xff181c22),
  surfaceContainer: Color(0xff1c2026),
  surfaceContainerHigh: Color(0xff262a31),
  surfaceContainerHighest: Color(0xff31353c),
);

const _darkHighContrastScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xffeaf0ff),
  surfaceTint: Color(0xffa6c8ff),
  onPrimary: Color(0xff000000),
  primaryContainer: Color(0xff9fc4ff),
  onPrimaryContainer: Color(0xff000b1e),
  secondary: Color(0xffeaf0ff),
  onSecondary: Color(0xff000000),
  secondaryContainer: Color(0xffa7c4f4),
  onSecondaryContainer: Color(0xff000b1e),
  tertiary: Color(0xffffece9),
  onTertiary: Color(0xff000000),
  tertiaryContainer: Color(0xffffaea5),
  onTertiaryContainer: Color(0xff220001),
  error: Color(0xffffebec),
  onError: Color(0xff000000),
  errorContainer: Color(0xffffacb7),
  onErrorContainer: Color(0xff210006),
  surface: Color(0xff10141a),
  onSurface: Color(0xffffffff),
  onSurfaceVariant: Color(0xffffffff),
  outline: Color(0xffeaf0ff),
  outlineVariant: Color(0xffbcc3d1),
  shadow: Color(0xff000000),
  scrim: Color(0xff000000),
  inverseSurface: Color(0xffe0e2ec),
  inversePrimary: Color(0xff004889),
  primaryFixed: Color(0xffd5e3ff),
  onPrimaryFixed: Color(0xff000000),
  primaryFixedDim: Color(0xffa6c8ff),
  onPrimaryFixedVariant: Color(0xff001128),
  secondaryFixed: Color(0xffd5e3ff),
  onSecondaryFixed: Color(0xff000000),
  secondaryFixedDim: Color(0xffabc8f8),
  onSecondaryFixedVariant: Color(0xff001128),
  tertiaryFixed: Color(0xffffdad6),
  onTertiaryFixed: Color(0xff000000),
  tertiaryFixedDim: Color(0xffffb4ab),
  onTertiaryFixedVariant: Color(0xff2d0001),
  surfaceDim: Color(0xff10141a),
  surfaceBright: Color(0xff4d5058),
  surfaceContainerLowest: Color(0xff000000),
  surfaceContainerLow: Color(0xff1c2026),
  surfaceContainer: Color(0xff2d3038),
  surfaceContainerHigh: Color(0xff383b43),
  surfaceContainerHighest: Color(0xff43474e),
);

final _pageTransitionTheme = PageTransitionsTheme(
  builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
    TargetPlatform.values,
    value: (_) => const FadeForwardsPageTransitionsBuilder(),
  ),
);

final _tooltipTheme = TooltipThemeData(waitDuration: Durations.long4, preferBelow: false);

final class MyTextThemeExt extends ThemeExtension<MyTextThemeExt> {
  @override
  ThemeExtension<MyTextThemeExt> copyWith() => this;

  @override
  ThemeExtension<MyTextThemeExt> lerp(covariant ThemeExtension<MyTextThemeExt>? other, double t) => this;

  MyTextThemeExt.light();
  MyTextThemeExt.dark();
}

final class MyColourThemeExt extends ThemeExtension<MyColourThemeExt> {
  final Color cardBackground;
  final Color cardDivider;
  final Color dialogBackground;
  final Color dialogDivider;
  final Color dialogHeaderDivider;
  final Color faintBorder;
  final Color faintButtonBackground;
  final Color faintButtonForeground;
  final Color faintButtonIcon;
  final Color scrollGlow;
  final Color scrollShadow;
  final Color settingItemDivider;
  final Color sheetBackground;
  final Color sheetHeaderDivider;
  final Color translucentHighlight;

  @override
  ThemeExtension<MyColourThemeExt> copyWith() => this;

  @override
  ThemeExtension<MyColourThemeExt> lerp(covariant ThemeExtension<MyColourThemeExt>? other, double t) => this;

  new light()
    : faintBorder = _lightScheme.onSurface.withAlpha(10), // onSurface with alpha
      faintButtonBackground = Color.lerp(_lightScheme.onSurface, _lightScheme.surfaceContainerHigh, 0.9)!,
      faintButtonForeground = _lightScheme.onSurface,
      faintButtonIcon = _lightScheme.onSurfaceVariant,
      dialogBackground = _lightScheme.surfaceContainerHigh,
      dialogDivider = Color.lerp(_lightScheme.onSurface, _lightScheme.surfaceContainerHigh, 0.8)!,
      sheetBackground = _lightScheme.surfaceContainerHigh,
      cardBackground = _lightScheme.surfaceContainerLowest,
      cardDivider = Color.lerp(_lightScheme.onSurface, _lightScheme.surfaceContainerLowest, 0.8)!, // mix
      dialogHeaderDivider = Color.lerp(
        _lightScheme.onSurface,
        _lightScheme.surfaceContainerHigh,
        0.9,
      )!, // mix
      sheetHeaderDivider = Color.lerp(_lightScheme.onSurface, _lightScheme.surfaceContainerHigh, 0.9)!, // mix
      settingItemDivider = _lightScheme.outlineVariant,
      translucentHighlight = Colors.white24,
      scrollShadow = Colors.black38,
      scrollGlow = _lightScheme.primary.withAlpha(35);

  new dark()
    : faintBorder = _darkScheme.onSurface.withAlpha(8),
      faintButtonBackground = Color.lerp(_darkScheme.onSurface, _darkScheme.surfaceContainerHigh, 0.85)!,
      faintButtonForeground = _darkScheme.onSurface,
      faintButtonIcon = _darkScheme.onSurfaceVariant,
      dialogBackground = _darkScheme.surfaceContainerHighest,
      dialogDivider = Color.lerp(_darkScheme.onSurface, _darkScheme.surfaceContainerHighest, 0.8)!,
      sheetBackground = _darkScheme.surfaceContainerHighest,
      cardBackground = _darkScheme.surfaceContainerHigh,
      cardDivider = Color.lerp(_darkScheme.onSurface, _darkScheme.surfaceContainerHigh, 0.8)!, // mix
      dialogHeaderDivider = Color.lerp(
        _darkScheme.onSurface,
        _darkScheme.surfaceContainerHighest,
        0.9,
      )!, // mix
      sheetHeaderDivider = Color.lerp(
        _darkScheme.onSurface,
        _darkScheme.surfaceContainerHighest,
        0.9,
      )!, // mix
      settingItemDivider = _darkScheme.outlineVariant,
      translucentHighlight = Colors.white12,
      scrollShadow = _lightScheme.primary.withAlpha(150),
      scrollGlow = _lightScheme.primary.withAlpha(35);
}

ThemeData light() => ThemeData(
  brightness: .light,
  colorScheme: _lightScheme,
  pageTransitionsTheme: _pageTransitionTheme,
  tooltipTheme: _tooltipTheme,
  useMaterial3: true,
  extensions: <ThemeExtension<dynamic>>[MyColourThemeExt.light(), MyTextThemeExt.light()],
);

ThemeData dark() => ThemeData(
  brightness: .dark,
  colorScheme: _darkScheme,
  pageTransitionsTheme: _pageTransitionTheme,
  tooltipTheme: _tooltipTheme,
  useMaterial3: true,
  extensions: <ThemeExtension<dynamic>>[MyColourThemeExt.dark(), MyTextThemeExt.dark()],
);
