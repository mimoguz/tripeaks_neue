import 'package:material_ui/material_ui.dart';

const _lightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: _Colours.primaryLight,
  onPrimary: _Colours.onPrimaryLight,
  primaryContainer: _Colours.primaryContainerLight,
  onPrimaryContainer: _Colours.onPrimaryContainerLight,
  inversePrimary: _Colours.inversePrimaryLight,
  secondary: _Colours.secondaryLight,
  onSecondary: _Colours.onSecondaryLight,
  secondaryContainer: _Colours.secondaryContainerLight,
  onSecondaryContainer: _Colours.onSecondaryContainerLight,
  tertiary: _Colours.tertiaryLight,
  onTertiary: _Colours.onTertiaryLight,
  tertiaryContainer: _Colours.tertiaryContainerLight,
  onTertiaryContainer: _Colours.onTertiaryContainerLight,
  surface: _Colours.surfaceLight,
  onSurface: _Colours.onSurfaceLight,
  onSurfaceVariant: _Colours.onSurfaceVariantLight,
  surfaceTint: _Colours.surfaceTintLight,
  inverseSurface: _Colours.inverseSurfaceLight,
  error: _Colours.errorLight,
  onError: _Colours.onErrorLight,
  errorContainer: _Colours.errorContainerLight,
  onErrorContainer: _Colours.onErrorContainerLight,
  outline: _Colours.outlineLight,
  outlineVariant: _Colours.outlineVariantLight,
  scrim: _Colours.scrimLight,
  surfaceBright: _Colours.surfaceBrightLight,
  surfaceContainer: _Colours.surfaceContainerLight,
  surfaceContainerHigh: _Colours.surfaceContainerHighLight,
  surfaceContainerHighest: _Colours.surfaceContainerHighestLight,
  surfaceContainerLow: _Colours.surfaceContainerLowLight,
  surfaceContainerLowest: _Colours.surfaceContainerLowestLight,
  surfaceDim: _Colours.surfaceDimLight,
  primaryFixed: _Colours.primaryFixedLight,
  primaryFixedDim: _Colours.primaryFixedDimLight,
  onPrimaryFixed: _Colours.onPrimaryFixedLight,
  onPrimaryFixedVariant: _Colours.onPrimaryFixedVariantLight,
  secondaryFixed: _Colours.secondaryFixedLight,
  secondaryFixedDim: _Colours.secondaryFixedDimLight,
  onSecondaryFixed: _Colours.onSecondaryFixedLight,
  onSecondaryFixedVariant: _Colours.onSecondaryFixedVariantLight,
  tertiaryFixed: _Colours.tertiaryFixedLight,
  tertiaryFixedDim: _Colours.tertiaryFixedDimLight,
  onTertiaryFixed: _Colours.onTertiaryFixedLight,
  onTertiaryFixedVariant: _Colours.onTertiaryFixedVariantLight,
);

const _darkScheme = ColorScheme(
  brightness: .dark,
  primary: _Colours.primaryDark,
  onPrimary: _Colours.onPrimaryDark,
  primaryContainer: _Colours.primaryContainerDark,
  onPrimaryContainer: _Colours.onPrimaryContainerDark,
  inversePrimary: _Colours.inversePrimaryDark,
  secondary: _Colours.secondaryDark,
  onSecondary: _Colours.onSecondaryDark,
  secondaryContainer: _Colours.secondaryContainerDark,
  onSecondaryContainer: _Colours.onSecondaryContainerDark,
  tertiary: _Colours.tertiaryDark,
  onTertiary: _Colours.onTertiaryDark,
  tertiaryContainer: _Colours.tertiaryContainerDark,
  onTertiaryContainer: _Colours.onTertiaryContainerDark,
  surface: _Colours.surfaceDark,
  onSurface: _Colours.onSurfaceDark,
  onSurfaceVariant: _Colours.onSurfaceVariantDark,
  surfaceTint: _Colours.surfaceTintDark,
  inverseSurface: _Colours.inverseSurfaceDark,
  error: _Colours.errorDark,
  onError: _Colours.onErrorDark,
  errorContainer: _Colours.errorContainerDark,
  onErrorContainer: _Colours.onErrorContainerDark,
  outline: _Colours.outlineDark,
  outlineVariant: _Colours.outlineVariantDark,
  scrim: _Colours.scrimDark,
  surfaceBright: _Colours.surfaceBrightDark,
  surfaceContainer: _Colours.surfaceContainerDark,
  surfaceContainerHigh: _Colours.surfaceContainerHighDark,
  surfaceContainerHighest: _Colours.surfaceContainerHighestDark,
  surfaceContainerLow: _Colours.surfaceContainerLowDark,
  surfaceContainerLowest: _Colours.surfaceContainerLowestDark,
  surfaceDim: _Colours.surfaceDimDark,
  primaryFixed: _Colours.primaryFixedDark,
  primaryFixedDim: _Colours.primaryFixedDimDark,
  onPrimaryFixed: _Colours.onPrimaryFixedDark,
  onPrimaryFixedVariant: _Colours.onPrimaryFixedVariantDark,
  secondaryFixed: _Colours.secondaryFixedDark,
  secondaryFixedDim: _Colours.secondaryFixedDimDark,
  onSecondaryFixed: _Colours.onSecondaryFixedDark,
  onSecondaryFixedVariant: _Colours.onSecondaryFixedVariantDark,
  tertiaryFixed: _Colours.tertiaryFixedDark,
  tertiaryFixedDim: _Colours.tertiaryFixedDimDark,
  onTertiaryFixed: _Colours.onTertiaryFixedDark,
  onTertiaryFixedVariant: _Colours.onTertiaryFixedVariantDark,
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
  final Color headerShadow;
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
      scrollGlow = _lightScheme.primary.withAlpha(35),
      headerShadow = _lightScheme.shadow;

  new dark()
    : faintBorder = _darkScheme.onInverseSurface.withAlpha(10),
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
      scrollGlow = _lightScheme.primary.withAlpha(35),
      headerShadow = _lightScheme.primary;
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

abstract final class _Colours {
  // Light colours
  // Primaries
  static const primaryLight = Color(0xFF006595);
  static const onPrimaryLight = Color(0xFFF6F9FF);
  static const primaryContainerLight = Color(0xFF1C9CE0);
  static const onPrimaryContainerLight = Color(0xFF001524);
  static const inversePrimaryLight = Color(0xFF45B4FA);
  static const primaryFixedLight = Color(0xFF1C9CE0);
  static const primaryFixedDimLight = Color(0xFF008ED0);
  static const onPrimaryFixedLight = Color(0xFF000000);
  static const onPrimaryFixedVariantLight = Color(0xFF002135);
  // Others
  static const secondaryLight = Color(0xFF5C5F66);
  static const onSecondaryLight = Color(0xFFF7F9FF);
  static const secondaryContainerLight = Color(0xFFE0E2EA);
  static const onSecondaryContainerLight = Color(0xFF4E5258);
  static const tertiaryLight = Color(0xFFB62435);
  static const onTertiaryLight = Color(0xFFFFF7F6);
  static const tertiaryContainerLight = Color(0xFFFF8082);
  static const onTertiaryContainerLight = Color(0xFF58000F);
  static const surfaceLight = Color(0xFFFAF8FF);
  static const onSurfaceLight = Color(0xFF2E323F);
  static const onSurfaceVariantLight = Color(0xFF5B5F6D);
  static const surfaceTintLight = Color(0xFF5B5E67);
  static const inverseSurfaceLight = Color(0xFF0A0E19);
  static const errorLight = Color(0xFF9F413A);
  static const onErrorLight = Color(0xFFFFF7F6);
  static const errorContainerLight = Color(0xFFFB877D);
  static const onErrorContainerLight = Color(0xFF570B0B);
  static const outlineLight = Color(0xFF767A89);
  static const outlineVariantLight = Color(0xFFAEB1C1);
  static const scrimLight = Color(0xFF000000);
  static const surfaceBrightLight = Color(0xFFFAF8FF);
  static const surfaceContainerLight = Color(0xFFECEDFB);
  static const surfaceContainerHighLight = Color(0xFFE5E7F6);
  static const surfaceContainerHighestLight = Color(0xFFDFE2F3);
  static const surfaceContainerLowLight = Color(0xFFF2F3FF);
  static const surfaceContainerLowestLight = Color(0xFFFFFFFF);
  static const surfaceDimLight = Color(0xFFD6D9EA);

  static const secondaryFixedLight = Color(0xFFE0E2EA);
  static const secondaryFixedDimLight = Color(0xFFD2D4DC);
  static const onSecondaryFixedLight = Color(0xFF3C3F46);
  static const onSecondaryFixedVariantLight = Color(0xFF585C62);
  static const tertiaryFixedLight = Color(0xFFFF8082);
  static const tertiaryFixedDimLight = Color(0xFFFF666C);
  static const onTertiaryFixedLight = Color(0xFF190002);
  static const onTertiaryFixedVariantLight = Color(0xFF690014);

  // Dark colours
  // Primaries
  static const primaryDark = Color(0xFF35A9EE);
  static const onPrimaryDark = Color(0xFF00253B);
  static const primaryContainerDark = Color(0xFF1C9CE0);
  static const onPrimaryContainerDark = Color(0xFF001524);
  static const inversePrimaryDark = Color(0xFF006595);
  static const primaryFixedDark = Color(0xFF1C9CE0);
  static const primaryFixedDimDark = Color(0xFF008ED0);
  static const onPrimaryFixedDark = Color(0xFF000000);
  static const onPrimaryFixedVariantDark = Color(0xFF002135);
  // Others
  static const secondaryDark = Color(0xFF9B9EA5);
  static const onSecondaryDark = Color(0xFF1D2026);
  static const secondaryContainerDark = Color(0xFF2D3136);
  static const onSecondaryContainerDark = Color(0xFFAEB0B8);
  static const tertiaryDark = Color(0xFFFF9697);
  static const onTertiaryDark = Color(0xFF6D0015);
  static const tertiaryContainerDark = Color(0xFFFF8082);
  static const onTertiaryContainerDark = Color(0xFF58000F);
  static const surfaceDark = Color(0xFF0C0E14);
  static const onSurfaceDark = Color(0xFFE2E5F6);
  static const onSurfaceVariantDark = Color(0xFFA7AABA);
  static const surfaceTintDark = Color(0xFFC3C6D1);
  static const inverseSurfaceDark = Color(0xFFFAF8FF);
  static const errorDark = Color(0xFFFB877D);
  static const onErrorDark = Color(0xFF570B0B);
  static const errorContainerDark = Color(0xFF4B0205);
  static const onErrorContainerDark = Color(0xFFF07F75);
  static const outlineDark = Color(0xFF717584);
  static const outlineVariantDark = Color(0xFF444855);
  static const scrimDark = Color(0xFF000000);
  static const surfaceBrightDark = Color(0xFF282C38);
  static const surfaceContainerDark = Color(0xFF161923);
  static const surfaceContainerHighDark = Color(0xFF1C1F2A);
  static const surfaceContainerHighestDark = Color(0xFF212532);
  static const surfaceContainerLowDark = Color(0xFF10131B);
  static const surfaceContainerLowestDark = Color(0xFF000000);
  static const surfaceDimDark = Color(0xFF0C0E14);
  static const secondaryFixedDark = Color(0xFFE0E2EA);
  static const secondaryFixedDimDark = Color(0xFFD2D4DC);
  static const onSecondaryFixedDark = Color(0xFF3C3F46);
  static const onSecondaryFixedVariantDark = Color(0xFF585C62);
  static const tertiaryFixedDark = Color(0xFFFF8082);
  static const tertiaryFixedDimDark = Color(0xFFFF666C);
  static const onTertiaryFixedDark = Color(0xFF190002);
  static const onTertiaryFixedVariantDark = Color(0xFF690014);
}
