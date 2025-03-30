import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/sound_effects.dart';
import 'package:tripeaks_neue/util/json_object.dart';
import 'package:tripeaks_neue/util/get_io.dart'
    // ignore: uri_does_not_exist
    if (dart.io) 'package:tripeaks_neue/util/local_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.js_util) 'package:tripeaks_neue/util/web_io.dart';

part 'settings.g.dart';

class Settings extends _Settings with _$Settings {
  Settings()
    : super._(
        themeMode: ThemeMode.system,
        decor: Decor.values.first,
        soundOn: true,
        sounds: SoundOn(),
        firstRun: true,
      );

  Settings.fromJsonObject(JsonObject jsonObject)
    : super._(
        themeMode: ThemeMode.values[jsonObject.read<int>("themeMode")],
        decor: _readDecor(jsonObject),
        soundOn: jsonObject.read<bool>("soundOn"),
        sounds: jsonObject.read<bool>("soundOn") ? SoundOn() : Silent(),
        firstRun: false,
      );

  static Future<Settings> read() async =>
      await getIO().read("settings", (it) => Settings.fromJsonObject(it)) ?? Settings();

  JsonObject toJsonObject() => {"themeMode": themeMode.index, "decor": decor.index, "soundOn": _soundOn};

  Future<void> write() async => await getIO().write("settings", toJsonObject());

  static Decor _readDecor(JsonObject jsonObject) {
    try {
      return Decor.values[jsonObject.read<int>("decor")];
    } on Error {
      return Decor.values.first;
    }
  }
}

abstract class _Settings with Store {
  _Settings._({
    required this.themeMode,
    required this.decor,
    required bool soundOn,
    required SoundEffects sounds,
    required bool firstRun,
  }) : _soundOn = soundOn,
       _sounds = sounds,
       _firstRun = firstRun;

  @observable
  ThemeMode themeMode;

  @observable
  Decor decor;

  @readonly
  bool _soundOn;

  @readonly
  SoundEffects _sounds;

  @readonly
  bool _firstRun;

  @action
  void ran() {
    _firstRun = false;
  }

  @action
  void setSoundOn(bool value) {
    _soundOn = value;
    _sounds = value ? SoundOn() : Silent();
    _sounds.load();
  }

  void dispose() => _sounds.dispose();
}
