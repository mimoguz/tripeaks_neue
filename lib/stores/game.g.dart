// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Game on _Game, Store {
  late final _$_isClearedAtom =
      Atom(name: '_Game._isCleared', context: context);

  bool get isCleared {
    _$_isClearedAtom.reportRead();
    return super._isCleared;
  }

  @override
  bool get _isCleared => isCleared;

  @override
  set _isCleared(bool value) {
    _$_isClearedAtom.reportWrite(value, super._isCleared, () {
      super._isCleared = value;
    });
  }

  late final _$_isStalledAtom =
      Atom(name: '_Game._isStalled', context: context);

  bool get isStalled {
    _$_isStalledAtom.reportRead();
    return super._isStalled;
  }

  @override
  bool get _isStalled => isStalled;

  @override
  set _isStalled(bool value) {
    _$_isStalledAtom.reportWrite(value, super._isStalled, () {
      super._isStalled = value;
    });
  }

  late final _$_isEndedAtom = Atom(name: '_Game._isEnded', context: context);

  bool get isEnded {
    _$_isEndedAtom.reportRead();
    return super._isEnded;
  }

  @override
  bool get _isEnded => isEnded;

  @override
  set _isEnded(bool value) {
    _$_isEndedAtom.reportWrite(value, super._isEnded, () {
      super._isEnded = value;
    });
  }

  late final _$_scoreAtom = Atom(name: '_Game._score', context: context);

  int get score {
    _$_scoreAtom.reportRead();
    return super._score;
  }

  @override
  int get _score => score;

  @override
  set _score(int value) {
    _$_scoreAtom.reportWrite(value, super._score, () {
      super._score = value;
    });
  }

  late final _$_remainingAtom =
      Atom(name: '_Game._remaining', context: context);

  int get remaining {
    _$_remainingAtom.reportRead();
    return super._remaining;
  }

  @override
  int get _remaining => remaining;

  @override
  set _remaining(int value) {
    _$_remainingAtom.reportWrite(value, super._remaining, () {
      super._remaining = value;
    });
  }

  late final _$_chainAtom = Atom(name: '_Game._chain', context: context);

  int get chain {
    _$_chainAtom.reportRead();
    return super._chain;
  }

  @override
  int get _chain => chain;

  @override
  set _chain(int value) {
    _$_chainAtom.reportWrite(value, super._chain, () {
      super._chain = value;
    });
  }

  late final _$_GameActionController =
      ActionController(name: '_Game', context: context);

  @override
  void take(Pin pin) {
    final _$actionInfo =
        _$_GameActionController.startAction(name: '_Game.take');
    try {
      return super.take(pin);
    } finally {
      _$_GameActionController.endAction(_$actionInfo);
    }
  }

  @override
  void draw() {
    final _$actionInfo =
        _$_GameActionController.startAction(name: '_Game.draw');
    try {
      return super.draw();
    } finally {
      _$_GameActionController.endAction(_$actionInfo);
    }
  }

  @override
  void rollback() {
    final _$actionInfo =
        _$_GameActionController.startAction(name: '_Game.rollback');
    try {
      return super.rollback();
    } finally {
      _$_GameActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
