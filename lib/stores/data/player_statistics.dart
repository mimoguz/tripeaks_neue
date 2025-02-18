import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';

final class PlayerStatistics {
  PlayerStatistics({
    required this.totalGames,
    required this.cleared,
    required this.lastGame,
    required List<SingleGameStatistics> best,
  }) : bestGames = List.unmodifiable(best.take(10));

  final int totalGames;
  final int cleared;
  final SingleGameStatistics? lastGame;
  final List<SingleGameStatistics> bestGames;

  PlayerStatistics withGame(SingleGameStatistics game) {
    if (game.areSameGame(lastGame)) {
      return this;
    }
    final games = <SingleGameStatistics>[for (final g in bestGames) g, game]
      ..sort((a, b) => b.score.compareTo(a.score));

    return PlayerStatistics(
      totalGames: totalGames + 1,
      cleared: cleared + (game.isCleared ? 1 : 0),
      lastGame: game,
      best: games,
    );
  }
}
