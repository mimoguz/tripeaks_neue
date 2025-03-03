import 'package:flutter/material.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';

/// Users of this enum, when they need an ordinal value, should consider using the 'value' property
/// instead of the 'index' property of an enum variant, so that new variants can be added or the existing
/// ones can be removed without disturbing user preferences.
enum Decor {
  checkered(100),
  crosshatch(200),
  gridAligned(250),
  lazySuzan(800),
  neue(400),
  ohRain(300),
  sevenMiles(500),
  solar(600);

  final int value;

  const Decor(this.value);

  static Decor? fromValue(int value) =>
      values.firstWhere((it) => it.value == value, orElse: () => values.first);
}

extension DecorExt on Decor {
  IconData get icon => switch (this) {
    Decor.checkered => CustomIcons.backCheckered,
    Decor.crosshatch => CustomIcons.backCrossHatch,
    Decor.gridAligned => CustomIcons.gridAligned,
    Decor.lazySuzan => CustomIcons.backLazySuzan,
    Decor.neue => CustomIcons.backNeue,
    Decor.ohRain => CustomIcons.backOhRain,
    Decor.sevenMiles => CustomIcons.backSevenMiles,
    Decor.solar => CustomIcons.backSolar,
  };

  String name(AppLocalizations s) => switch (this) {
    Decor.checkered => s.checkeredDecorLabel, // s.checkered,
    Decor.crosshatch => s.crosshatchDecorLabel, // s.crosshatch,
    Decor.gridAligned => s.gridAlignedDecorLabel, // s.gridAligned,
    Decor.lazySuzan => s.lazySuzanDecorLabel, // s.lazySuzan,
    Decor.neue => s.neueDecorLabel, // s.neue,
    Decor.ohRain => s.ohRainDecorLabel, // s.ohRain,
    Decor.sevenMiles => s.sevenMilesDecorLabel, // s.sevenMiles,
    Decor.solar => s.solarDecorLabel, // s.solar,
  };
}
