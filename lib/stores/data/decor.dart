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
  red(background: Color(0xfff44336), foreground: Color(0x30ffcdd2), controlForeground: Color(0xffffcdd2)),
  orange(background: Color(0xffff8000), foreground: Color(0x30fffca0), controlForeground: Color(0xffffe0b2)),
  amber(background: Color(0xffffa000), foreground: Color(0x30fff9c4), controlForeground: Color(0xffffecb3)),
  green(background: Color(0xff4caf50), foreground: Color(0x30c8e6c9), controlForeground: Color(0xffc8e6c9)),
  cyan(background: Color(0xff04c4dd), foreground: Color(0x45d3f4f8), controlForeground: Color(0xffb2ebf2)),
  blue(background: Color(0xff2196f3), foreground: Color(0x30b3e5fc), controlForeground: Color(0xffb3e5fc)),
  violet(background: Color(0xff8806ce), foreground: Color(0x30fdd0ff), controlForeground: Color(0xffe1bee7));

  const DecorColour({required this.background, required this.foreground, required this.controlForeground});

  final Color background;
  final Color foreground;
  final Color controlForeground;

  String label(AppLocalizations s) => switch (this) {
    DecorColour.red => s.redColourLabel,
    DecorColour.orange => s.orangeColourLabel,
    DecorColour.amber => s.amberColourLabel,
    DecorColour.cyan => s.cyanColourLabel,
    DecorColour.green => s.greenColourLabel,
    DecorColour.blue => s.blueColourLabel,
    DecorColour.violet => s.violetColourLabel,
  };
}
