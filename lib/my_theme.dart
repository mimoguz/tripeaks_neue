import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/platform_utils.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

// ignore_for_file: unused_field, unused_element

ThemeData light() => isDesktop ? _desktopLight : _light;
ThemeData dark() => isDesktop ? _desktopDark : _dark;

final class MyValueExt extends ThemeExtension<MyValueExt> {
  final double utilPageMarginBottom;
  final EdgeInsets utilPageMargins;
  final EdgeInsets dialogTitlePadding;
  final BoxDecoration cardDecoration;
  final List<BoxShadow> sheetShadow;

  new desktop()
    : utilPageMarginBottom = 10,
      utilPageMargins = const EdgeInsets.all(10),
      dialogTitlePadding = const EdgeInsets.fromLTRB(16, 8, 14, 8),
      cardDecoration = BoxDecoration(
        boxShadow: const [
          // Primary soft diffuse shadow
          BoxShadow(color: Color(0x0A000006), blurRadius: 3.0, spreadRadius: 0.0, offset: Offset(0.0, 1.0)),
          // Secondary structural depth shadow
          BoxShadow(color: Color(0x0F000006), blurRadius: 8.0, spreadRadius: -1.0, offset: Offset(0.0, 2.0)),
        ],
        borderRadius: c.commonBorderRadius,
      ),
      sheetShadow = const [
        // Primary soft diffuse shadow
        BoxShadow(color: Color(0x0A000006), blurRadius: 3.0, spreadRadius: 0.0),
        // Secondary structural depth shadow
        BoxShadow(color: Color(0x0F000006), blurRadius: 8.0, spreadRadius: -1.0, offset: Offset(0.0, 1.0)),
      ];

  new mobile()
    : utilPageMarginBottom = 20,
      utilPageMargins = const EdgeInsets.fromLTRB(10, 10, 10, 20),
      dialogTitlePadding = const EdgeInsets.fromLTRB(16, 8, 12, 8),
      cardDecoration = BoxDecoration(
        boxShadow: const [BoxShadow(color: Color(0x05050008), blurRadius: 5, offset: Offset(0, 2))],
        borderRadius: c.commonBorderRadius,
      ),
      sheetShadow = const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(0.0, 1.0))];

  @override
  ThemeExtension<MyValueExt> copyWith() => this;

  @override
  ThemeExtension<MyValueExt> lerp(MyValueExt? other, double t) => this;
}

final class MyTextThemeExt extends ThemeExtension<MyTextThemeExt> {
  final TextStyle sectionTitle;
  final TextStyle dialogTitle;
  final TextStyle listItemSubtitle;
  final TextStyle faintLabelMedium;
  final TextStyle faintLabelSmall;
  final TextStyle paragraphText;
  final TextStyle paragraphTextItalic;
  final TextStyle numericBody;
  final TextStyle numericTitle;
  final TextStyle numericLarge;
  final TextStyle numericMedium;
  final TextStyle link;

  @override
  ThemeExtension<MyTextThemeExt> copyWith() => this;

  @override
  ThemeExtension<MyTextThemeExt> lerp(covariant ThemeExtension<MyTextThemeExt>? other, double t) => this;

  factory light() => MyTextThemeExt._make(
    primary: _Colours.primaryLight,
    onSurface: _Colours.onSurfaceLight,
    onSurfaceVariant: _Colours.onSurfaceVariantLight,
    faintFg: _Colours.outlineLight,
  );

  factory dark() => MyTextThemeExt._make(
    primary: _Colours.primaryDark,
    onSurface: _Colours.onSurfaceDark,
    onSurfaceVariant: _Colours.onSurfaceVariantDark,
    faintFg: _Colours.outlineDark,
  );

  factory adwLight() => MyTextThemeExt._make(
    primary: _AdwColours.accentLight,
    onSurface: _AdwColours.windowFgLight,
    onSurfaceVariant: _AdwColours.dark3,
    faintFg: _AdwColours.dark1,
  );

  factory adwDark() => MyTextThemeExt._make(
    primary: _AdwColours.accentDark,
    onSurface: _AdwColours.windowFgDark,
    onSurfaceVariant: _AdwColours.light2,
    faintFg: _AdwColours.light3,
  );

  new _make({
    required Color primary,
    required Color onSurface,
    required Color onSurfaceVariant,
    required Color faintFg,
  }) : sectionTitle = TextStyle(
         fontFamily: "Roboto",
         fontSize: 16,
         letterSpacing: 0.15,
         fontWeight: .w700,
         color: primary,
       ),
       dialogTitle = TextStyle(fontFamily: "Roboto", fontSize: 20, fontWeight: .w500, color: onSurface),
       listItemSubtitle = TextStyle(fontFamily: "Roboto", fontSize: 14, color: onSurfaceVariant),
       faintLabelMedium = TextStyle(
         fontFamily: "Roboto",
         fontSize: 12,
         letterSpacing: 0.5,
         fontWeight: .w500,
         color: faintFg,
       ),
       faintLabelSmall = TextStyle(
         fontFamily: "Roboto",
         fontSize: 11,
         letterSpacing: 0.5,
         fontWeight: .w500,
         color: faintFg,
       ),
       paragraphText = TextStyle(fontFamily: "Roboto", fontSize: 14, color: onSurface, height: 1.8),
       paragraphTextItalic = TextStyle(
         fontFamily: "Roboto",
         fontSize: 14,
         color: primary,
         height: 1.8,
         fontStyle: .italic,
       ),
       numericBody = TextStyle(
         fontFamily: "Roboto",
         fontSize: 14,
         color: onSurface,
         fontFeatures: _fontFeaturesNumeric,
       ),
       numericTitle = TextStyle(
         fontFamily: "Roboto",
         fontSize: 16,
         letterSpacing: 0.15,
         fontWeight: .w700,
         color: onSurfaceVariant,
         fontFeatures: _fontFeaturesNumeric,
       ),
       numericLarge = TextStyle(
         fontFamily: "Roboto",
         fontSize: 22,
         color: onSurfaceVariant,
         fontWeight: .w700,
         fontFeatures: _fontFeaturesNumeric,
       ),
       numericMedium = TextStyle(
         fontFamily: "Roboto",
         fontSize: 18,
         letterSpacing: 0.15,
         fontWeight: .w700,
         color: onSurfaceVariant,
         fontFeatures: _fontFeaturesNumeric,
       ),
       link = TextStyle(fontFamily: "Roboto", fontSize: 14, color: primary, height: 1.8);

  static const _fontFeaturesNumeric = <FontFeature>[
    .liningFigures(),
    .proportionalFigures(),
    .ordinalForms(),
  ];
}

final class MyColourThemeExt extends ThemeExtension<MyColourThemeExt> {
  final Brightness brightness;
  final Color barrier;
  final Color cardBackground;
  final Color cardDecor;
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
  final Color tableStrip;
  final Color translucentHighlight;

  new _({
    required this.brightness,
    required this.barrier,
    required this.cardBackground,
    required this.cardDecor,
    required this.cardDivider,
    required this.dialogBackground,
    required this.dialogDivider,
    required this.dialogHeaderDivider,
    required this.faintBorder,
    required this.faintButtonBackground,
    required this.faintButtonForeground,
    required this.faintButtonIcon,
    required this.headerShadow,
    required this.scrollGlow,
    required this.scrollShadow,
    required this.settingItemDivider,
    required this.sheetBackground,
    required this.sheetHeaderDivider,
    required this.tableStrip,
    required this.translucentHighlight,
  });

  Color get platformBarrier => barrier;

  @override
  ThemeExtension<MyColourThemeExt> copyWith() => this;

  @override
  ThemeExtension<MyColourThemeExt> lerp(MyColourThemeExt? other, double t) {
    if (other == null) {
      return this;
    }
    return MyColourThemeExt._(
      brightness: brightness,
      barrier: Color.lerp(barrier, other.barrier, t)!,
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      cardDecor: Color.lerp(cardDecor, other.cardBackground, t)!,
      cardDivider: Color.lerp(cardDivider, other.cardDivider, t)!,
      dialogBackground: Color.lerp(dialogBackground, other.dialogBackground, t)!,
      dialogDivider: Color.lerp(dialogDivider, other.dialogDivider, t)!,
      dialogHeaderDivider: Color.lerp(dialogHeaderDivider, other.dialogHeaderDivider, t)!,
      faintBorder: Color.lerp(faintBorder, other.faintBorder, t)!,
      faintButtonBackground: Color.lerp(faintButtonBackground, other.faintButtonBackground, t)!,
      faintButtonForeground: Color.lerp(faintButtonForeground, other.faintButtonForeground, t)!,
      faintButtonIcon: Color.lerp(faintButtonIcon, other.faintButtonIcon, t)!,
      headerShadow: Color.lerp(headerShadow, other.headerShadow, t)!,
      scrollGlow: Color.lerp(scrollGlow, other.scrollGlow, t)!,
      scrollShadow: Color.lerp(scrollShadow, other.scrollShadow, t)!,
      settingItemDivider: Color.lerp(settingItemDivider, other.settingItemDivider, t)!,
      sheetBackground: Color.lerp(sheetBackground, other.sheetBackground, t)!,
      sheetHeaderDivider: Color.lerp(sheetHeaderDivider, other.sheetHeaderDivider, t)!,
      tableStrip: Color.lerp(tableStrip, other.tableStrip, t)!,
      translucentHighlight: Color.lerp(translucentHighlight, other.translucentHighlight, t)!,
    );
  }

  const new light()
    // onSurface with alpha
    : brightness = .light,
      faintBorder = const Color.fromRGBO(32, 34, 40, 0.05),
      // Color.lerp(_lightScheme.onSurface, _lightScheme.surfaceContainerHigh, 0.9)!,
      faintButtonBackground = const Color(0xFFD1D4D9),
      faintButtonForeground = _Colours.onSurfaceLight,
      faintButtonIcon = _Colours.onSurfaceVariantLight,
      dialogBackground = _Colours.surfaceContainerLight,
      // onSurface with alpha
      dialogDivider = const Color.fromRGBO(32, 34, 38, 0.16),
      sheetBackground = _Colours.surfaceContainerLight,
      cardBackground = _Colours.surfaceContainerLowestLight,
      // onSurface with alpha
      cardDivider = const Color.fromRGBO(32, 34, 38, 0.2),
      // onSurface with alpha
      dialogHeaderDivider = const Color.fromRGBO(32, 34, 38, 0.07),
      // onSurface with alpha
      sheetHeaderDivider = const Color.fromRGBO(32, 34, 38, 0.07),
      // onSurface with alpha
      settingItemDivider = const Color.fromRGBO(32, 34, 38, 0.14),
      translucentHighlight = const Color.fromRGBO(32, 34, 38, 0.1),
      scrollShadow = Colors.black38,
      // primary with alpha
      scrollGlow = const Color.fromRGBO(0, 104, 164, 0.14),
      headerShadow = Colors.black87,
      barrier = const Color(0x70000006),
      cardDecor = _Colours.surfaceContainerHighestLight,
      tableStrip = const Color.fromRGBO(229, 232, 237, 0.7);

  const new dark()
    : brightness = .dark,
      faintBorder = const Color.fromRGBO(225, 230, 236, 0.02),
      // Color.lerp(_darkScheme.onSurface, _darkScheme.surfaceContainerHigh, 0.85)!,
      faintButtonBackground = const Color(0xFF3A3E42),
      faintButtonForeground = _Colours.onSurfaceDark,
      faintButtonIcon = _Colours.onSurfaceVariantDark,
      dialogBackground = _Colours.surfaceContainerHighestDark,
      dialogDivider = const Color.fromRGBO(225, 230, 236, 0.15),
      sheetBackground = _Colours.surfaceBrightDark,
      cardBackground = _Colours.surfaceContainerHighDark,
      cardDivider = const Color.fromRGBO(225, 230, 236, 0.25),
      dialogHeaderDivider = const Color.fromRGBO(225, 230, 236, 0.052),
      sheetHeaderDivider = const Color.fromRGBO(225, 230, 236, 0.05),
      settingItemDivider = _Colours.surfaceDark,
      translucentHighlight = Colors.white12,
      scrollShadow = const Color.fromRGBO(0, 104, 164, 0.32),
      scrollGlow = const Color.fromRGBO(0, 104, 164, 0.32),
      headerShadow = _Colours.primaryLight,
      barrier = const Color.fromRGBO(13, 14, 16, 0.51),
      cardDecor = _AdwColours.dark3,
      tableStrip = const Color.fromRGBO(225, 230, 236, 0.04);

  const new adwLight()
    : brightness = .light,
      // onSurface with alpha
      faintBorder = const Color.fromRGBO(0, 0, 6, 0.07),
      faintButtonBackground = _AdwColours.light3,
      faintButtonForeground = _AdwColours.windowFgLight,
      faintButtonIcon = _AdwColours.dark3,
      dialogBackground = _AdwColours.dialogBgLight,
      // onSurface with alpha
      dialogDivider = const Color.fromRGBO(0, 0, 6, 0.12),
      sheetBackground = _AdwColours.secondarySidebarBgLight,
      cardBackground = _AdwColours.viewBgLight,
      // onSurface with alpha
      cardDivider = const Color.fromRGBO(0, 0, 6, 0.18),
      // onSurface with alpha
      dialogHeaderDivider = const Color.fromRGBO(0, 0, 6, 0.05),
      // onSurface with alpha
      sheetHeaderDivider = const Color.fromRGBO(0, 0, 6, 0.06),
      // onSurface with alpha
      settingItemDivider = const Color.fromRGBO(0, 0, 6, 0.12),
      translucentHighlight = Colors.white24,
      scrollShadow = Colors.black38,
      // primary with alpha
      scrollGlow = const Color.fromRGBO(4, 97, 190, 0.3),
      headerShadow = Colors.black87,
      barrier = Colors.transparent,
      cardDecor = _AdwColours.sidebarBgLight,
      // sidebarBgLight with alpha
      tableStrip = const Color.fromRGBO(235, 235, 237, 0.5);

  const new adwDark()
    : brightness = .light,
      // onSurface with alpha
      faintBorder = const Color.fromRGBO(255, 255, 255, 0.04),
      faintButtonBackground = const Color(0xFF464649),
      faintButtonForeground = _AdwColours.windowFgDark,
      faintButtonIcon = _AdwColours.light2,
      dialogBackground = _AdwColours.dialogBgDark,
      // onSurface with alpha
      dialogDivider = const Color.fromRGBO(255, 255, 255, 0.12),
      sheetBackground = _AdwColours.dialogBgDark,
      cardBackground = const Color(0xFF333337),
      // onSurface with alpha
      cardDivider = const Color.fromRGBO(255, 255, 255, 0.12),
      // onSurface with alpha
      dialogHeaderDivider = const Color.fromRGBO(255, 255, 255, 0.05),
      // onSurface with alpha
      sheetHeaderDivider = const Color.fromRGBO(255, 255, 255, 0.06),
      // onSurface with alpha
      settingItemDivider = const Color.fromRGBO(0, 0, 6, 0.20),
      translucentHighlight = Colors.white24,
      scrollShadow = const Color.fromRGBO(0, 0, 6, 0.25),
      // primary with alpha
      scrollGlow = const Color.fromRGBO(4, 97, 190, 0.3),
      headerShadow = const Color.fromRGBO(0, 0, 6, 1),
      barrier = const Color.fromRGBO(34, 34, 38, 0.4),
      cardDecor = const Color(0xFF49484E),
      tableStrip = const Color.fromRGBO(250, 250, 255, 0.05);
}

final ThemeData _light = ThemeData(
  brightness: .light,
  colorScheme: _lightScheme,
  pageTransitionsTheme: _pageTransitionTheme,
  tooltipTheme: _tooltipTheme,
  useMaterial3: true,
  extensions: <ThemeExtension<dynamic>>[
    MyColourThemeExt.light(),
    MyTextThemeExt.light(),
    MyValueExt.mobile(),
  ],
);

final ThemeData _dark = ThemeData(
  brightness: .dark,
  colorScheme: _darkScheme,
  pageTransitionsTheme: _pageTransitionTheme,
  tooltipTheme: _tooltipTheme,
  useMaterial3: true,
  extensions: <ThemeExtension<dynamic>>[MyColourThemeExt.dark(), MyTextThemeExt.dark(), MyValueExt.mobile()],
);

final ThemeData _desktopLight = ThemeData(
  brightness: .light,
  colorScheme: _adwLightScheme,
  pageTransitionsTheme: _pageTransitionTheme,
  tooltipTheme: _tooltipTheme,
  useMaterial3: true,
  extensions: <ThemeExtension<dynamic>>[
    MyColourThemeExt.adwLight(),
    MyTextThemeExt.adwLight(),
    MyValueExt.desktop(),
  ],
);

final ThemeData _desktopDark = ThemeData(
  brightness: .dark,
  colorScheme: _adwDarkScheme,
  pageTransitionsTheme: _pageTransitionTheme,
  tooltipTheme: _tooltipTheme,
  useMaterial3: true,
  extensions: <ThemeExtension<dynamic>>[
    MyColourThemeExt.adwDark(),
    MyTextThemeExt.adwDark(),
    MyValueExt.desktop(),
  ],
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
  static const secondaryContainerLight = Color(0xFFE3E4E8); // Color(0xFFE2E2E5);
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
  static const surfaceContainerLight = Color(0xFFEDEEF2); // Color(0xFFECEEF2);
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

abstract final class _AdwColours {
  static const destructiveBgLight = Color(0xffe01b24);
  static const destructiveBgDark = Color(0xffc01c28);
  static const destructiveFgLight = Color(0xffffffff);
  static const destructiveFgDark = Color(0xffffffff);
  static const destructiveLight = Color(0xffc30000);
  static const destructiveDark = Color(0xffff938c);

  // Surface?
  static const windowBgLight = Color(0xfffafafb);
  static const windowBgDark = Color(0xff222226);
  static const windowFgLight = Color(0xcc000006);
  static const windowFgDark = Color(0xffffffff);

  // Card?
  static const viewBgLight = Color(0xffffffff);
  static const viewBgDark = Color(0xff1d1d20);
  static const viewFgLight = Color(0xcc000006);
  static const viewFgDark = Color(0xffffffff);

  // Surface Container
  static const sidebarBgLight = Color(0xffebebed);
  static const sidebarBgDark = Color(0xff2e2e32);
  static const sidebarFgLight = Color(0xcc000006);
  static const sidebarFgDark = Color(0xffffffff);

  // Surface Container High
  static const secondarySidebarBgLight = Color(0xfff3f3f5);
  static const secondarySidebarBgDark = Color(0xff28282c);
  static const secondarySidebarFgLight = Color(0xcc000006);
  static const secondarySidebarFgDark = Color(0xffffffff);

  static const dialogBgLight = Color(0xfffafafb);
  static const dialogBgDark = Color(0xff36363a);
  static const dialogFgLight = Color(0xcc000006);
  static const dialogFgDark = Color(0xffffffff);

  static const light1 = Color(0xffffffff);
  // -- Window bg is here --
  static const light2 = Color(0xfff6f5f4);
  static const light3 = Color(0xffdeddda);
  static const light4 = Color(0xffc0bfbc);
  static const light5 = Color(0xff9a9996);

  static const dark1 = Color(0xff77767b);
  static const dark2 = Color(0xff5e5c64);
  static const dark3 = Color(0xff3d3846);
  static const dark4 = Color(0xff241f31);
  // -- Window bg is here --
  static const dark5 = Color(0xff000000);

  static const accentBg = Color(0xff3584e4);
  static const accentFgLight = Color(0xffffffff);
  static const accentFgDark = Color(0xFF124478);
  static const accentLight = Color(0xff0461be);
  static const accentDark = Color(0xff81d0ff);

  static const redBg = Color(0xffe62d42);
  static const onRed = Color(0xffffffff);
  static const redLight = Color(0xffc00023);
  static const redDark = Color(0xffff888c);
}

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

const _adwLightScheme = ColorScheme(
  brightness: Brightness.light,
  primary: _AdwColours.accentLight,
  onPrimary: _AdwColours.accentFgLight,
  primaryContainer: _AdwColours.accentBg,
  onPrimaryContainer: _AdwColours.accentFgLight,
  inversePrimary: _AdwColours.accentDark,
  secondary: _AdwColours.light4,
  onSecondary: _AdwColours.dark5,
  secondaryContainer: Color(0xFFEAEAEC),
  onSecondaryContainer: _AdwColours.dark4,
  tertiary: _AdwColours.redLight,
  onTertiary: _AdwColours.onRed,
  tertiaryContainer: _AdwColours.redBg,
  onTertiaryContainer: _AdwColours.onRed,
  surface: _AdwColours.windowBgLight,
  onSurface: _AdwColours.windowFgLight,
  onSurfaceVariant: _AdwColours.dark3,
  surfaceTint: _AdwColours.accentLight,
  inverseSurface: _AdwColours.windowBgDark,
  onInverseSurface: _AdwColours.windowFgLight,
  error: _AdwColours.destructiveLight,
  onError: _AdwColours.destructiveFgLight,
  errorContainer: _AdwColours.destructiveBgLight,
  onErrorContainer: _AdwColours.destructiveFgLight,
  outline: Color.fromRGBO(0, 0, 6, 0.6),
  outlineVariant: Color.fromRGBO(0, 0, 6, 0.3),
  scrim: _AdwColours.dark5,
  surfaceBright: _AdwColours.viewBgLight,
  surfaceContainer: _AdwColours.viewBgLight,
  surfaceContainerHigh: _AdwColours.secondarySidebarBgLight,
  surfaceContainerHighest: _AdwColours.sidebarBgLight,
  surfaceContainerLow: _AdwColours.light2,
  surfaceContainerLowest: _AdwColours.light1,
  surfaceDim: _AdwColours.light3,
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

const _adwDarkScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: _AdwColours.accentDark,
  onPrimary: _AdwColours.accentFgDark,
  primaryContainer: _AdwColours.accentBg,
  onPrimaryContainer: _AdwColours.accentFgLight,
  inversePrimary: _AdwColours.accentLight,
  secondary: _AdwColours.dark1,
  onSecondary: _AdwColours.light2,
  secondaryContainer: _AdwColours.dark3,
  onSecondaryContainer: _AdwColours.light1,
  tertiary: _AdwColours.redDark,
  onTertiary: _AdwColours.onRed,
  tertiaryContainer: _AdwColours.redBg,
  onTertiaryContainer: _AdwColours.onRed,
  surface: _AdwColours.windowBgDark,
  onSurface: _AdwColours.windowFgDark,
  onSurfaceVariant: _AdwColours.light3,
  surfaceTint: _AdwColours.accentDark,
  inverseSurface: _AdwColours.windowBgDark,
  onInverseSurface: _AdwColours.windowFgDark,
  error: _AdwColours.destructiveDark,
  onError: _AdwColours.destructiveFgDark,
  errorContainer: _AdwColours.destructiveBgDark,
  onErrorContainer: _AdwColours.destructiveFgDark,
  outline: Color.fromRGBO(255, 255, 255, 0.6),
  outlineVariant: Color.fromRGBO(255, 255, 255, 0.4),
  scrim: _AdwColours.dark5,
  surfaceBright: _AdwColours.viewBgDark,
  surfaceContainer: _AdwColours.viewBgDark,
  surfaceContainerHigh: _AdwColours.sidebarBgDark,
  surfaceContainerHighest: _AdwColours.secondarySidebarBgDark,
  surfaceContainerLow: Color.fromRGBO(48, 48, 52, 1),
  surfaceContainerLowest: Color.fromRGBO(56, 56, 60, 1),
  surfaceDim: _AdwColours.dark5,
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
