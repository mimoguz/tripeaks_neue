import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

class const ResultChip(final SingleGameStatistics game, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    final fill = game.isCleared ? DecorColour.green.background : colours.secondary;
    final s = context.strings;
    return Container(
      decoration: BoxDecoration(color: fill, borderRadius: const BorderRadius.all(Radius.circular(100.0))),
      width: 100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 1.0),
        child: Text(
          game.isCleared ? s.gameClearedLabel : s.gameNotClearedLabel,
          textAlign: .center,
          style: TextStyle(fontSize: 12, color: colours.onSecondary),
        ),
      ),
    );
  }
}
