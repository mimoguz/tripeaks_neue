import 'package:flutter/material.dart';
import 'package:tripeaks_neue/stores/data/card_value.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:mobx/mobx.dart';

part "session.g.dart";

// ignore: library_private_types_in_public_api
class Session extends _Session with _$Session {
  Session(super.game, super.layout, {super.startEmpty, super.showAll});

  factory Session.fresh() {
    final layout = Peaks.baseGame;
    final startEmpty = false;
    final game = _Session._makeRandomGame(layout, startEmpty);
    return Session(game, layout, startEmpty: startEmpty);
  }
}

abstract class _Session with Store {
  _Session(Game game, this.layout, {this.startEmpty = false, this.showAll = false}) : _game = game;

  @readonly
  Game _game;

  @observable
  Peaks layout;

  @observable
  bool startEmpty;

  @observable
  bool showAll;

  @action
  void newGame() {
    final next = _makeRandomGame(layout, startEmpty);
    for (final tile in next.board) {
      tile.hide();
    }
    _game = next;
    _setupBoard();
  }

  static Game _makeRandomGame(Peaks layout, bool startEmpty) {
    final layoutObj = switch (layout) {
      Peaks.baseGame => baseGameLayout,
    };

    Game make() {
      final deck = getDeck()..shuffle();
      return Game.usingDeck(deck, layout: layoutObj, startsEmpty: startEmpty);
    }

    for (var i = 0; i < 10; i++) {
      final game = make();
      if (!game.isEnded) {
        return game;
      }
    }

    return make();
  }

  void _setupBoard() async {
    for (final tile in _game.board) {
      tile.show();
      await Future.delayed(_boardAnimDelay);
    }
  }

  static const Duration _boardAnimDelay = Duration(milliseconds: 16);
}
