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

  late final _$_SettingsActionController =
      ActionController(name: '_Settings', context: context);

  @override
  void setDecor(Decor value) {
    final _$actionInfo =
        _$_SettingsActionController.startAction(name: '_Settings.setDecor');
    try {
      return super.setDecor(value);
    } finally {
      _$_SettingsActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
themeMode: ${themeMode},
decor: ${decor}
    ''';
  }
}
