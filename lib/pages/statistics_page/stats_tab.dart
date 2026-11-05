import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/util/format_ext.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/constrained.dart';
import 'package:tripeaks_neue/widgets/my_card.dart';
import 'package:tripeaks_neue/widgets/sliver_text.dart';

class const StatsTab(final Statistics statistics, {super.key, final bool showLayout = true})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(top: c.utilPageMargin, bottom: c.itemSpacing),
          sliver: OverallStatsTile(statistics),
        ),
        if (statistics.lastGame != null)
          SliverMainAxisGroup(
            slivers: <Widget>[
              H(Text(s.lastGameStatistics), maxWidth: c.maxListWidth, horizontalPadding: c.utilPageMargin),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: c.itemSpacing),
                  child: ScoreTable(games: [statistics.lastGame!], showRank: false, showLayout: showLayout),
                ),
              ),
            ],
          ),
        if (statistics.bestGames.isNotEmpty)
          SliverMainAxisGroup(
            slivers: <Widget>[
              H(Text(s.bestGamesStatistics), maxWidth: c.maxListWidth, horizontalPadding: c.utilPageMargin),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsetsGeometry.only(bottom: c.utilPageMarginBottom),
                  child: ScoreTable(games: statistics.bestGames, showLayout: showLayout),
                ),
              ),
            ],
          ),
      ],
    );
  }
}

class const OverallStatsTile(final Statistics statistics, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: c.maxListWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: c.utilPageMargin),
          child: Column(
            spacing: 8,
            children: [
              ChartCard(played: statistics.totalGames, cleared: statistics.cleared),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: ScoreCard(
                      score: statistics.bestGames.firstOrNull?.score ?? 0,
                      label: "HIGHEST SCORE",
                      icon: CustomIcons.scoreMedal30,
                    ),
                  ),
                  Expanded(
                    child: ScoreCard(
                      score: statistics.longestChain,
                      label: "LONGEST CHAIN",
                      icon: CustomIcons.chainMedal30,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

final class const BarChart(
  final double ratio, {
  final double shift = 3.652,
  required final Color filled1,
  required final Color filled2,
  required final Color empty,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint();
    final leftWidth = (size.width * ratio).roundToDouble();
    final rightWidth = size.width - leftWidth;
    canvas.clipRRect(RRect.fromRectAndRadius(Offset.zero & size, c.commonRadius));
    _drawRight(canvas, Size(rightWidth, size.height), Offset(leftWidth - c.commonRadius.x, 0), false, p);
    if (ratio > 0) {
      _drawLeft(canvas, Size(leftWidth, size.height), p);
    }
  }

  @override
  bool shouldRepaint(BarChart oldDelegate) => oldDelegate.empty != empty;

  void _drawLeft(Canvas canvas, Size size, Paint paint) {
    final rect = Offset.zero & size;
    paint
      ..color = filled1
      ..shader = LinearGradient(colors: <Color>[filled1, filled2]).createShader(rect)
      ..style = .fill;
    canvas.drawRRect(
      RRect.fromRectAndCorners(rect, topRight: c.commonRadius, bottomRight: c.commonRadius),
      paint,
    );
  }

  void _drawRight(Canvas canvas, Size size, Offset offset, bool full, Paint paint) {
    final h = size.height;
    final d = size.height * 0.5;
    final right = offset.dx + size.width + d;
    final left = right - size.width - h;

    paint
      ..color = empty
      ..style = .stroke
      ..strokeWidth = 1.2;

    // Start from right, so the right end will look good.
    // 2 is just a magic number, just like the default shift value :shrug:
    var x = right + 2;
    while (x >= left) {
      canvas.drawLine(Offset(x, h), Offset(x + d, 0), paint);
      x -= shift;
    }
  }
}

final class const ScoreCard({
  super.key,
  required final int score,
  required final String label,
  required final IconData icon,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textExt = theme.extension<MyTextThemeExt>()!;
    return MyCard(
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(label, style: textExt.faintLabelMedium, overflow: .fade, softWrap: false),
                ),
                Text(score.toString(), style: textExt.numericLarge),
              ],
            ),
          ),
          Icon(icon, color: theme.colorScheme.onSurfaceVariant, size: 30),
        ],
      ),
    );
  }
}

class const ScoreTable({
  super.key,
  required final List<SingleGameStatistics> games,
  final bool showRank = true,
  final bool showLayout = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colourExt = theme.extension<MyColourThemeExt>()!;
    final textExt = theme.extension<MyTextThemeExt>()!;
    final borderColour = colourExt.cardDivider;
    final borderSide = BorderSide(color: borderColour, width: 1);
    final numberStyle = textExt.numericBody;
    final rankStyle = numberStyle;
    final headerStyle = theme.textTheme.bodyMedium;
    final s = context.strings;
    return ConstrainedItem(
      child: Table(
        columnWidths: showRank ? _widthsShowRank : _widthsHideRank,
        defaultVerticalAlignment: .middle,
        children: <TableRow>[
          TableRow(
            key: ValueKey(0),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              border: Border.fromBorderSide(borderSide),
              borderRadius: BorderRadius.vertical(top: c.commonRadius),
            ),
            children: <Widget>[
              if (showRank) ...[
                Padding(
                  padding: _cellPadding,
                  child: Text("#", style: headerStyle),
                ),
                Container(color: borderColour, height: _cellHeight, width: 1),
              ],
              Padding(
                padding: _cellPadding,
                child: Text(s.gameLabel, style: headerStyle),
              ),
              Container(color: borderColour, height: _cellHeight, width: 1),
              Padding(
                padding: _iconCellPadding,
                child: Row(
                  mainAxisAlignment: .end,
                  children: [
                    Tooltip(
                      message: s.scoreTooltip,
                      child: Icon(CustomIcons.star, size: 24, color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Container(color: borderColour, height: _cellHeight, width: 1),
              Padding(
                padding: _iconCellPadding,
                child: Row(
                  mainAxisAlignment: .end,
                  children: [
                    Tooltip(
                      message: s.chainTooltip,
                      child: Icon(CustomIcons.chain, size: 24, color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
            ],
          ),
          for (final (index, game) in games.indexed)
            TableRow(
              key: ValueKey(index + 1),
              decoration: BoxDecoration(
                color: index & 1 == 1 ? theme.colorScheme.surfaceContainerLow : colourExt.cardBackground,
                border: Border(left: borderSide, right: borderSide, bottom: borderSide),
                borderRadius: index == games.length - 1
                    ? BorderRadius.vertical(bottom: c.commonRadius)
                    : null,
              ),
              children: <Widget>[
                if (showRank) ...[
                  Padding(
                    padding: _cellPadding,
                    child: Text((index + 1).toString(), style: rankStyle),
                  ),
                  Container(color: borderColour, height: _cellHeight, width: 1),
                ],
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: _cellPadding,
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisAlignment: .center,
                          children: [
                            if (showLayout)
                              Text(game.layout.label(context.strings), overflow: .fade, softWrap: false),
                            Text(game.ended.formatted, overflow: .fade, softWrap: false),
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(right: 8.0), child: Result(game.isCleared, s)),
                  ],
                ),
                Container(color: borderColour, height: _cellHeight, width: 1),
                Padding(
                  padding: _cellPadding,
                  child: Text(game.score.toString(), textAlign: .right, style: numberStyle),
                ),
                Container(color: borderColour, height: _cellHeight, width: 1),
                Padding(
                  padding: _cellPadding,
                  child: Text(game.longestChain.toString(), textAlign: .right, style: numberStyle),
                ),
              ],
            ),
        ],
      ),
    );
  }

  static const _cellPadding = EdgeInsets.symmetric(horizontal: 10);
  static const _iconCellPadding = EdgeInsets.symmetric(horizontal: 8);
  static const _cellHeight = 52.0;

  static const _widthsShowRank = <int, TableColumnWidth>{
    0: FixedColumnWidth(40),
    1: FixedColumnWidth(1),
    2: FlexColumnWidth(),
    3: FixedColumnWidth(1),
    4: FixedColumnWidth(68),
    5: FixedColumnWidth(1),
    6: FixedColumnWidth(68),
  };

  static const _widthsHideRank = <int, TableColumnWidth>{
    0: FlexColumnWidth(),
    1: FixedColumnWidth(1),
    2: FixedColumnWidth(68),
    3: FixedColumnWidth(1),
    4: FixedColumnWidth(68),
  };
}

final class const Result(final bool result, final AppLocalizations strings, {super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colourExt = theme.extension<MyColourThemeExt>()!;
    return Tooltip(
      message: result ? strings.gameClearedLabel : strings.gameNotClearedLabel,
      child: Container(
        decoration: BoxDecoration(
          shape: .circle,
          color: result ? Colors.lightGreen.shade500 : theme.colorScheme.outline,
        ),
        width: 24,
        height: 24,
        child: Center(
          child: Icon(
            result ? CustomIcons.check12 : CustomIcons.cross12,
            color: colourExt.cardBackground,
            size: 12,
          ),
        ),
      ),
    );
  }
}

final class const ChartCard({super.key, required final int played, required final int cleared})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colourExt = theme.extension<MyColourThemeExt>()!;
    final textExt = theme.extension<MyTextThemeExt>()!;
    final numberStyle = textExt.numericLarge;
    final percentStyle = textExt.numericMedium;
    final labelStyle = textExt.faintLabelMedium;
    final s = context.strings;
    return MyCard(
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        spacing: 4,
        children: [
          Row(
            mainAxisAlignment: .center,
            spacing: 2,
            textBaseline: .alphabetic,
            crossAxisAlignment: .baseline,
            children: [
              Text(s.totalPlayedLabel, textAlign: .center, style: labelStyle),
              Text(played.toString(), textAlign: .center, style: numberStyle),
              ExcludeSemantics(
                child: Text(
                  s.totalPlayedLabel,
                  textAlign: .center,
                  style: labelStyle.copyWith(color: Colors.transparent),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: .center,
            spacing: 8,
            children: [
              Expanded(
                child: SizedBox(
                  height: 24,
                  child: CustomPaint(
                    painter: BarChart(
                      played > 0 ? cleared.toDouble() / played : 0,
                      filled1: Colors.lightGreen.shade500,
                      filled2: Colors.lightGreen.shade300,
                      empty: colourExt.cardDivider,
                    ),
                  ),
                ),
              ),
              Text(played > 0 ? (cleared.toDouble() / played).percent : "None yet", style: percentStyle),
            ],
          ),
          Row(
            spacing: 2,
            textBaseline: .alphabetic,
            crossAxisAlignment: .baseline,
            children: [
              Text(s.totalClearedLabel, textAlign: .center, style: labelStyle),
              Text(cleared.toString(), textAlign: .center, style: numberStyle),
            ],
          ),
        ],
      ),
    );
  }
}
