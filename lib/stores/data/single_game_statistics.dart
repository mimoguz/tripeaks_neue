import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:tripeaks_neue/util/json_object.dart';

final class SingleGameStatistics {
  const SingleGameStatistics({
    required this.layout,
    required this.score,
    required this.isCleared,
    required this.started,
    required this.ended,
  });

  final Peaks layout;
  final int score;
  final bool isCleared;
  final DateTime ended;
  final DateTime started;

  SingleGameStatistics.of(Game game)
    : layout = game.layout.tag,
      score = game.score,
      isCleared = game.isCleared,
      ended = DateTime.now(),
      started = game.started;

  SingleGameStatistics.fromJsonObject(JsonObject jsonObject)
    : layout = Peaks.values[jsonObject.read<int>("layout")],
      score = jsonObject.read<int>("score"),
      isCleared = jsonObject.read<bool>("isCleared"),
      ended = jsonObject.readDate("ended"),
      started = jsonObject.readDate("started");

  bool isSame(SingleGameStatistics? other) =>
      other is SingleGameStatistics && started.isAtSameMomentAs(other.started);

  @override
  bool operator ==(Object other) =>
      other is SingleGameStatistics &&
      score == other.score &&
      isCleared == other.isCleared &&
      ended.isAtSameMomentAs(other.ended);

  @override
  int get hashCode => ((score << 1) | (isCleared ? 1 : 0)) ^ ended.microsecondsSinceEpoch;

  JsonObject toJsonObject() => {
    "layout": layout.index,
    "score": score,
    "isCleared": isCleared,
    "ended": ended.toIso8601String(),
    "started": started.toIso8601String(),
  };
}
