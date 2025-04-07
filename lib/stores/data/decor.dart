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
  itsKnot(250),
  neue(400),
  solar(600);
  // organic(500);
  // lazySuzan(800),
  // roundabout(300),

  final int value;

  const Decor(this.value);

  static Decor? fromValue(int value) =>
      values.firstWhere((it) => it.value == value, orElse: () => values.first);
}

extension DecorExt on Decor {
  IconData get icon => switch (this) {
    Decor.checkered => CustomIcons.backCheckered,
    Decor.dotMatrix => CustomIcons.backDotMatrix,
    Decor.ennui => CustomIcons.backEnnui,
    Decor.itsKnot => CustomIcons.backItsKnot,
    Decor.neue => CustomIcons.backNeue,
    Decor.solar => CustomIcons.backSolar,
  };

  String name(AppLocalizations s) => switch (this) {
    Decor.checkered => s.checkeredDecorLabel,
    Decor.dotMatrix => s.dotMatrixDecorLabel,
    Decor.ennui => s.ennuiDecorLabel,
    Decor.itsKnot => s.itsKnotDecorLabel,
    Decor.neue => s.neueDecorLabel,
    Decor.solar => s.solarDecorLabel,
  };
}

enum DecorColour {
  red(Colors.red, Color(0xffffdcd0)),
  green(Colors.green, Color(0xf0dcffd0)),
  blue(Colors.blue, Color(0xffd0dcff)),
  yellow(Colors.yellow, Color(0xffa08010));

  const DecorColour(this.value, this.over);
  final MaterialColor value;
  final Color over;

  Color get lightBackground => value.shade500;
  Color get lightForeground => value.shade400;

  Color get darkBackground => value.shade300;
  Color get darkForeground => value.shade200;

  String name(AppLocalizations s) => switch (this) {
    DecorColour.red => "Red",
    DecorColour.green => "Green",
    DecorColour.blue => "Blue",
    DecorColour.yellow => "Yellow",
  };
}
