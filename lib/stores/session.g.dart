// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Session on _Session, Store {
  late final _$_gameAtom = Atom(name: '_Session._game', context: context);

  Game get game {
    _$_gameAtom.reportRead();
    return super._game;
  }

  @override
  Game get _game => game;

  @override
  set _game(Game value) {
    _$_gameAtom.reportWrite(value, super._game, () {
      super._game = value;
    });
  }

  late final _$layoutAtom = Atom(name: '_Session.layout', context: context);

  @override
  Peaks get layout {
    _$layoutAtom.reportRead();
    return super.layout;
  }

  @override
  set layout(Peaks value) {
    _$layoutAtom.reportWrite(value, super.layout, () {
      super.layout = value;
    });
  }

  late final _$startEmptyAtom =
      Atom(name: '_Session.startEmpty', context: context);

  @override
  bool get startEmpty {
    _$startEmptyAtom.reportRead();
    return super.startEmpty;
  }

  @override
  set startEmpty(bool value) {
    _$startEmptyAtom.reportWrite(value, super.startEmpty, () {
      super.startEmpty = value;
    });
  }

  late final _$showAllAtom = Atom(name: '_Session.showAll', context: context);

  @override
  bool get showAll {
    _$showAllAtom.reportRead();
    return super.showAll;
  }

  @override
  set showAll(bool value) {
    _$showAllAtom.reportWrite(value, super.showAll, () {
      super.showAll = value;
    });
  }

  late final _$_statisticsAtom =
      Atom(name: '_Session._statistics', context: context);

  PlayerStatistics get statistics {
    _$_statisticsAtom.reportRead();
    return super._statistics;
  }

  @override
  PlayerStatistics get _statistics => statistics;

  @override
  set _statistics(PlayerStatistics value) {
    _$_statisticsAtom.reportWrite(value, super._statistics, () {
      super._statistics = value;
    });
  }

  late final _$_SessionActionController =
      ActionController(name: '_Session', context: context);

  @override
  void newGame(Future<void> Function() callback) {
    final _$actionInfo =
        _$_SessionActionController.startAction(name: '_Session.newGame');
    try {
      return super.newGame(callback);
    } finally {
      _$_SessionActionController.endAction(_$actionInfo);
    }
  }

  @override
  void restart(Future<void> Function() callback) {
    final _$actionInfo =
        _$_SessionActionController.startAction(name: '_Session.restart');
    try {
      return super.restart(callback);
    } finally {
      _$_SessionActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
layout: ${layout},
startEmpty: ${startEmpty},
showAll: ${showAll}
    ''';
  }
}
