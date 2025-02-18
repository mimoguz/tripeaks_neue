import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';

final class PlayerStatistics {
  PlayerStatistics.empty()
    : overallStatistics = Statistics.empty(),
      perLayoutStatistics = Map.unmodifiable(<Peaks, Statistics>{});

  PlayerStatistics._({required this.overallStatistics, required this.perLayoutStatistics});

  final Statistics overallStatistics;
  final Map<Peaks, Statistics> perLayoutStatistics;

  PlayerStatistics withGame(SingleGameStatistics game) {
    if (game.isSame(overallStatistics.lastGame)) {
      return this;
    }

    final updatedOverallStatistics = overallStatistics.withGame(game);
    final updatedLayoutStatistics = (perLayoutStatistics[game.layout] ?? Statistics.empty()).withGame(game);
    final updatedPerLayoutStatistics = Map<Peaks, Statistics>.fromEntries(perLayoutStatistics.entries);
    updatedPerLayoutStatistics[game.layout] = updatedLayoutStatistics;

    return PlayerStatistics._(
      overallStatistics: updatedOverallStatistics,
      perLayoutStatistics: Map.unmodifiable(updatedPerLayoutStatistics),
    );
  }
}

final class Statistics {
  Statistics({
    required this.totalGames,
    required this.cleared,
    required this.lastGame,
    required List<SingleGameStatistics> bestGames,
  }) : bestGames = List.unmodifiable(bestGames.take(10));

  Statistics.empty()
    : totalGames = 0,
      cleared = 0,
      lastGame = null,
      bestGames = List<SingleGameStatistics>.unmodifiable([]);

  Statistics._({
    required this.totalGames,
    required this.cleared,
    required this.lastGame,
    required this.bestGames,
  });

  final int totalGames;
  final int cleared;
  final SingleGameStatistics? lastGame;
  final List<SingleGameStatistics> bestGames;

  Statistics withGame(SingleGameStatistics game) {
    if (game.isSame(lastGame)) {
      return this;
    }

    final updatedBestGames = List<SingleGameStatistics>.unmodifiable(
      (bestGames.toList()
            ..add(game)
            ..sort((a, b) {
              final scoreOrder = b.score.compareTo(a.score);
              if (scoreOrder != 0) {
                return scoreOrder;
              }
              return b.ended.compareTo(a.ended);
            }))
          .take(10),
    );

    return Statistics._(
      totalGames: totalGames + 1,
      cleared: cleared + (game.isCleared ? 1 : 0),
      lastGame: game,
      bestGames: updatedBestGames,
    );
  }
}
