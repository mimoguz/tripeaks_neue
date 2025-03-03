import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/sound_effects.dart';
import 'package:tripeaks_neue/util/io.dart';
import 'package:tripeaks_neue/util/json_object.dart';

part 'settings.g.dart';

class Settings extends _Settings with _$Settings {
  Settings() : super._(ThemeMode.system, Decor.values.first, true, SoundOn());

  Settings.fromJsonObject(JsonObject jsonObject)
    : super._(
        ThemeMode.values[jsonObject.read<int>("themeMode")],
        Decor.values[jsonObject.read<int>("decor")],
        jsonObject.read<bool>("soundOn"),
        jsonObject.read<bool>("soundOn") ? SoundOn() : Silent(),
      );

  static Future<Settings> read() async =>
      await IO.read("settings", (it) => Settings.fromJsonObject(it)) ?? Settings();

  JsonObject toJsonObject() => {"themeMode": themeMode.index, "decor": decor.index, "soundOn": _soundOn};

  Future<void> write() async => await IO.write("settings", toJsonObject());
}

abstract class _Settings with Store {
  _Settings._(this.themeMode, this.decor, this._soundOn, this._sounds);

  @observable
  ThemeMode themeMode;

  @observable
  Decor decor;

  @readonly
  bool _soundOn;

  @readonly
  SoundEffects _sounds;

  @action
  void setSoundOn(bool value) {
    _soundOn = value;
    _sounds = value ? SoundOn() : Silent();
    _sounds.load();
  }

  void dispose() => _sounds.dispose();
}
