import 'package:tripeaks_neue/stores/data/card_value.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:mobx/mobx.dart';

part "session.g.dart";

// ignore: library_private_types_in_public_api
class Session extends _Session with _$Session {
  Session(super.game, super.layout, {super.startEmpty, super.showAll, required super.statistics});

  factory Session.fresh() {
    final layout = Peaks.threePeaks;
    final startEmpty = false;
    final game = _Session._makeRandomGame(layout, startEmpty);
    return Session(game, layout, startEmpty: startEmpty, statistics: PlayerStatistics.empty());
  }
}

abstract class _Session with Store {
  _Session(
    Game game,
    this.layout, {
    required PlayerStatistics statistics,
    this.startEmpty = false,
    this.showAll = false,
  }) : _statistics = statistics,
       _game = game {
    whenCleared = when(
      (_) => _game.isCleared,
      () => _statistics = _statistics.withGame(SingleGameStatistics.of(game)),
    );
  }

  @readonly
  Game _game;

  @observable
  Peaks layout;

  @observable
  bool startEmpty;

  @observable
  bool showAll;

  @readonly
  PlayerStatistics _statistics;

  ReactionDisposer? whenCleared;

  @action
  void newGame() {
    final next = _makeRandomGame(layout, startEmpty);
    for (final tile in next.board) {
      tile.hide();
    }

    // TODO: Detect if played
    if (!_game.isCleared) {
      _statistics = _statistics.withGame(SingleGameStatistics.of(_game));
    }

    whenCleared = when(
      (_) => next.isCleared,
      () => _statistics = _statistics.withGame(SingleGameStatistics.of(next)),
    );
    _game = next;
    _setupBoard(next);
  }

  @action
  void restart() {
    final next = _game.rebuid();
    for (final tile in next.board) {
      tile.hide();
    }

    if (!_game.isCleared) {
      _statistics = _statistics.withGame(SingleGameStatistics.of(_game));
    }

    whenCleared = when(
      (_) => next.isCleared,
      () => _statistics = _statistics.withGame(SingleGameStatistics.of(next)),
    );

    _game = next;
    _setupBoard(next);
  }

  static Game _makeRandomGame(Peaks layout, bool startEmpty) {
    final layoutObj = layout.implementation;

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

  void _setupBoard(Game next) async {
    for (final tile in _game.board) {
      tile.show();
      await Future.delayed(_addAnimDelay);
    }
  }

  static const Duration _addAnimDelay = Duration(milliseconds: 16);
}
