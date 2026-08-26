import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/statistics_page/pie.dart';
import 'package:tripeaks_neue/pages/statistics_page/result_chip.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

const _leadingWidth = 22.0;
const _verticalSpacing = 20.0;
final _dateFormat = DateFormat("d MMMM y, HH:mm");

// TODO: This is just a mess, clean-up a little
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
    final subtitleStyle = theme.textTheme.titleMedium?.copyWith(color: colours.primary);
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
                        Padding(
                          padding: const EdgeInsets.only(top: _verticalSpacing),
                          child: OverallStatsDisplay(statistics),
                        ),
                        if (last != null)
                          Padding(
                            padding: const EdgeInsets.only(top: _verticalSpacing),
                            child: Row(
                              spacing: c.itemSpacing,
                              children: [
                                Text(s.lastGameStatistics, style: subtitleStyle),
                                Expanded(child: Container(height: 1, color: divColour)),
                              ],
                            ),
                          ),
                        if (last != null) LastGameEntry(last, showLayout: showLayout),
                        if (best.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: _verticalSpacing),
                            child: Row(
                              spacing: c.itemSpacing,
                              children: [
                                Text(s.bestGamesStatistics, style: subtitleStyle),
                                Expanded(child: Container(color: divColour, height: 1)),
                              ],
                            ),
                          ),
                        if (best.isNotEmpty)
                          for (final (index, game) in best.indexed)
                            ScoreboardEntry(game: game, place: index + 1, showLayout: showLayout),
                        SizedBox(height: _verticalSpacing - (best.isNotEmpty ? 8 : 6)),
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
    final statStyle = theme.textTheme.titleMedium?.copyWith(fontWeight: .w800);
    return Row(
      mainAxisAlignment: .center,
      spacing: 36.0,
      children: <Widget>[
        Pie(total: statistics.totalGames, slice: statistics.cleared),
        Flexible(
          child: Column(
            crossAxisAlignment: .start,
            children: <Widget>[
              Text(s.totalPlayedLabel, style: theme.textTheme.titleSmall, overflow: .fade, softWrap: false),
              Text(statistics.totalGames.toString(), style: statStyle),
              SizedBox(height: c.itemSpacing),
              Text(s.totalClearedLabel, style: theme.textTheme.titleSmall, overflow: .fade, softWrap: false),
              Text(statistics.cleared.toString(), style: statStyle),
            ],
          ),
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: .start,
            children: <Widget>[
              Text(s.bestScoreLabel, style: theme.textTheme.titleSmall, overflow: .fade, softWrap: false),
              Text((statistics.bestGames.firstOrNull?.score ?? 0).toString(), style: statStyle),
              SizedBox(height: c.itemSpacing),
              Text(s.longestChainLabel, style: theme.textTheme.titleSmall, overflow: .fade, softWrap: false),
              Text(statistics.longestChain.toString(), style: statStyle),
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
    return ListTile(
      minLeadingWidth: _leadingWidth,
      minTileHeight: 0.0,
      visualDensity: .compact,
      contentPadding: showLayout
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
      leading: SizedBox(),
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
    );
  }
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
        if (place > 1)
          Row(
            children: [
              Expanded(child: Container(height: 1, color: theme.colorScheme.onSurface.withAlpha(60))),
            ],
          ),
        ListTile(
          minLeadingWidth: _leadingWidth,
          minTileHeight: 0.0,
          visualDensity: .compact,
          contentPadding: showLayout
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
          leading: Text(place.toString(), style: theme.textTheme.labelMedium),
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
}
