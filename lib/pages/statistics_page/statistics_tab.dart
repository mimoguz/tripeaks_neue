import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/statistics_page/game_entry.dart';
import 'package:tripeaks_neue/pages/statistics_page/summary.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

final class StatisticsTab extends StatelessWidget {
  const StatisticsTab(this.statistics, {super.key, this.showLayout = true});

  final Statistics statistics;
  final bool showLayout;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final s = AppLocalizations.of(context)!;
    return Container(
      color: colours.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: ScrollIndicator(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      c.utilPageMargin,
                      c.utilPageMargin,
                      c.utilPageMargin,
                      c.utilPageMargin / 2.0,
                    ),
                    child: Summary(statistics),
                  ),
                  if (statistics.lastGame != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: c.utilPageMargin,
                        vertical: c.utilPageMargin / 2.0,
                      ),
                      child: GroupTile(
                        title: s.lastGameStatistics,
                        children: [GameEntry(place: -1, game: statistics.lastGame!, showLayout: showLayout)],
                      ),
                    ),
                  if (statistics.bestGames.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        c.utilPageMargin,
                        c.utilPageMargin / 2.0,
                        c.utilPageMargin,
                        c.utilPageMargin,
                      ),
                      child: GroupTile(
                        title: s.bestGamesStatistics,
                        children: [
                          for (final (index, game) in statistics.bestGames.indexed)
                            GameEntry(place: index + 1, game: game, showLayout: showLayout),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
