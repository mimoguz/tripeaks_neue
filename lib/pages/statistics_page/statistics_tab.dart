import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/statistics_page/result_chip.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
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
    final theme = Theme.of(context);
    final colours = theme.colorScheme;
    final s = AppLocalizations.of(context)!;
    final best = statistics.bestGames;
    final last = statistics.lastGame;
    final indexStyle = theme.textTheme.labelLarge?.copyWith(color: colours.onSurfaceVariant);
    final scoreStyle = theme.textTheme.titleLarge?.copyWith(
      fontWeight: .w800,
      color: colours.onSurfaceVariant,
    );
    final titleStyle = theme.textTheme.titleLarge?.copyWith(color: colours.onSurfaceVariant);
    final tilePadding = const EdgeInsets.fromLTRB(28, 0, 0, c.cellPadding);
    final divColour = colours.onSurface.withAlpha(60);
    return Column(
      children: [
        Expanded(
          child: Container(
            color: colours.surfaceContainerLow,
            child: ScrollIndicator(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(c.itemSpacing),
                  child: GroupTile(
                    children: <Widget>[
                      Row(
                        spacing: c.itemSpacing,
                        mainAxisSize: .min,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: StatChip(
                                        title: s.totalPlayedLabel,
                                        value: statistics.totalGames,
                                      ),
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
                                    theme.brightness == .dark
                                        ? "images/stats_icon_dark.png"
                                        : "images/stats_icon_light.png",
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
                                      child: StatChip(
                                        title: s.longestChainLabel,
                                        value: statistics.longestChain,
                                      ),
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
                      ),
                      if (statistics.lastGame != null) Container(height: 1, color: divColour),
                      if (last != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: c.itemSpacing + 10, top: c.itemSpacing + 6),
                          child: Column(
                            crossAxisAlignment: .stretch,
                            children: [
                              Row(
                                mainAxisAlignment: .center,
                                children: [Text(s.lastGameStatistics, style: titleStyle)],
                              ),
                              SizedBox(height: c.cellPadding),
                              Row(
                                mainAxisAlignment: .center,
                                children: [
                                  Text(
                                    "${last.layout.label(s)} - ${_dateFormat.format(last.ended)}",
                                    style: theme.textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              SizedBox(height: c.cellPadding),
                              Row(
                                mainAxisAlignment: .center,
                                children: [Text("${last.score}", style: scoreStyle)],
                              ),
                              Row(mainAxisAlignment: .center, children: [ResultChip(last)]),
                            ],
                          ),
                        ),
                      if (best.isNotEmpty) Container(height: 1, color: divColour),
                      if (best.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: c.itemSpacing + 6, bottom: c.itemSpacing),
                          child: Row(
                            mainAxisAlignment: .center,
                            children: [Text(s.bestGamesStatistics, style: titleStyle)],
                          ),
                        ),
                      if (best.isNotEmpty)
                        for (final (index, game) in best.indexed)
                          Column(
                            mainAxisSize: .min,
                            spacing: 0,
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 28, child: Text("${index + 1}", style: indexStyle)),
                                  Expanded(child: Container(height: 1, color: divColour)),
                                ],
                              ),
                              ListTile(
                                minLeadingWidth: 44,
                                contentPadding: tilePadding,
                                trailing: Column(
                                  mainAxisSize: .min,
                                  crossAxisAlignment: .center,
                                  children: [
                                    Text(game.score.toString(), style: scoreStyle),
                                    ResultChip(game),
                                  ],
                                ),
                                title: Text(game.layout.label(s)),
                                subtitle: Text(_dateFormat.format(game.ended)),
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static final _dateFormat = DateFormat("d MMMM y, HH:mm");
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
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .center,
            children: [
              Text(
                value.toString(),
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onSurface,
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
