import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart';
import 'package:tripeaks_neue/stores/data/card_value.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:tripeaks_neue/stores/tile.dart';

void main() {
  test("Rebuilding game", () {
    void run(Layout layout) {
      final game = Game.usingDeck(getDeck()..shuffle(), layout: layout);
      final gameCloned = _deepClone(game);
      for (int i = 0; i < 10; i++) {
        _autoPlay(game);
      }

      final gameRebuilt = game.rebuild();
      assert(_boardsEqual(gameRebuilt, gameCloned));
      assert(_stacksEqual(gameRebuilt.stock, gameCloned.stock));
      assert(_stacksEqual(gameRebuilt.discard, gameCloned.discard));
      expect(gameRebuilt.score, gameCloned.score);
      expect(gameRebuilt.chain, gameCloned.chain);
      expect(gameRebuilt.remaining, gameCloned.remaining);
    }

    for (int i = 0; i < 3; i++) {
      for (final layout in Peaks.values) {
        run(layout.implementation);
      }
    }
  });
}

Game _deepClone(Game source) => Game.fromJsonObject(source.toJsonObject());

void _autoPlay(Game game) {
  for (final tile in game.board) {
    if (tile.isVisible &&
        tile.isOpen &&
        (game.discard.isEmpty || game.discard.last.card.checkAdjacent(tile.card))) {
      game.take(tile.pin);
      return;
    }
  }
  game.draw();
}

bool _boardsEqual(Game game1, Game game2) {
  for (var i = 0; i < game1.board.length; i++) {
    final tile1 = game1.board[i];
    final tile2 = game2.board[i];
    if (tile1.card != tile2.card) {
      return false;
    }
    if (tile1.isOpen != tile2.isOpen) {
      return false;
    }
    if (tile1.isVisible != tile2.isVisible) {
      return false;
    }
  }
  return true;
}

bool _stacksEqual(List<Tile> stack1, List<Tile> stack2) {
  if (stack1.length != stack2.length) {
    return false;
  }
  for (var i = 0; i < stack1.length; i++) {
    if (stack1[i].card != stack2[i].card) {
      return false;
    }
  }
  return true;
}
