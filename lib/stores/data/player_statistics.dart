import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/util/json_object.dart';

final class PlayerStatistics {
  PlayerStatistics._({required this.overallStatistics, required this.perLayoutStatistics});

  final Statistics overallStatistics;
  final Map<Peaks, Statistics> perLayoutStatistics;

  PlayerStatistics.empty()
    : overallStatistics = Statistics.empty(),
      perLayoutStatistics = Map.unmodifiable(<Peaks, Statistics>{});

  PlayerStatistics.fromJsonObject(Map<String, dynamic> jsonObject)
    : overallStatistics = Statistics.fromJsonObject(jsonObject.read<JsonObject>("overallStatistics")),
      perLayoutStatistics = jsonObject
          .read<JsonObject>("perLayoutStatistics")
          .map(
            (k, v) => MapEntry(Peaks.values.firstWhere((it) => it.name == k), Statistics.fromJsonObject(v)),
          );

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

  JsonObject toJsonObject() => {
    "overallStatistics": overallStatistics.toJsonObject(),
    "perLayoutStatistics": perLayoutStatistics.map((k, v) => MapEntry(k.name, v.toJsonObject())),
  };
}

final class Statistics {
  Statistics({
    required this.totalGames,
    required this.cleared,
    required this.lastGame,
    required List<SingleGameStatistics> bestGames,
  }) : bestGames = List.unmodifiable(bestGames.take(10));
  Statistics._({
    required this.totalGames,
    required this.cleared,
    required this.lastGame,
    required this.bestGames,
  });

  // Statistics.fromJsonObject(Map<String, dynamic> jsonObject)

  final int totalGames;
  final int cleared;
  final SingleGameStatistics? lastGame;
  final List<SingleGameStatistics> bestGames;

  Statistics.empty()
    : totalGames = 0,
      cleared = 0,
      lastGame = null,
      bestGames = List<SingleGameStatistics>.unmodifiable([]);

  Statistics.fromJsonObject(JsonObject jsonObject)
    : totalGames = jsonObject.read<int>("totalGames"),
      cleared = jsonObject.read<int>("cleared"),
      lastGame =
          jsonObject["lastGame"] == null ? null : SingleGameStatistics.fromJsonObject(jsonObject["lastGame"]),
      bestGames =
          jsonObject
              .read<List<dynamic>>("bestGames")
              .map((it) => SingleGameStatistics.fromJsonObject(it))
              .toList();

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

  JsonObject toJsonObject() => {
    "totalGames": totalGames,
    "cleared": cleared,
    "lastGame": lastGame?.toJsonObject(),
    "bestGames": bestGames.map((it) => it.toJsonObject()).toList(),
  };
}
