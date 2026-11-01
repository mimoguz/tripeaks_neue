import 'package:intl/intl.dart' show NumberFormat, DateFormat;
import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/constrained.dart';
import 'package:tripeaks_neue/widgets/my_card.dart';
import 'package:tripeaks_neue/widgets/sliver_text.dart';

final _dateFormat = DateFormat("d MMM y, HH:mm");

class const StatsTab(final Statistics statistics, {super.key, final bool showLayout = true})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(top: c.utilPageMargin, bottom: c.DialogMetrics.sectionSpacing),
          sliver: OverallStatsTile(statistics),
        ),
        if (statistics.lastGame != null)
          SliverMainAxisGroup(
            slivers: <Widget>[
              H(
                Text(s.lastGameStatistics),
                pinned: false,
                maxWidth: c.maxListWidth,
                horizontalPadding: c.utilPageMargin,
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: c.DialogMetrics.sectionSpacing),
                sliver: SliverToBoxAdapter(
                  child: ScoreTable(games: [statistics.lastGame!], showRank: false, showLayout: showLayout),
                ),
              ),
            ],
          ),
        if (statistics.bestGames.isNotEmpty)
          SliverMainAxisGroup(
            slivers: <Widget>[
              H(Text(s.bestGamesStatistics), maxWidth: c.maxListWidth, horizontalPadding: c.utilPageMargin),
              SliverPadding(
                padding: EdgeInsetsGeometry.only(bottom: c.utilPageInsets.bottom),
                sliver: SliverToBoxAdapter(
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
  final double shift = 3.6,
  required final Color filled1,
  required final Color filled2,
  required final Color empty,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint();
    final leftWidth = (size.width * ratio).roundToDouble();
    final rightWidth = size.width - leftWidth;
    canvas.clipRRect(RRect.fromRectAndRadius(Offset.zero & size, _radius));
    _drawRight(canvas, Size(rightWidth, size.height), Offset(leftWidth - _radius.x, 0), false, p);
    if (ratio > 0) {
      _drawLeft(canvas, Size(leftWidth, size.height), p);
    }
  }

  @override
  bool shouldRepaint(BarChart oldDelegate) => oldDelegate.empty != empty;

  void _drawLeft(Canvas canvas, Size size, Paint paint) {
    final rect = Offset.zero & size;
    paint
      ..shader = LinearGradient(colors: <Color>[filled1, filled2]).createShader(rect)
      ..style = .fill;
    canvas.drawRRect(RRect.fromRectAndCorners(rect, topRight: _radius, bottomRight: _radius), paint);
  }

  void _drawRight(Canvas canvas, Size size, Offset offset, bool full, Paint paint) {
    final h = size.height;
    final d = size.height * 0.5;
    final right = offset.dx + size.width + d;

    paint
      ..color = empty
      ..style = .stroke
      ..strokeWidth = 1.2;

    var x = offset.dx - d;
    while (x <= right) {
      canvas.drawLine(Offset(x, h), Offset(x + d, 0), paint);
      x += shift;
    }
  }

  static const _radius = Radius.circular(12);
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
    return MyCard(
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .start,
              children: [
                Text(
                  score.toString(),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontFeatures: c.fontFeatures,
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: .w700,
                  ),
                ),
                Text(
                  label,
                  style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
                  overflow: .fade,
                  softWrap: false,
                ),
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
    final borderColour = theme.colorScheme.dialogDivider;
    final borderSide = BorderSide(color: borderColour, width: 1);
    final numberStyle = theme.textTheme.bodyMedium?.copyWith(fontFeatures: c.fontFeatures);
    final headerStyle = theme.textTheme.bodyMedium;
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
                child: Text("GAME", style: headerStyle),
              ),
              Container(color: borderColour, height: _cellHeight, width: 1),
              Padding(
                padding: _cellPadding,
                child: Row(
                  mainAxisAlignment: .end,
                  children: [Icon(CustomIcons.star, size: 24, color: theme.colorScheme.onSurfaceVariant)],
                ),
              ),
              Container(color: borderColour, height: _cellHeight, width: 1),
              Padding(
                padding: _cellPadding,
                child: Row(
                  mainAxisAlignment: .end,
                  children: [Icon(CustomIcons.chain, size: 24, color: theme.colorScheme.onSurfaceVariant)],
                ),
              ),
            ],
          ),
          for (final (index, game) in games.indexed)
            TableRow(
              key: ValueKey(index + 1),
              decoration: BoxDecoration(
                color: index & 1 == 1
                    ? theme.colorScheme.surfaceContainerLow
                    : theme.colorScheme.panelBackground,
                border: Border(left: borderSide, right: borderSide, bottom: borderSide),
                borderRadius: index == games.length - 1
                    ? BorderRadius.vertical(bottom: c.commonRadius)
                    : null,
              ),
              children: <Widget>[
                if (showRank) ...[
                  Padding(padding: _cellPadding, child: Text((index + 1).toString())),
                  Container(color: borderColour, height: _cellHeight, width: 1),
                ],
                Row(
                  mainAxisAlignment: .spaceBetween,
                  children: [
                    Padding(
                      padding: _cellPadding,
                      child: Column(
                        crossAxisAlignment: .start,
                        mainAxisAlignment: .center,
                        children: [
                          if (showLayout) Text(game.layout.label(context.strings)),
                          Text(_dateFormat.format(game.ended)),
                        ],
                      ),
                    ),
                    Padding(padding: const EdgeInsets.only(right: 8.0), child: Result(game.isCleared)),
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

  static const _cellPadding = EdgeInsets.symmetric(horizontal: 12);
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

final class const Result(final bool result, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      decoration: BoxDecoration(
        shape: .circle,
        color: result ? Colors.lightGreen.shade500 : theme.colorScheme.outline,
      ),
      width: 24,
      height: 24,
      child: Center(
        child: Icon(
          result ? CustomIcons.check12 : CustomIcons.cross12,
          color: theme.colorScheme.panelBackground,
          size: 12,
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
    final numberStyle = theme.textTheme.titleLarge?.copyWith(
      fontFeatures: c.fontFeatures,
      color: theme.colorScheme.onSurfaceVariant,
      fontWeight: .w700,
    );
    final labelStyle = theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline);
    return MyCard(
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        spacing: 4,
        children: [
          Row(
            mainAxisAlignment: .center,
            spacing: 3,
            textBaseline: .alphabetic,
            crossAxisAlignment: .baseline,
            children: [
              Text(played.toString(), textAlign: .center, style: numberStyle),
              Text("PLAYED", textAlign: .center, style: labelStyle),
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
                    painter: played > 0 && played > cleared
                        ? BarChart(
                            played > 0 ? cleared.toDouble() / played : 0,
                            filled1: Colors.lightGreen.shade500,
                            filled2: Colors.lightGreen.shade300,
                            empty: theme.colorScheme.dialogDivider,
                          )
                        : BarChart(
                            played > 0 ? cleared.toDouble() / played : 0,
                            filled1: Colors.orange.shade500,
                            filled2: Colors.amber.shade300,
                            empty: theme.colorScheme.dialogDivider,
                          ),
                  ),
                ),
              ),
              Text(
                played > 0 ? "${f.format((cleared.toDouble() / played) * 100)}%" : "None yet",
                style: numberStyle?.copyWith(fontSize: 18),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: .start,
            spacing: 3,
            textBaseline: .alphabetic,
            crossAxisAlignment: .baseline,
            children: [
              Text(cleared.toString(), textAlign: .center, style: numberStyle),
              Text("CLEARED", textAlign: .center, style: labelStyle),
            ],
          ),
        ],
      ),
    );
  }

  static final f = NumberFormat("##0.#", "en_GB");
}
