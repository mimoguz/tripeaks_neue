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
  red(
    darkBackground: Color(0xffe53935),
    darkForeground: Color(0x30ffcdd2),
    darkControlForeground: Color(0xffffcdd2),
    lightBackground: Color(0xffe53935),
    lightForeground: Color(0xf0ef9a9a),
    lightControlForeground: Color(0xffef9a9a),
  ),
  green(
    darkBackground: Color(0xff4caf50),
    darkForeground: Color(0x30c8e6c9),
    darkControlForeground: Color(0xffc8e6c9),
    lightBackground: Color(0xff4caf50),
    lightForeground: Color(0xf0c8e6c9),
    lightControlForeground: Color(0xffc8e6c9),
  ),
  blue(
    darkBackground: Color(0xff2196f3),
    darkForeground: Color(0x30b3e5fc),
    darkControlForeground: Color(0xffb3e5fc),
    lightBackground: Color(0xff2196f3),
    lightForeground: Color(0xf0b3e5fc),
    lightControlForeground: Color(0xffb3e5fc),
  ),
  yellow(
    darkBackground: Color(0xffffeb3b),
    darkForeground: Color(0x30fff9c4),
    darkControlForeground: Color(0xffff8f00),
    lightBackground: Color(0xffffeb3b),
    lightForeground: Color(0xf0fff9c4),
    lightControlForeground: Color(0xffff6f00),
  );

  const DecorColour({
    required this.darkBackground,
    required this.darkForeground,
    required this.darkControlForeground,
    required this.lightBackground,
    required this.lightForeground,
    required this.lightControlForeground,
  });

  final Color darkBackground;
  final Color darkForeground;
  final Color darkControlForeground;

  final Color lightBackground;
  final Color lightForeground;
  final Color lightControlForeground;

  String name(AppLocalizations s) => switch (this) {
    DecorColour.red => "Red",
    DecorColour.green => "Green",
    DecorColour.blue => "Blue",
    DecorColour.yellow => "Yellow",
  };
}
