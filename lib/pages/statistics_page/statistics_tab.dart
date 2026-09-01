import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/statistics_page/pie.dart';
import 'package:tripeaks_neue/pages/statistics_page/result_chip.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
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
    final divColour = colours.onSurface.withAlpha(50);
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
                        Padding(padding: const EdgeInsets.only(top: 4), child: OverallStats(statistics)),
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
                        SizedBox(height: best.isNotEmpty ? 0 : 4),
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

class OverallStats extends StatelessWidget {
  const OverallStats(this.statistics, {super.key});

  final Statistics statistics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colours = theme.colorScheme;
    final s = AppLocalizations.of(context)!;
    return Stack(
      alignment: .center,
      children: [
        Row(
          spacing: 8.0,
          children: [
            Expanded(
              child: Column(
                spacing: 8.0,
                crossAxisAlignment: .stretch,
                children: [
                  ScoreCard(
                    placement: .topLeft,
                    title: s.totalPlayedLabel,
                    value: statistics.totalGames,
                    background: statistics.totalGames > 0 ? colours.onSurface.withAlpha(50) : null,
                  ),
                  ScoreCard(
                    placement: .bottomLeft,
                    title: s.bestScoreLabel,
                    value: statistics.bestGames.firstOrNull?.score ?? 0,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                spacing: 8.0,
                crossAxisAlignment: .stretch,
                children: [
                  ScoreCard(
                    placement: .topRight,
                    title: s.totalClearedLabel,
                    value: statistics.cleared,
                    background: statistics.cleared > 0 ? DecorColour.green.background : null,
                    foreground: statistics.cleared > 0 ? colours.onSecondary : null,
                  ),
                  ScoreCard(
                    placement: .bottomRight,
                    title: s.longestChainLabel,
                    value: statistics.longestChain,
                  ),
                ],
              ),
            ),
          ],
        ),
        Align(
          alignment: .center,
          child: Container(
            width: 112,
            height: 112,
            decoration: BoxDecoration(color: colours.surfaceContainerHigh, shape: BoxShape.circle),
            child: Pie(total: statistics.totalGames, slice: statistics.cleared, size: 96),
          ),
        ),
      ],
    );
  }
}

class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
    required this.placement,
    required this.title,
    required this.value,
    this.background,
    this.foreground,
  });

  final String title;
  final int value;
  final Color? background;
  final Color? foreground;
  final Corner placement;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colours = theme.colorScheme;
    final textColour = foreground ?? colours.onSurface;
    final gradient = background != null
        ? null
        : LinearGradient(
            colors: <Color>[colours.surfaceContainerHighest, colours.surfaceContainerHigh],
            begin: _gradientBegin,
            end: _gradientEnd,
          );
    return Container(
      decoration: BoxDecoration(borderRadius: c.commonBorderRadius, color: background, gradient: gradient),
      padding: c.cardPadding,
      child: Column(
        crossAxisAlignment: _align,
        mainAxisAlignment: .center,
        children: [
          Text(
            title,
            style: TextStyle(color: textColour.withAlpha(190)),
            softWrap: false,
            overflow: .fade,
          ),
          Text(
            value.toString(),
            textHeightBehavior: _textHeightBehaviour,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: textColour,
              fontWeight: .w800,
              fontFeatures: c.fontFeatures,
            ),
          ),
        ],
      ),
    );
  }

  AlignmentGeometry get _gradientBegin => switch (placement) {
    .topLeft || .topRight => .topCenter,
    .bottomLeft || .bottomRight => .bottomCenter,
  };

  AlignmentGeometry get _gradientEnd => switch (placement) {
    .topLeft => .bottomRight,
    .topRight => .bottomLeft,
    .bottomLeft => .topRight,
    .bottomRight => .topLeft,
  };

  CrossAxisAlignment get _align => switch (placement) {
    .topLeft || .bottomLeft => .start,
    .topRight || .bottomRight => .end,
  };

  static const _textHeightBehaviour = TextHeightBehavior(
    applyHeightToFirstAscent: true,
    applyHeightToLastDescent: false,
  );
}

enum Corner { topLeft, topRight, bottomLeft, bottomRight }

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
              Expanded(child: Container(height: 1, color: theme.colorScheme.onSurface.withAlpha(50))),
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
                  fontFeatures: c.fontFeatures,
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
