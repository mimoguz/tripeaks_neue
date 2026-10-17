import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/pages/statistics_page/pie.dart';
import 'package:tripeaks_neue/pages/statistics_page/result_chip.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

const _leadingWidth = 18.0;
const _verticalSpacing = 18.0;
final _dateFormat = DateFormat("d MMMM y, HH:mm");

// TODO: This is just a mess, clean-up a little
final class const StatisticsTab(this.statistics, {super.key, final bool showLayout = true})
    extends StatelessWidget {
  final Statistics statistics;
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colours = theme.colorScheme;
    final s = context.strings;
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
              child: SingleChildScrollView(
                primary: true,
                padding: const EdgeInsets.all(c.utilPageMargin),
                child: GroupTile(
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.only(top: 4), child: OverallStats(statistics)),
                    if (last != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: _verticalSpacing + 8.0),
                        child: Row(
                          spacing: 6.0,
                          children: [
                            ResultChipCompact(true),
                            Text(s.gameClearedLabel),
                            SizedBox(width: 12.0),
                            ResultChipCompact(false),
                            Text(s.gameNotClearedLabel),
                          ],
                        ),
                      ),
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
                      LastGameEntry(last, showLayout: showLayout),
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
                      for (final (index, game) in best.indexed)
                        ScoreboardEntry(game: game, place: index + 1, showLayout: showLayout),
                    ],
                    SizedBox(height: best.isNotEmpty ? 0 : 4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class const OverallStats(final Statistics statistics, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colours = theme.colorScheme;
    final s = context.strings;
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

class const ScoreCard({
  super.key,
  required final Corner placement,
  required final String title,
  required final int value,
  final Color? background,
  final Color? foreground,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
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

class const LastGameEntry(this.game, {super.key, required final bool showLayout}) extends StatelessWidget {
  final SingleGameStatistics game;
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return ListTile(
      minLeadingWidth: 0.0,
      horizontalTitleGap: 4.0,
      minTileHeight: 0.0,
      visualDensity: .compact,
      contentPadding: showLayout
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
      leading: SizedBox(),
      trailing: Trailing(stats: game),
      title: showLayout ? Text(game.layout.label(s)) : TimeLine(time: game.ended, isCleared: game.isCleared),
      subtitle: showLayout ? TimeLine(time: game.ended, isCleared: game.isCleared) : null,
    );
  }
}

class const ScoreboardEntry({
  super.key,
  required final SingleGameStatistics game,
  required final int place,
  required final bool showLayout,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final s = context.strings;
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
          trailing: Trailing(stats: game),
          title: showLayout
              ? Text(game.layout.label(s))
              : TimeLine(time: game.ended, isCleared: game.isCleared),
          subtitle: showLayout ? TimeLine(time: game.ended, isCleared: game.isCleared) : null,
        ),
      ],
    );
  }
}

final class const TimeLine({required final DateTime time, required final bool isCleared, super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: .min,
      spacing: 6.0,
      children: [ResultChipCompact(isCleared), Text(_dateFormat.format(time))],
    );
  }
}

class const Trailing({super.key, required final SingleGameStatistics stats}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textStyle = theme.textTheme.bodyMedium?.copyWith(fontSize: 13.0, fontFeatures: c.fontFeatures);
    final s = context.strings;
    return Column(
      mainAxisAlignment: .center,
      crossAxisAlignment: .end,
      spacing: 2.0,
      children: [
        Tooltip(
          // TODO: strings
          message: s.scoreTooltip,
          child: Row(
            mainAxisSize: .min,
            mainAxisAlignment: .end,
            spacing: 4,
            children: [
              Icon(CustomIcons.star16, size: 16, color: DecorColour.amber.background),
              Text(stats.score.toString(), style: textStyle),
            ],
          ),
        ),
        Tooltip(
          message: s.chainTooltip,
          child: Row(
            mainAxisSize: .min,
            mainAxisAlignment: .end,
            spacing: 4,
            children: [
              Icon(CustomIcons.chain16, size: 16, color: theme.colorScheme.secondary),
              Text(stats.longestChain.toString(), style: textStyle),
            ],
          ),
        ),
      ],
    );
  }
}
