import 'package:material_ui/material_ui.dart';

const double activeRankSize = 30.0;
const double activeSuitSize = 36.0;
const double buttonSize = 96.0;
const double cardPaddingHorizontal = 14.0;
const double cardPaddingVertical = 10.0;
const double cardSize = 116.0;
const double cellPadding = 4.0;
const double itemSpacing = 16;
const double commonRadius = 16.0;
const double divPadding = 8;
const double dropdownItemWidth = 120;
const double iconScaleThreshold = 0.4;
const double inactiveRankSize = 18.0;
const double inactiveSuitSize = 20.0;
const double maxListWidth = 700;
const double maxRadioWidth = maxListWidth - 32;
const double maxRealButtonSize = 52.0;
const double pagePadding = 24.0;
const double requiredHeight = 600;
const double requiredWidth = 1260;
const double stockShift = 30.0;
const double utilPageMargin = 6.0;
const double dialogPadding = 20;
const double verticalTabsThreshold = 500;
const double radioCorrection = 5.0;
const double checkBoxCorrection = 5.0;

const commonBorderRadius = BorderRadius.all(Radius.circular(commonRadius));

const EdgeInsets cardPadding = EdgeInsets.symmetric(
  horizontal: cardPaddingHorizontal,
  vertical: cardPaddingVertical,
);
const EdgeInsets utilPageInsetsHorizontal = EdgeInsets.symmetric(horizontal: utilPageMargin);
const EdgeInsets utilPageInsets = EdgeInsets.fromLTRB(
  utilPageMargin,
  utilPageMargin,
  utilPageMargin,
  utilPageMargin + 12,
);

const fontFeatures = <FontFeature>[.liningFigures(), .proportionalFigures()];
const faintShadowColour = Color(0x80100000);

abstract final class DialogMetrics {
  static const verticalPadding = 16.0;
  static const horizontalPadding = 20.0;
  static const sectionSpacing = 16.0;

  static const titlePadding = EdgeInsets.fromLTRB(
    horizontalPadding,
    verticalPadding,
    horizontalPadding,
    sectionSpacing,
  );
  static const actionsPadding = EdgeInsets.fromLTRB(
    horizontalPadding,
    sectionSpacing,
    horizontalPadding,
    verticalPadding,
  );
  static const safeActionsPadding = EdgeInsets.fromLTRB(
    horizontalPadding,
    sectionSpacing,
    horizontalPadding,
    verticalPadding + 20.0,
  );
  static const contentPadding = EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: sectionSpacing);
  static const contentPaddingTight = EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 0.0);
  static const bottomSheetContentPadding = EdgeInsets.fromLTRB(
    horizontalPadding,
    verticalPadding,
    horizontalPadding,
    0.0,
  );

  static const subtitlePadding = EdgeInsets.fromLTRB(
    horizontalPadding,
    sectionSpacing,
    horizontalPadding,
    sectionSpacing / 2,
  );
  static const shape = RoundedRectangleBorder(borderRadius: commonBorderRadius);
  static const bottomSheetShape = RoundedRectangleBorder(
    borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(commonRadius)),
  );
}
