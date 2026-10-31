import 'package:intl/intl.dart' show NumberFormat, DateFormat;
import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
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
          padding: const EdgeInsets.fromLTRB(c.utilPageMargin, c.utilPageMargin, c.utilPageMargin, 0),
          sliver: OverallStatsTile(statistics),
        ),
        if (statistics.lastGame != null)
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: c.DialogMetrics.sectionSpacing),
            sliver: SliverMainAxisGroup(
              slivers: <Widget>[
                H(
                  Text(s.lastGameStatistics),
                  pinned: false,
                  maxWidth: c.maxListWidth,
                  horizontalPadding: c.utilPageMargin,
                ),
                SliverToBoxAdapter(child: SingleGameTile(game: statistics.lastGame!, rank: -1)),
              ],
            ),
          ),
        if (statistics.bestGames.isNotEmpty)
          SliverMainAxisGroup(
            slivers: <Widget>[
              H(Text(s.bestGamesStatistics), maxWidth: c.maxListWidth, horizontalPadding: c.utilPageMargin),
              SliverList.separated(
                itemCount: statistics.bestGames.length,
                itemBuilder: (context, index) =>
                    SingleGameTile(game: statistics.bestGames[index], rank: index + 1),
                separatorBuilder: (_, _) =>
                    Line(verticalPadding: 8, horizontalPadding: c.utilPageMargin, maxWidth: c.maxListWidth),
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

final class const SingleGameTile({
  super.key,
  required final SingleGameStatistics game,
  required final int rank,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final theme = context.theme;
    return Material(
      elevation: 0,
      color: Colors.transparent,
      clipBehavior: .none,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: c.maxListWidth),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: c.utilPageMargin),
            child: Row(
              children: [
                if (rank > 0)
                  SizedBox(width: 32, child: Text(rank.toString(), style: theme.textTheme.labelMedium)),
                Expanded(
                  child: Row(
                    spacing: 4,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          mainAxisSize: .min,
                          children: [
                            Text(game.layout.label(s), style: theme.textTheme.titleMedium),
                            Text(_dateFormat.format(game.ended), style: theme.textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      Result(game.isCleared),
                      MiniScoreCard(score: game.score, icon: CustomIcons.star16),
                      MiniScoreCard(score: game.longestChain, icon: CustomIcons.chain16),
                    ],
                  ),
                ),
                Row(),
              ],
            ),
          ),
        ),
      ),
    );
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
    return Material(
      borderRadius: c.commonBorderRadius,
      color: theme.colorScheme.panelBackground,
      shadowColor: theme.shadowColor,
      elevation: 2,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: c.commonBorderRadius,
          border: Border.all(color: theme.colorScheme.faintBorder, width: 1),
        ),
        child: Padding(
          padding: c.cardPadding,
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
        ),
      ),
    );
  }
}

final class const Result(final bool result, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      decoration: BoxDecoration(
        shape: .circle,
        color: result ? Colors.lightGreen.shade500 : theme.colorScheme.tertiary,
      ),
      width: 24,
      height: 24,
      child: Center(
        child: Icon(
          result ? CustomIcons.check12 : CustomIcons.cross12,
          color: result ? theme.colorScheme.onSecondary : theme.colorScheme.onTertiary,
          size: 12,
        ),
      ),
    );
  }
}

final class const MiniScoreCard({super.key, required final int score, required final IconData icon})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: c.commonBorderRadius,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      padding: EdgeInsets.fromLTRB(8, 0, 6, 0),
      width: 58,
      height: 24,
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(
            score.toString(),
            style: theme.textTheme.labelMedium?.copyWith(
              fontFeatures: c.fontFeatures,
              color: theme.colorScheme.panelBackground,
              fontWeight: .w700,
            ),
          ),
          Icon(icon, color: theme.colorScheme.panelBackground, size: 16),
        ],
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
    return Material(
      color: theme.colorScheme.panelBackground,
      elevation: 2,
      shadowColor: theme.shadowColor,
      borderRadius: c.commonBorderRadius,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: c.commonBorderRadius,
          border: Border.all(color: theme.colorScheme.faintBorder, width: 1),
        ),
        child: Padding(
          padding: c.cardPadding,
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
                        painter: BarChart(
                          played > 0 ? cleared.toDouble() / played : 0,
                          filled1: Colors.lightGreen.shade500,
                          filled2: Colors.lightGreen.shade300,
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
        ),
      ),
    );
  }

  static final f = NumberFormat("##0.#", "en_GB");
}
