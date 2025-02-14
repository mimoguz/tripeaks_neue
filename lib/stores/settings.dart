import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

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

  @action
  void setDecor(Decor value) => decor = value;
}

/// Users of this enum, when they need an ordinal value, should consider using the 'value' property
/// instead of the 'index' property of an enum variant, so that new variants can be added or the existing
/// ones can be removed without disturbing user preferences.
enum Decor {
  checkered(100),
  crosshatch(200),
  ohRain(300),
  neue(400);

  final int value;

  const Decor(this.value);

  static Decor? fromValue(int value) =>
      values.firstWhere((it) => it.value == value, orElse: () => values.first);
}
