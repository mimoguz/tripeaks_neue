import 'package:flutter/material.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';

/// Users of this enum, when they need an ordinal value, should consider using the 'value' property
/// instead of the 'index' property of an enum variant, so that new variants can be added or the existing
/// ones can be removed without disturbing user preferences.
enum Decor {
  checkered(100),
  dotMatrix(250),
  ennui(200),
  lazySuzan(800),
  neue(400),
  organic(500),
  roundabout(300),
  solar(600);

  final int value;

  const Decor(this.value);

  static Decor? fromValue(int value) =>
      values.firstWhere((it) => it.value == value, orElse: () => values.first);
}

extension DecorExt on Decor {
  IconData get icon => switch (this) {
    Decor.checkered => CustomIcons.backCheckered,
    Decor.dotMatrix => CustomIcons.backGridAligned,
    Decor.ennui => CustomIcons.backEnnui,
    Decor.lazySuzan => CustomIcons.backLazySuzan,
    Decor.neue => CustomIcons.backNeue,
    Decor.organic => CustomIcons.backSevenMiles,
    Decor.roundabout => CustomIcons.backFanConvetion,
    Decor.solar => CustomIcons.backSolar,
  };

  String name(AppLocalizations s) => switch (this) {
    Decor.checkered => s.checkeredDecorLabel,
    Decor.dotMatrix => s.dotMatrixDecorLabel,
    Decor.ennui => s.ennuiDecorLabel,
    Decor.lazySuzan => s.lazySuzanDecorLabel,
    Decor.neue => s.neueDecorLabel,
    Decor.organic => s.organicDecorLabel,
    Decor.roundabout => s.roundaboutDecorLabel,
    Decor.solar => s.solarDecorLabel,
  };
}
