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
    final valueExt = context.theme.extension<MyValueExt>()!;
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(top: c.utilPageMargin, bottom: c.DialogMetrics.sectionSpacing),
          sliver: OverallStatsTile(statistics),
        ),
        if (statistics.lastGame != null)
          SliverMainAxisGroup(
            slivers: <Widget>[
              H(Text(s.lastGameStatistics), maxWidth: c.maxListWidth, horizontalPadding: c.utilPageMargin),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: c.DialogMetrics.sectionSpacing),
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
                  padding: EdgeInsetsGeometry.only(bottom: valueExt.utilPageMarginBottom),
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
    var x = right + 2.6;
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
    final colourExt = theme.extension<MyColourThemeExt>()!;
    final colours = theme.colorScheme;
    return MyCard(
      padding: EdgeInsets.zero,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Flexible(
            child: Padding(
              padding: _padding,
              child: Column(
                mainAxisAlignment: .center,
                crossAxisAlignment: .start,
                children: [
                  Transform.translate(
                    offset: _offset,
                    child: Text(label, style: textExt.faintLabelMedium, overflow: .fade, softWrap: false),
                  ),
                  Text(score.toString(), style: textExt.numericLarge),
                ],
              ),
            ),
          ),
          Container(
            height: 64,
            width: 64,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colourExt.cardBackground, colours.secondaryContainer],
                begin: .bottomLeft,
                end: .topRight,
              ),
              borderRadius: _rightRadius,
              border: Border(left: BorderSide(color: colourExt.faintBorder)),
            ),
            child: Icon(icon, color: colours.onSurfaceVariant, size: 30),
          ),
        ],
      ),
    );
  }

  static const _offset = Offset(0, 3);
  static const _padding = EdgeInsets.fromLTRB(c.cardPaddingHorizontal, 2, c.cardPaddingHorizontal, 0);
  static const _rightRadius = BorderRadius.horizontal(right: c.commonRadius);
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
    final borderColour = colourExt.settingItemDivider;
    final borderSide = BorderSide(color: borderColour, width: 1);
    final numberStyle = textExt.numericBody;
    final rankStyle = numberStyle;
    final headerStyle = theme.textTheme.bodyMedium;
    final s = context.strings;
    return ConstrainedItem(
      child: MyCard(
        padding: EdgeInsets.zero,
        child: Table(
          columnWidths: showRank ? _widthsShowRank : _widthsHideRank,
          defaultVerticalAlignment: .middle,
          children: <TableRow>[
            TableRow(
              key: ValueKey(0),
              decoration: BoxDecoration(
                color: colourExt.cardBackground,
                // border: Border(bottom: borderSide),
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
                _HeaderIcon(
                  key: _starKey,
                  padding: _iconCellPadding,
                  tooltip: s.scoreTooltip,
                  icon: CustomIcons.star,
                ),
                Container(color: borderColour, height: _cellHeight, width: 1),
                _HeaderIcon(
                  key: _chainKey,
                  padding: _iconCellPadding,
                  tooltip: s.chainTooltip,
                  icon: CustomIcons.chain,
                ),
              ],
            ),
            for (final (index, game) in games.indexed)
              TableRow(
                key: ValueKey(index + 1),
                decoration: BoxDecoration(
                  color: index & 1 == 0 ? theme.colorScheme.surfaceContainerHigh : null,
                  border: Border(top: borderSide),
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
      ),
    );
  }

  static const _chainKey = ValueKey("chain");
  static const _starKey = ValueKey("start");
  static const _cellPadding = EdgeInsets.symmetric(horizontal: 10);
  static const _iconCellPadding = EdgeInsets.symmetric(horizontal: 8);
  static const _cellHeight = 48.0;

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

class const _HeaderIcon({
  super.key,
  required final EdgeInsets padding,
  required final String tooltip,
  required final IconData icon,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: .end,
        children: [
          Tooltip(
            message: tooltip,
            child: Icon(icon, size: 24, color: colours.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
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
