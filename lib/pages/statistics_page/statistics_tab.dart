import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/statistics_page/game_entry.dart';
import 'package:tripeaks_neue/pages/statistics_page/stats_group.dart';
import 'package:tripeaks_neue/pages/statistics_page/summary.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';

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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0), child: Summary(statistics)),
                  if (statistics.lastGame != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      child: StatGroup(
                        title: s.lastGameStatistics,
                        child: GameEntry(place: -1, game: statistics.lastGame!, showLayout: showLayout),
                      ),
                    ),
                  if (statistics.bestGames.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                      child: StatGroup(
                        title: s.bestGamesStatistics,
                        child: Column(
                          children: [
                            for (final (index, game) in statistics.bestGames.indexed)
                              GameEntry(place: index + 1, game: game, showLayout: showLayout),
                          ],
                        ),
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
