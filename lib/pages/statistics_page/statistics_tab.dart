import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/statistics_page/result_chip.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

final class StatisticsTab extends StatelessWidget {
  const StatisticsTab(this.statistics, {super.key, this.showLayout = true});

  final Statistics statistics;
  final bool showLayout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colours = theme.colorScheme;
    final s = AppLocalizations.of(context)!;
    final best = statistics.bestGames;
    final last = statistics.lastGame;
    final divColour = colours.onSurface.withAlpha(60);
    return Column(
      children: [
        Expanded(
          child: Container(
            color: colours.surfaceContainerLow,
            child: ScrollIndicator(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(c.utilPageMargin),
                    child: GroupTile(
                      children: <Widget>[
                        OverallStatsDisplay(statistics),
                        if (last != null) Container(height: 1, color: divColour),
                        if (last != null) LastGameEntry(last, showLayout: showLayout),
                        if (best.isNotEmpty) Container(height: 1, color: divColour),
                        if (best.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: c.itemSpacing, bottom: c.itemSpacing - 6),
                            child: Row(
                              mainAxisAlignment: .center,
                              children: [Text(s.bestGamesStatistics, style: theme.textTheme.titleLarge)],
                            ),
                          ),
                        if (best.isNotEmpty)
                          for (final (index, game) in best.indexed)
                            ScoreboardEntry(game: game, place: index + 1, showLayout: showLayout),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class OverallStatsDisplay extends StatelessWidget {
  const OverallStatsDisplay(this.statistics, {super.key});

  final Statistics statistics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = AppLocalizations.of(context)!;
    return Row(
      spacing: c.itemSpacing,
      mainAxisSize: .min,
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: StatChip(title: s.totalPlayedLabel, value: statistics.totalGames),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: StatChip(title: s.totalClearedLabel, value: statistics.cleared),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: [
            Row(
              children: [
                Image.asset(
                  theme.brightness == .dark ? "images/stats_icon_dark.png" : "images/stats_icon_light.png",
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: StatChip(title: s.longestChainLabel, value: statistics.longestChain),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: StatChip(
                      title: s.bestScoreLabel,
                      value: statistics.bestGames.firstOrNull?.score ?? 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class LastGameEntry extends StatelessWidget {
  const LastGameEntry(this.game, {super.key, required this.showLayout});

  final SingleGameStatistics game;
  final bool showLayout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.only(bottom: c.itemSpacing, top: c.itemSpacing - 4),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            mainAxisAlignment: .center,
            children: [Text(s.lastGameStatistics, style: theme.textTheme.titleLarge)],
          ),
          SizedBox(height: c.itemSpacing),
          Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                "${showLayout ? "${game.layout.label(s)} - " : ""}${_dateFormat.format(game.ended)}",
                style: theme.textTheme.titleMedium,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                "${game.score}",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: .w800,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: 2),
          Row(mainAxisAlignment: .center, children: [ResultChip(game)]),
        ],
      ),
    );
  }

  static final _dateFormat = DateFormat("d MMMM y, HH:mm");
}

class ScoreboardEntry extends StatelessWidget {
  const ScoreboardEntry({super.key, required this.game, required this.place, required this.showLayout});

  final SingleGameStatistics game;
  final int place;
  final bool showLayout;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: .min,
      spacing: 0,
      children: [
        Row(
          children: [
            SizedBox(
              width: _left,
              child: Text(place.toString(), style: theme.textTheme.labelMedium),
            ),
            Expanded(child: Container(height: 1, color: theme.colorScheme.onSurface.withAlpha(60))),
          ],
        ),
        ListTile(
          minLeadingWidth: 44.0,
          minTileHeight: 0.0,
          visualDensity: .compact,
          contentPadding: showLayout
              ? const EdgeInsets.only(left: _left)
              : const EdgeInsets.fromLTRB(_left, c.cellPadding, 0, c.cellPadding),
          trailing: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .center,
            children: [
              Text(
                game.score.toString(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: .w800,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              ResultChip(game),
            ],
          ),
          title: showLayout ? Text(game.layout.label(s)) : Text(_dateFormat.format(game.ended)),
          subtitle: showLayout ? Text(_dateFormat.format(game.ended)) : null,
        ),
      ],
    );
  }

  static final _dateFormat = DateFormat("d MMMM y, HH:mm");
  static const _left = 28.0;
}

class StatChip extends StatelessWidget {
  const StatChip({super.key, required this.title, required this.value});

  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: c.cardPadding,
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Row(
            mainAxisAlignment: .center,
            children: [Text(title, style: theme.textTheme.bodyLarge)],
          ),
          Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                value.toString(),
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: .w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
