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

  new light()
    : faintBorder = _lightScheme.onSurface.withAlpha(12), // onSurface with alpha
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
      scrollShadow = _lightScheme.primary.withAlpha(100),
      scrollGlow = _lightScheme.primary.withAlpha(50),
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
  static const primaryLight = Color(0xFF006190);
  static const onPrimaryLight = Color(0xFFFFFFFF);
  static const primaryContainerLight = Color(0xFF007BB5);
  static const onPrimaryContainerLight = Color(0xFFFCFCFF);
  static const inversePrimaryLight = Color(0xFF8ECDFF);
  static const primaryFixedLight = Color(0xFFCAE6FF);
  static const primaryFixedDimLight = Color(0xFF8ECDFF);
  static const onPrimaryFixedLight = Color(0xFF001E30);
  static const onPrimaryFixedVariantLight = Color(0xFF004B70);
  // Others
  static const secondaryLight = Color(0xFF5C5F66);
  static const onSecondaryLight = Color(0xFFF7F9FF);
  static const secondaryContainerLight = Color(0xFFDEDFE8); // Color(0xFFE0E2EA);
  static const onSecondaryContainerLight = Color(0xFF202026); // Color(0xFF4E5258);
  static const tertiaryLight = Color(0xFFC62638); // Color(0xFFB62435);
  static const onTertiaryLight = Color(0xFFFFF7F6);
  static const tertiaryContainerLight = Color(0xFFFE5A63);
  static const onTertiaryContainerLight = Color(0xFF310005);
  static const surfaceLight = Color(0xFFF9F9FA); // Color(0xFFFAF9FA);
  static const onSurfaceLight = Color(0xFF202026); //Color(0xFF303335);
  static const onSurfaceVariantLight = Color(0xFF303335); // Color(0xFF5D5F61);
  static const surfaceTintLight = Color(0xFF006595);
  static const inverseSurfaceLight = Color(0xFF0C0F10);
  static const errorLight = Color(0xFFA23E37);
  static const onErrorLight = Color(0xFFFFF7F6);
  static const errorContainerLight = Color(0xFFF97F75);
  static const onErrorContainerLight = Color(0xFF520205);
  static const outlineLight = Color(0xFF797B7D);
  static const outlineVariantLight = Color(0xFFB1B2B4);
  static const scrimLight = Color(0xFF000000);
  static const surfaceBrightLight = Color(0xFFFAF9FA);
  static const surfaceContainerLight = Color(0xFFEEEEEF);
  static const surfaceContainerHighLight = Color(0xFFE8E8EA);
  static const surfaceContainerHighestLight = Color(0xFFE1E2E5);
  static const surfaceContainerLowLight = Color(0xFFF4F3F5);
  static const surfaceContainerLowestLight = Color(0xFFFFFFFF);
  static const surfaceDimLight = Color(0xFFD9DADC);
  static const secondaryFixedLight = Color(0xFFE0E2EA);
  static const secondaryFixedDimLight = Color(0xFFD2D4DC);
  static const onSecondaryFixedLight = Color(0xFF3C3F46);
  static const onSecondaryFixedVariantLight = Color(0xFF585C62);
  static const tertiaryFixedLight = Color(0xFFFE5A63);
  static const tertiaryFixedDimLight = Color(0xFFEC4D58);
  static const onTertiaryFixedLight = Color(0xFF000000);
  static const onTertiaryFixedVariantLight = Color(0xFF47000A);

  // Dark colours
  // Primaries
  static const primaryDark = Color(0xFF8ECDFF);
  static const onPrimaryDark = Color(0xFF00344F);
  static const primaryContainerDark = Color(0xFF1599DD);
  static const onPrimaryContainerDark = Color(0xFF00283E);
  static const inversePrimaryDark = Color(0xFF006494);
  static const primaryFixedDark = Color(0xFFCAE6FF);
  static const primaryFixedDimDark = Color(0xFF8ECDFF);
  static const onPrimaryFixedDark = Color(0xFF001E30);
  static const onPrimaryFixedVariantDark = Color(0xFF004B70);
  // Others
  static const secondaryDark = Color(0xFF9B9EA5);
  static const onSecondaryDark = Color(0xFF1D2026);
  static const secondaryContainerDark = Color(0xFF2F3338); // Color(0xFF2D3136);
  static const onSecondaryContainerDark = Color(0xFFE0E2E5); // Color(0xFFAEB0B8);
  static const tertiaryDark = Color(0xFFFF7579);
  static const onTertiaryDark = Color(0xFF4E000C);
  static const tertiaryContainerDark = Color(0xFFFE5A63);
  static const onTertiaryContainerDark = Color(0xFF310005);
  static const surfaceDark = Color(0xFF121418); // Color(0xFF0D0E0F);
  static const onSurfaceDark = Color(0xFFE4E5E8);
  static const onSurfaceVariantDark = Color(0xFFAAABAD);
  static const surfaceTintDark = Color(0xFF35A9EE);
  static const inverseSurfaceDark = Color(0xFFF9F9FB);
  static const errorDark = Color(0xFFF97F75);
  static const onErrorDark = Color(0xFF520205);
  static const errorContainerDark = Color(0xFF530205);
  static const onErrorContainerDark = Color(0xFFFA8076);
  static const outlineDark = Color(0xFF747678);
  static const outlineVariantDark = Color(0xFF46484A);
  static const scrimDark = Color(0xFF000000);
  static const surfaceBrightDark = Color(0xFF2A2C2E);
  static const surfaceContainerDark = Color(0xFF181A1B);
  static const surfaceContainerHighDark = Color(0xFF1E2021);
  static const surfaceContainerHighestDark = Color(0xFF242628);
  static const surfaceContainerLowDark = Color(0xFF121415);
  static const surfaceContainerLowestDark = Color(0xFF000000);
  static const surfaceDimDark = Color(0xFF0D0E0F);
  static const secondaryFixedDark = Color(0xFFE0E2EA);
  static const secondaryFixedDimDark = Color(0xFFD2D4DC);
  static const onSecondaryFixedDark = Color(0xFF3C3F46);
  static const onSecondaryFixedVariantDark = Color(0xFF585C62);
  static const tertiaryFixedDark = Color(0xFFFE5A63);
  static const tertiaryFixedDimDark = Color(0xFFEC4D58);
  static const onTertiaryFixedDark = Color(0xFF000000);
  static const onTertiaryFixedVariantDark = Color(0xFF47000A);
}
