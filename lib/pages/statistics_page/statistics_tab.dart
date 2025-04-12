import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/statistics_page/game_entry.dart';
import 'package:tripeaks_neue/pages/statistics_page/summary.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/group_title.dart';
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
                  GroupTitle(s.statisticsSummary, isFirst: true),
                  Summary(statistics),
                  if (statistics.lastGame != null) GroupTitle(s.lastGameStatistics),
                  if (statistics.lastGame != null)
                    GroupTile(
                      children: [GameEntry(place: -1, game: statistics.lastGame!, showLayout: showLayout)],
                    ),
                  if (statistics.bestGames.isNotEmpty) GroupTitle(s.bestGamesStatistics),
                  if (statistics.bestGames.isNotEmpty)
                    GroupTile(
                      children: [
                        for (final (index, game) in statistics.bestGames.indexed)
                          GameEntry(place: index + 1, game: game, showLayout: showLayout),
                      ],
                    ),
                  const SizedBox(height: c.utilPageMargin),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
