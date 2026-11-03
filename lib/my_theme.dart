import 'package:material_ui/material_ui.dart';

// TODO: Light tertiary is too harsh -updated
// TODO: Light onSecondaryContainer is too light -updated
// TODO: Dark onSecondaryContainer is too dark
// TODO: Make onSurfaceVariant closer to onSurface -updated
// TODO: Desaturate dark tertiary a bit
// TODO: Dark secondaryContainer is too green?

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

  const new light()
    // onSurface with alpha
    : faintBorder = const Color(0x0C202226),
      // Color.lerp(_lightScheme.onSurface, _lightScheme.surfaceContainerHigh, 0.9)!,
      faintButtonBackground = const Color(0xFFD1D4D9),
      faintButtonForeground = _Colours.onSurfaceLight,
      faintButtonIcon = _Colours.onSurfaceVariantLight,
      dialogBackground = _Colours.surfaceContainerLight,
      // onSurface with alpha
      dialogDivider = const Color(0x28202226),
      sheetBackground = _Colours.surfaceContainerLight,
      cardBackground = _Colours.surfaceContainerLowestLight,
      // onSurface with alpha
      cardDivider = const Color(0x28202226),
      // onSurface with alpha
      dialogHeaderDivider = const Color(0x10202226),
      // onSurface with alpha
      sheetHeaderDivider = const Color(0x10202226),
      settingItemDivider = _Colours.outlineVariantLight,
      translucentHighlight = Colors.white24,
      scrollShadow = Colors.black38,
      // primary with alpha
      scrollGlow = const Color(0x230068A4),
      headerShadow = Colors.black87;

  const new dark()
    : faintBorder = Colors.black12,
      // Color.lerp(_darkScheme.onSurface, _darkScheme.surfaceContainerHigh, 0.85)!,
      faintButtonBackground = const Color(0xFF3A3E42),
      faintButtonForeground = _Colours.onSurfaceDark,
      faintButtonIcon = _Colours.onSurfaceVariantDark,
      dialogBackground = _Colours.surfaceContainerHighestDark,
      dialogDivider = const Color(0x25E1E6EC),
      sheetBackground = _Colours.surfaceBrightDark,
      cardBackground = _Colours.surfaceContainerHighDark,
      cardDivider = const Color(0x40E1E6EC),
      dialogHeaderDivider = const Color(0x0CE1E6EC), // mix
      sheetHeaderDivider = const Color(0x0FE1E6EC),
      settingItemDivider = _Colours.outlineVariantDark,
      translucentHighlight = Colors.white12,
      scrollShadow = const Color(0x500068A4),
      scrollGlow = const Color(0x500068A4),
      headerShadow = _Colours.primaryLight;
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
  // Generated by MaterialKolor Builder 2.0.0 with colors from MaterialKolor 6.0.0.
  // Open this theme in the builder at https://materialkolor.com/t/AQCu-iEAABM1P7L_8l5Rdnd5eHd34213C0J1cm50IEVtYmVyIA

  static const primaryLight = Color(0xFF0068A4); // Color(0xFF006397);
  static const onPrimaryLight = Color(0xFFF4F8FF);
  static const primaryContainerLight = Color(0xFFCCE5FF);
  static const onPrimaryContainerLight = Color(0xFF005690); //Color(0xFF005684);
  static const inversePrimaryLight = Color(0xFF34ABF8);
  static const secondaryLight = Color(0xFF5D5F62);
  static const onSecondaryLight = Color(0xFFF8F9FC);
  static const secondaryContainerLight = Color(0xFFE2E2E5);
  static const onSecondaryContainerLight = Color(0xFF2D3338); //Color(0xFF505254);
  static const tertiaryLight = Color(0xFFC02C22); // Color(0xFFB02F27);
  static const onTertiaryLight = Color(0xFFFFF7F6);
  static const tertiaryContainerLight = Color(0xFFF45F52);
  static const onTertiaryContainerLight = Color(0xFF290001);
  static const surfaceLight = Color(0xFFF9F9FB);
  static const onSurfaceLight = Color(0xFF202226); // Color(0xFF2D3338);
  static const onSurfaceVariantLight = Color(0xFF505258); // Color(0xFF5A6065);
  static const surfaceTintLight = Color(0xFF006397);
  static const inverseSurfaceLight = Color(0xFF0D0E10);
  static const errorLight = Color(0xFF9F403D);
  static const onErrorLight = Color(0xFFFFF7F6);
  static const errorContainerLight = Color(0xFFFE8983);
  static const onErrorContainerLight = Color(0xFF752121);
  static const outlineLight = Color(0xFF767B81);
  static const outlineVariantLight = Color(0xFFADB2B8);
  static const scrimLight = Color(0xFF000000);
  static const surfaceBrightLight = Color(0xFFF9F9FB);
  static const surfaceContainerLight = Color(0xFFECEEF2);
  static const surfaceContainerHighLight = Color(0xFFE5E8ED);
  static const surfaceContainerHighestLight = Color(0xFFDEE3E9);
  static const surfaceContainerLowLight = Color(0xFFF3F3F6);
  static const surfaceContainerLowestLight = Color(0xFFFFFFFF);
  static const surfaceDimLight = Color(0xFFD4DBE2);
  static const primaryFixedLight = Color(0xFFCCE5FF);
  static const primaryFixedDimLight = Color(0xFFB0D9FF);
  static const onPrimaryFixedLight = Color(0xFF004368);
  static const onPrimaryFixedVariantLight = Color(0xFF006093);
  static const secondaryFixedLight = Color(0xFFE2E2E5);
  static const secondaryFixedDimLight = Color(0xFFD4D4D7);
  static const onSecondaryFixedLight = Color(0xFF3D3F42);
  static const onSecondaryFixedVariantLight = Color(0xFF5A5C5E);
  static const tertiaryFixedLight = Color(0xFFF45F52);
  static const tertiaryFixedDimLight = Color(0xFFE35347);
  static const onTertiaryFixedLight = Color(0xFF000000);
  static const onTertiaryFixedVariantLight = Color(0xFF420002);

  static const primaryDark = Color(0xFF92CCFF);
  static const onPrimaryDark = Color(0xFF004469);
  static const primaryContainerDark = Color(0xFF004884); // Color(0xFF004B73);
  static const onPrimaryContainerDark = Color(0xFFA8D5FF);
  static const inversePrimaryDark = Color(0xFF006498);
  static const secondaryDark = Color(0xFF9D9EA1);
  static const onSecondaryDark = Color(0xFF1E2023);
  static const secondaryContainerDark = Color(0xFF404248); // Color(0xFF393C3E);
  static const onSecondaryContainerDark = Color(0xFFE1E6EC); // Color(0xFFBEBFC2);
  static const tertiaryDark = Color(0xFFFF8880); // Color(0xFFFF7163);
  static const onTertiaryDark = Color(0xFF4A0002);
  static const tertiaryContainerDark = Color(0xFFF45F52);
  static const onTertiaryContainerDark = Color(0xFF290001);
  static const surfaceDark = Color(0xFF0D0E10);
  static const onSurfaceDark = Color(0xFFE1E6EC);
  static const onSurfaceVariantDark = Color(0xFFCACCCF); // Color(0xFFA6ACB1);
  static const surfaceTintDark = Color(0xFF92CCFF);
  static const inverseSurfaceDark = Color(0xFFF9F9FB);
  static const errorDark = Color(0xFFEE7D77);
  static const onErrorDark = Color(0xFF490106);
  static const errorContainerDark = Color(0xFF7F2927);
  static const onErrorContainerDark = Color(0xFFFF9993);
  static const outlineDark = Color(0xFF70767B);
  static const outlineVariantDark = Color(0xFF43494E);
  static const scrimDark = Color(0xFF000000);
  static const surfaceBrightDark = Color(0xFF272C30); // Color(0xFF262D32);
  static const surfaceContainerDark = Color(0xFF161A1D);
  static const surfaceContainerHighDark = Color(0xFF1C2024);
  static const surfaceContainerHighestDark = Color(0xFF21262B);
  static const surfaceContainerLowDark = Color(0xFF111416);
  static const surfaceContainerLowestDark = Color(0xFF000000);
  static const surfaceDimDark = Color(0xFF0D0E10);
  static const primaryFixedDark = Color(0xFFCCE5FF);
  static const primaryFixedDimDark = Color(0xFFB0D9FF);
  static const onPrimaryFixedDark = Color(0xFF004368);
  static const onPrimaryFixedVariantDark = Color(0xFF006093);
  static const secondaryFixedDark = Color(0xFFE2E2E5);
  static const secondaryFixedDimDark = Color(0xFFD4D4D7);
  static const onSecondaryFixedDark = Color(0xFF3D3F42);
  static const onSecondaryFixedVariantDark = Color(0xFF5A5C5E);
  static const tertiaryFixedDark = Color(0xFFF45F52);
  static const tertiaryFixedDimDark = Color(0xFFE35347);
  static const onTertiaryFixedDark = Color(0xFF000000);
  static const onTertiaryFixedVariantDark = Color(0xFF420002);
}
