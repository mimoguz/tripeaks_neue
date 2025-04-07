// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Settings on _Settings, Store {
  late final _$themeModeAtom =
      Atom(name: '_Settings.themeMode', context: context);

  @override
  ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$decorAtom = Atom(name: '_Settings.decor', context: context);

  @override
  Decor get decor {
    _$decorAtom.reportRead();
    return super.decor;
  }

  @override
  set decor(Decor value) {
    _$decorAtom.reportWrite(value, super.decor, () {
      super.decor = value;
    });
  }

  late final _$decorColourAtom =
      Atom(name: '_Settings.decorColour', context: context);

  @override
  DecorColour get decorColour {
    _$decorColourAtom.reportRead();
    return super.decorColour;
  }

  @override
  set decorColour(DecorColour value) {
    _$decorColourAtom.reportWrite(value, super.decorColour, () {
      super.decorColour = value;
    });
  }

  late final _$_soundOnAtom =
      Atom(name: '_Settings._soundOn', context: context);

  bool get soundOn {
    _$_soundOnAtom.reportRead();
    return super._soundOn;
  }

  @override
  bool get _soundOn => soundOn;

  @override
  set _soundOn(bool value) {
    _$_soundOnAtom.reportWrite(value, super._soundOn, () {
      super._soundOn = value;
    });
  }

  late final _$_soundsAtom = Atom(name: '_Settings._sounds', context: context);

  SoundEffects get sounds {
    _$_soundsAtom.reportRead();
    return super._sounds;
  }

  @override
  SoundEffects get _sounds => sounds;

  @override
  set _sounds(SoundEffects value) {
    _$_soundsAtom.reportWrite(value, super._sounds, () {
      super._sounds = value;
    });
  }

  late final _$_firstRunAtom =
      Atom(name: '_Settings._firstRun', context: context);

  bool get firstRun {
    _$_firstRunAtom.reportRead();
    return super._firstRun;
  }

  @override
  bool get _firstRun => firstRun;

  @override
  set _firstRun(bool value) {
    _$_firstRunAtom.reportWrite(value, super._firstRun, () {
      super._firstRun = value;
    });
  }

  late final _$_SettingsActionController =
      ActionController(name: '_Settings', context: context);

  @override
  void ran() {
    final _$actionInfo =
        _$_SettingsActionController.startAction(name: '_Settings.ran');
    try {
      return super.ran();
    } finally {
      _$_SettingsActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSoundOn(bool value) {
    final _$actionInfo =
        _$_SettingsActionController.startAction(name: '_Settings.setSoundOn');
    try {
      return super.setSoundOn(value);
    } finally {
      _$_SettingsActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
themeMode: ${themeMode},
decor: ${decor},
decorColour: ${decorColour}
    ''';
  }
}
