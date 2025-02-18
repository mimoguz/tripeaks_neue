import 'package:tripeaks_neue/stores/game.dart';

final class SingleGameStatistics {
  const SingleGameStatistics({
    required this.score,
    required this.isCleared,
    required this.started,
    required this.ended,
  });

  SingleGameStatistics.of(Game game)
    : score = game.score,
      isCleared = game.isCleared,
      ended = DateTime.now(),
      started = game.started;

  final int score;
  final bool isCleared;
  final DateTime ended;
  final DateTime started;

  bool areSameGame(SingleGameStatistics? other) =>
      other is SingleGameStatistics && started.isAtSameMomentAs(other.started);

  @override
  bool operator ==(Object other) =>
      other is SingleGameStatistics &&
      score == other.score &&
      isCleared == other.isCleared &&
      ended.isAtSameMomentAs(other.ended);

  @override
  int get hashCode => ((score << 1) | (isCleared ? 1 : 0)) ^ ended.microsecondsSinceEpoch;
}
