import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';

part 'settings.g.dart';

class Settings extends _Settings with _$Settings {
  Settings() : super._(ThemeMode.system, Decor.values.first);
}

abstract class _Settings with Store {
  _Settings._(this.themeMode, this.decor);

  @observable
  ThemeMode themeMode;

  @observable
  Decor decor;
}

/// Users of this enum, when they need an ordinal value, should consider using the 'value' property
/// instead of the 'index' property of an enum variant, so that new variants can be added or the existing
/// ones can be removed without disturbing user preferences.
enum Decor {
  checkered(100),
  crosshatch(200),
  ohRain(300),
  neue(400),
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
    Decor.neue => CustomIcons.backNeue,
    Decor.ohRain => CustomIcons.backOhRain,
    Decor.sevenMiles => CustomIcons.backSevenMiles,
    Decor.solar => CustomIcons.backSolar,
  };
}
