import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';

class ResultChip extends StatelessWidget {
  const ResultChip(this.game, {super.key});

  final SingleGameStatistics game;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final fill = game.isCleared ? colours.primary : colours.tertiary;
    final text = game.isCleared ? colours.onPrimary : colours.onTertiary;
    final s = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(color: fill, borderRadius: const BorderRadius.all(Radius.circular(100.0))),
      width: 100,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 1.0),
        child: Text(
          game.isCleared ? s.gameClearedLabel : s.gameNotClearedLabel,
          textAlign: .center,
          style: TextStyle(fontSize: 12, color: text),
        ),
      ),
    );
  }
}
