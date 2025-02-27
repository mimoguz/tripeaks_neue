import 'dart:math';

import 'package:tripeaks_neue/stores/data/card_value.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/pin.dart';
import 'package:tripeaks_neue/stores/tile.dart';
import 'package:mobx/mobx.dart';
import 'package:tripeaks_neue/util/json_object.dart';

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
    required super.chain,
    required super.isPlayed,
    required super.statisticsPushed,
  });

  factory Game.usingDeck(List<CardValue> deck, {Layout? layout, bool startsEmpty = false}) {
    assert(deck.length == 52);
    final lo = layout ?? threePeaksLayout;
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
    final isStalled = !_Game._checkMoves(board: board, stock: stock, discard: discard);

    return Game._(
      layout: lo,
      board: ObservableList.of(board),
      stock: ObservableList.of(stock),
      discard: ObservableList.of(discard),
      history: ObservableList<Event>(),
      started: DateTime.now(),
      startsEmpty: startsEmpty,
      isCleared: false,
      isStalled: isStalled,
      isEnded: isStalled,
      score: 0,
      remaining: lo.cardCount,
      chain: 0,
      isPlayed: false,
      statisticsPushed: false,
    );
  }

  JsonObject toJsonObject() {
    final boardJson = board.map((it) => it.toJsonObject()).toList();
    final stockJson = stock.map((it) => it.toJsonObject()).toList();
    final discardJson = discard.map((it) => it.toJsonObject()).toList();
    final historyJson = history.map((it) => it.toJsonObject()).toList();
    return <String, dynamic>{
      "layout": layout.tag.index,
      "board": boardJson,
      "stock": stockJson,
      "discard": discardJson,
      "history": historyJson,
      "startsEmpty": startsEmpty,
      "isCleared": isCleared,
      "isStalled": isStalled,
      "isEnded": isEnded,
      "score": score,
      "chain": chain,
      "remaining": remaining,
      "started": started.toIso8601String(),
      "isPlayed": isPlayed,
      "statisticsPushed": statisticsPushed,
    };
  }

  factory Game.fromJsonObject(JsonObject jsonObject) {
    final layout = Peaks.values[jsonObject["layout"] as int].implementation;
    final board = jsonObject.read<List<dynamic>>("board").map((it) => Tile.fromJsonObject(it, layout));
    final stock = jsonObject.read<List<dynamic>>("stock").map((it) => Tile.fromJsonObject(it, layout));
    final discard = jsonObject.read<List<dynamic>>("discard").map((it) => Tile.fromJsonObject(it, layout));
    final history = jsonObject.read<List<dynamic>>("history").map((it) => Event.fromJsonObject(it, layout));
    final started = jsonObject.readDate("started");
    return Game._(
      layout: layout,
      board: ObservableList.of(board),
      stock: ObservableList.of(stock),
      discard: ObservableList.of(discard),
      history: ObservableList.of(history),
      started: started,
      startsEmpty: jsonObject.read<bool>("startsEmpty"),
      isCleared: jsonObject.read<bool>("isCleared"),
      isStalled: jsonObject.read<bool>("isStalled"),
      isEnded: jsonObject.read<bool>("isEnded"),
      score: jsonObject.read<int>("score"),
      remaining: jsonObject.read<int>("remaining"),
      chain: jsonObject.read<int>("chain"),
      isPlayed: jsonObject.read<bool>("isPlayed"),
      statisticsPushed: jsonObject.read<bool>("statisticsPushed"),
    );
  }
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
    required this.isPlayed,
    required this.statisticsPushed,
    required bool isCleared,
    required bool isStalled,
    required bool isEnded,
    required int score,
    required int remaining,
    required int chain,
  }) : _isCleared = isCleared,
       _isStalled = isStalled,
       _isEnded = isEnded,
       _score = score,
       _remaining = remaining,
       _chain = chain;

  final Layout layout;

  ObservableList<Tile> board;

  ObservableList<Tile> stock;

  ObservableList<Tile> discard;

  ObservableList<Event> history;

  bool startsEmpty;

  bool isPlayed;

  bool statisticsPushed;

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

  @readonly
  int _chain;

  @action
  bool take(Pin pin) {
    final tile = board[pin.index];
    final canTake = tile.isVisible && (discard.isEmpty || discard.last.card.checkAdjacent(tile.card));

    if (!canTake) {
      tile.lastError = DateTime.now();
      return false;
    }

    isPlayed = true;

    board[pin.index].take();
    discard.add(Tile(card: tile.card, pin: Pin.unpin));
    _openBelow(pin);

    _remaining--;
    _chain++;

    if (_remaining == 0) {
      _isCleared = true;
      _isEnded = true;
      // Clearing the game obviously ends a chain, so you get a score
      // Also a bonus for the number of cards of the current layout
      final chainScore = _chain * _chain + layout.cardCount;
      _score += chainScore;
      history.add(Event(pin, chainScore));
      return true;
    }

    if (stock.isEmpty && !_checkMoves(board: board, stock: stock, discard: discard)) {
      final chainScore = _chain * _chain;
      history.add(Event(pin, chainScore));
      _score += chainScore;
      _isEnded = true;
      _isCleared = false;
      _isStalled = true;
      return true;
    }

    history.add(Event(pin, 0));
    return true;
  }

  @action
  void draw() {
    if (stock.isEmpty) {
      return;
    }

    isPlayed = true;

    // You only get a score when a chain is completed
    final chainScore = _chain * _chain;
    _score += chainScore;
    _chain = 0;
    history.add(Event(Pin.unpin, chainScore));

    discard.add(
      stock.removeLast()
        ..open()
        ..put(),
    );

    if (stock.isEmpty) {
      final top = discard.last.card;
      final hasMoves = board.any((tile) => tile.isVisible && tile.isOpen && tile.card.checkAdjacent(top));
      _isStalled = !hasMoves;
      _isEnded = _isStalled;
    }
  }

  @action
  void rollback() {
    if (history.isEmpty) {
      return;
    }

    _isEnded = false;
    _isStalled = false;

    final event = history.removeLast();
    final card = discard.removeLast().card;

    _score -= event.score;

    if (event.pin.index >= 0) {
      board[event.pin.index].put();
      _remaining++;
      _chain = max(0, _chain - 1);
      _closeBelow(event.pin);
      return;
    }

    _chain = 0;
    stock.add(
      Tile(card: card, pin: Pin.unpin)
        ..put()
        ..close(),
    );
  }

  Game rebuild() {
    final reBoard =
        board.map((it) {
          final reTile = it.clone();
          if (reTile.pin.startsOpen) {
            reTile.open();
          }
          return reTile;
        }).toList();
    final reStock = stock.map((it) => it.clone()).toList();
    final reDiscard = discard.map((it) => it.clone()).toList();
    for (final event in history.reversed) {
      final reTile = reDiscard.removeLast();
      if (event.pin.index <= 0) {
        reStock.add(
          reTile
            ..put()
            ..close(),
        );
      }
    }
    final isStalled = !_checkMoves(board: reBoard, stock: reStock, discard: reDiscard);
    return Game._(
      layout: layout,
      board: ObservableList.of(reBoard),
      stock: ObservableList.of(reStock),
      discard: ObservableList.of(reDiscard),
      history: ObservableList<Event>(),
      started: DateTime.now(),
      startsEmpty: startsEmpty,
      isCleared: false,
      isStalled: isStalled,
      isEnded: false,
      score: 0,
      remaining: layout.cardCount,
      chain: 0,
      isPlayed: false,
      statisticsPushed: false,
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

  static bool _checkMoves({
    required List<Tile> board,
    required List<Tile> stock,
    required List<Tile> discard,
  }) {
    bool check(Tile ref) {
      if (discard.isNotEmpty && discard.last.card.checkAdjacent(ref.card)) {
        return true;
      }
      for (final tile in stock) {
        if (tile.card.checkAdjacent(ref.card)) {
          return true;
        }
      }
      return false;
    }

    for (final tile in board) {
      if (tile.isVisible && tile.isOpen && check(tile)) {
        return true;
      }
    }

    return false;
  }
}

final class Event {
  Event(this.pin, this.score);

  final Pin pin;
  final int score;

  JsonObject toJsonObject() => {"pin": pin.index, "score": score};

  factory Event.fromJsonObject(Map<String, dynamic> jsonObject, Layout layout) {
    final pinIndex = jsonObject.read<int>("pin");
    final pin = pinIndex < 0 ? Pin.unpin : layout.pins[pinIndex];
    final score = jsonObject["score"] as int;
    return Event(pin, score);
  }
}
