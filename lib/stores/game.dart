import 'dart:math';

import 'package:logger/logger.dart';
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

  factory Game.usingDeck(
    List<CardValue> deck, {
    Layout? layout,
    bool startsEmpty = false,
    bool ensureSolvable = false,
  }) {
    assert(deck.length == 52);
    final lo = layout ?? threePeaksLayout;
    final useDeck = ensureSolvable ? _makeSolvable(deck, lo) : deck;
    final board =
        lo.pins.map((pin) {
          final tile = Tile(pin: pin, card: useDeck.removeLast());
          if (pin.startsOpen) {
            tile.open();
          }
          return tile;
        }).toList();
    final discard = startsEmpty ? <Tile>[] : <Tile>[Tile(card: useDeck.removeLast(), pin: Pin.unpin)];
    final stock = useDeck.map((card) => Tile(card: card, pin: Pin.unpin)).toList();
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

  // Algorithm developed by https://github.com/Lykae
  static List<CardValue> _makeSolvable(List<CardValue> deck, Layout lo) {
    var rng = Random();
    List<CardValue> stockDeck = [];

    // create moves
    var stockPadding = 5;
    var maxStockMoves = deck.length - lo.pins.length;
    var numStockMoves = stockPadding + rng.nextInt(maxStockMoves - stockPadding * 2);
    var countStockMoves = numStockMoves;
    double directionChances = 0.99;
    var goUpChance = 0.8;
    var maxMoves = lo.pins.length + numStockMoves;
    List<CardValue> moves = [deck.removeLast()];
    bool initialDirection = rng.nextDouble() <= 0.5;
    bool direction = initialDirection;
    for (var i = 1; i < maxMoves; i++) {
      var lastNode = moves[moves.length - 1];
      direction =
          direction
              ? (initialDirection
                  ? rng.nextDouble() <= directionChances
                  : rng.nextDouble() >= directionChances)
              : initialDirection;
      var possibleNextMoves = deck.where((x) => lastNode.checkAdjacentFromDirection(x, direction)).toList();
      if (possibleNextMoves.isEmpty) {
        direction = !direction;
        possibleNextMoves = deck.where((x) => lastNode.checkAdjacentFromDirection(x, direction)).toList();
      }
      CardValue nextMove;
      if (possibleNextMoves.isEmpty) {
        numStockMoves -= maxMoves - i;
        countStockMoves = numStockMoves;
        maxMoves = moves.length;
        break;
      } else if (possibleNextMoves.length == 1) {
        nextMove = possibleNextMoves[0];
      } else {
        var rIdx = rng.nextInt(possibleNextMoves.length);
        nextMove = possibleNextMoves[rIdx];
      }
      moves.add(nextMove);
      deck.removeWhere((x) => x.rank == nextMove.rank && x.suit == nextMove.suit);
    }

    // build pins and stock
    Map<int, CardValue> pinMap = {};
    var maxMainAxis = 0;
    for (var x in lo.pins) {
      if (x.mainAxis > maxMainAxis) {
        maxMainAxis = x.mainAxis;
      }
    }

    maxMoves = moves.length;
    var rdmStockPadding = rng.nextInt(stockPadding);
    var stockInterval = (maxMoves - rdmStockPadding) / numStockMoves;

    for (var i = 0; i < maxMoves; i++) {
      List<int> possibleTargets = [];
      if (i != 0 && countStockMoves > 0) {
        if (i >= ((numStockMoves - countStockMoves + 1) * stockInterval) + rdmStockPadding ||
            countStockMoves == maxMoves - i) {
          stockDeck.add(moves.removeLast());
          countStockMoves--;
          continue;
        }
      }
      var bottomUncompletedMainAxis = 0;
      Map<int, bool> mainAxisCompletedMap = {};
      for (var j = 0; j < lo.pins.length; j++) {
        if (pinMap[j] != null) {
          continue;
        }
        bool unlocked = true;
        loop:
        for (var tileAbove in lo.above[j]) {
          if (pinMap[tileAbove] == null) {
            unlocked = false;
            break loop;
          }
        }

        mainAxisCompletedMap[lo.pins[j].mainAxis] = false;

        if (unlocked) {
          possibleTargets.add(j);
        }
      }

      for (var i = 0; i <= maxMainAxis; i++) {
        var row = mainAxisCompletedMap[i];
        if (row != null) {
          if (!row) {
            bottomUncompletedMainAxis = i;
            break;
          }
        }
      }

      if (i != 0) {
        if (rng.nextDouble() <= goUpChance) {
          var goUpTargets =
              possibleTargets.where((x) => lo.pins[x].mainAxis > bottomUncompletedMainAxis).toList();
          if (goUpTargets.isNotEmpty) {
            possibleTargets = goUpTargets;
          }
        }
      }
      var targetIdx = rng.nextInt(possibleTargets.length);
      var target = possibleTargets[targetIdx];
      pinMap[target] = moves.removeLast();
    }

    // construct deck
    List<CardValue> newDeck = [];
    var stockIdxs = [];
    var randomStockIdxs = [];
    for (var i = 0; i < maxStockMoves; i++) {
      stockIdxs.add(i);
    }
    stockIdxs = stockIdxs..shuffle();
    for (var i = 0; i < stockDeck.length; i++) {
      randomStockIdxs.add(stockIdxs[i]);
    }
    for (var i = 0; i < maxStockMoves; i++) {
      if (randomStockIdxs.contains(i)) {
        newDeck.add(stockDeck.removeLast());
      } else {
        var temp = deck.removeLast();
        newDeck.add(temp);
      }
    }
    for (var pin in pinMap.keys.toList().reversed.toList()) {
      newDeck.add(pinMap[pin]!);
    }
    return newDeck;
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

    final currentScore = _score;
    final currentChain = _chain;

    _remaining--;
    _chain++;

    if (_remaining == 0) {
      _isCleared = true;
      _isEnded = true;
      // Clearing the game obviously ends a chain, so you get a score
      // Also a bonus for the number of cards of the current layout
      _score += _chain * _chain + layout.cardCount;
      history.add(Event(pin: pin, score: currentScore, chain: currentChain));
      _logger.d("Take. Chain: $_chain, Score: $_score");
      return true;
    }

    if (stock.isEmpty && !_checkMoves(board: board, stock: stock, discard: discard)) {
      _score += _chain * _chain;
      _isEnded = true;
      _isCleared = false;
      _isStalled = true;
    }

    history.add(Event(pin: pin, score: currentScore, chain: currentChain));
    _logger.d("Take. Chain: $_chain, Score: $_score");
    return true;
  }

  @action
  void draw() {
    if (stock.isEmpty) {
      return;
    }

    isPlayed = true;

    // You only get a score when a chain is completed
    history.add(Event(pin: Pin.unpin, score: _score, chain: _chain));
    _score += _chain * _chain;
    _chain = 0;

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

    _logger.d("Draw. Chain: $_chain, Score: $_score");
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

    _score = event.score;
    _chain = event.chain;
    _logger.d("Rollback. Chain: $_chain, Score: $_score");

    if (event.pin.index >= 0) {
      board[event.pin.index].put();
      _remaining++;
      _closeBelow(event.pin);
      return;
    }

    stock.add(
      Tile(card: card, pin: Pin.unpin)
        ..put()
        ..close(),
    );
  }

  @action
  void forfeit() {
    if (_isCleared) {
      return;
    }
    _isEnded = true;
    _isStalled = true;
    _score += _chain * _chain;
    _chain = 0;
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

  static final _logger = Logger();
}

// TODO: Log history progression during a game and check if it looks correct.
final class Event {
  Event({required this.pin, required this.score, required this.chain});

  final Pin pin;
  final int score;
  final int chain;

  JsonObject toJsonObject() => {"pin": pin.index, "score": score, "chain": chain};

  factory Event.fromJsonObject(Map<String, dynamic> jsonObject, Layout layout) {
    final pinIndex = jsonObject.read<int>("pin");
    final pin = pinIndex < 0 ? Pin.unpin : layout.pins[pinIndex];
    final score = jsonObject["score"] as int;
    final chain = jsonObject["chain"] as int;
    return Event(pin: pin, score: score, chain: chain);
  }
}
