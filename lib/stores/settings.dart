import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'settings.g.dart';

class Settings extends _Settings with _$Settings {
  Settings() {
    themeMode = ThemeMode.system;
  }
}

abstract class _Settings with Store {
  @observable
  ThemeMode themeMode = ThemeMode.system;
}
