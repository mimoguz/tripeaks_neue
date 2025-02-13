import 'package:tripeaks_neue/stores/data/card_value.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/pin.dart';
import 'package:tripeaks_neue/stores/tile.dart';
import 'package:mobx/mobx.dart';

part "game.g.dart";

// ignore: library_private_types_in_public_api
class Game extends _Game with _$Game {
  Game._({
    required super.layout,
    required super.board,
    required super.stock,
    required super.discard,
    required super.history,
    required super.started,
    required super.startsEmpty,
    required super.isCleared,
    required super.isStalled,
    required super.isEnded,
    required super.score,
    required super.remaining,
  });

  factory Game.usingDeck(List<CardValue> deck, {Layout? layout, bool startsEmpty = false}) {
    assert(deck.length == 52);
    final lo = layout ?? baseGameLayout;
    final board =
        lo.pins.map((pin) {
          final tile = Tile(pin: pin, card: deck.removeLast());
          if (pin.startsOpen) {
            tile.open();
          }
          return tile;
        }).toList();
    final discard = startsEmpty ? <Tile>[] : <Tile>[Tile(card: deck.removeLast(), pin: Pin.unpin)];
    final stock = deck.map((card) => Tile(card: card, pin: Pin.unpin)).toList();
    final isStalled = !_checkMoves(board: board, stock: stock, discard: discard);

    return Game._(
      layout: lo,
      board: ObservableList.of(board),
      stock: ObservableList.of(stock),
      discard: ObservableList.of(discard),
      history: ObservableList<Pin>(),
      started: DateTime.now(),
      startsEmpty: startsEmpty,
      isCleared: false,
      isStalled: isStalled,
      isEnded: isStalled,
      score: 0,
      remaining: lo.cardCount,
    );
  }

  static bool _checkMoves({
    required List<Tile> board,
    required List<Tile> stock,
    required List<Tile> discard,
  }) => true;
}

abstract class _Game with Store {
  _Game({
    required this.layout,
    required this.board,
    required this.stock,
    required this.discard,
    required this.history,
    required this.startsEmpty,
    required this.started,
    required bool isCleared,
    required bool isStalled,
    required bool isEnded,
    required int score,
    required int remaining,
  }) : _isCleared = isCleared,
       _isStalled = isStalled,
       _isEnded = isEnded,
       _score = score,
       _remaining = remaining;

  final Layout layout;

  ObservableList<Tile> board;

  ObservableList<Tile> stock;

  ObservableList<Tile> discard;

  ObservableList<Pin> history;

  bool startsEmpty;

  bool justCleared = false;

  bool justStalled = false;

  final DateTime started;

  @readonly
  bool _isCleared;

  @readonly
  bool _isStalled;

  @readonly
  bool _isEnded;

  @readonly
  int _score;

  @readonly
  int _remaining;

  @action
  void take(Pin pin) {
    final tile = board[pin.index];
    final canTake = tile.isVisible && (discard.isEmpty || discard.last.card.checkAdjacent(tile.card));

    if (!canTake) {
      tile.lastError = DateTime.now();
      return;
    }

    board[pin.index].take();
    discard.add(Tile(card: tile.card, pin: Pin.unpin));
    _openBelow(pin);

    _remaining--;
    history.add(pin);

    if (_remaining == 0) {
      _isCleared = true;
      _isEnded = true;
      justCleared = true;
    }
  }

  @action
  void draw() {
    if (stock.isEmpty) {
      return;
    }

    discard.add(
      stock.removeLast()
        ..open()
        ..put(),
    );
    history.add(Pin.unpin);

    if (stock.isEmpty) {
      final top = discard.last.card;
      final hasMoves = board.any((tile) => tile.card.checkAdjacent(top));
      _isStalled = !hasMoves;
      _isEnded = _isStalled;
      if (_isStalled) {
        justStalled = true;
      }
    }
  }

  @action
  void rollback() {
    if (history.isEmpty) {
      return;
    }

    _isEnded = false;
    _isStalled = false;
    justStalled = false;

    final pin = history.removeLast();
    final card = discard.removeLast().card;

    if (pin.index >= 0) {
      board[pin.index].put();
      _remaining++;
      _closeBelow(pin);
      return;
    }

    stock.add(
      Tile(card: card, pin: Pin.unpin)
        ..put()
        ..close(),
    );
  }

  void _openBelow(Pin pin) {
    final below = layout.below[pin.index];
    for (final i in below) {
      final blocking = layout.above[i];
      if (blocking.every((j) => !board[j].isVisible)) {
        board[i]
          ..put()
          ..open();
      }
    }
  }

  void _closeBelow(Pin pin) {
    final below = layout.below[pin.index];
    for (final i in below) {
      board[i]
        ..put()
        ..close();
    }
  }
}
