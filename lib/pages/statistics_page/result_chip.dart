import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

final class const ResultChip(final SingleGameStatistics game, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    final fill = game.isCleared ? DecorColour.green.background : colours.secondary;
    final s = context.strings;
    return Container(
      decoration: BoxDecoration(color: fill, borderRadius: const BorderRadius.all(Radius.circular(100.0))),
      width: 100,
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 1.0),
      child: Text(
        game.isCleared ? s.gameClearedLabel : s.gameNotClearedLabel,
        textAlign: .center,
        style: TextStyle(fontSize: 12, color: colours.onSecondary),
      ),
    );
  }
}

final class const ResultChipCompact(final bool isCleared, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    final fill = isCleared ? DecorColour.green.background : colours.secondary;
    return Container(
      decoration: BoxDecoration(color: fill, shape: BoxShape.circle),
      width: 18,
      height: 18,
      padding: EdgeInsets.all(2.0),
      child: Icon(
        isCleared ? CustomIcons.check12 : CustomIcons.cross12,
        size: 12,
        color: colours.onSecondary,
        semanticLabel: isCleared ? "Cleared" : "Not cleared",
      ),
    );
  }
}
