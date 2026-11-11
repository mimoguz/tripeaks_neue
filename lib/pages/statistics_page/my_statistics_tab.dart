import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/pages/statistics_page/my_overview.dart';
import 'package:tripeaks_neue/pages/statistics_page/my_score_table.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/constrained.dart';
import 'package:tripeaks_neue/widgets/sliver_text.dart';

class const MyStatisticsTab(
  final Statistics statistics, {
  super.key,
  final bool isNarrow = false,
  final bool showLayout = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final theme = context.theme;
    final valueExt = theme.extension<MyValueExt>()!;
    final bg = theme.colorScheme.surfaceContainer;
    return CustomScrollView(
      slivers: <Widget>[
        ConstrainedSliver(
          child: Padding(
            padding: EdgeInsets.only(top: c.utilPageMargin, bottom: c.DialogMetrics.sectionSpacing),
            child: MyOverview(stats: statistics, isNarrow: isNarrow),
          ),
        ),
        if (statistics.lastGame != null)
          SliverMainAxisGroup(
            slivers: <Widget>[
              H(
                Text(s.lastGameStatistics),
                maxWidth: c.maxListWidth,
                horizontalPadding: c.utilPageMargin,
                background: bg,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: c.DialogMetrics.sectionSpacing, top: 6),
                  child: MyScoreTable(games: [statistics.lastGame!], showRank: false, showLayout: showLayout),
                ),
              ),
            ],
          ),
        if (statistics.bestGames.isNotEmpty)
          SliverMainAxisGroup(
            slivers: <Widget>[
              H(
                Text(s.bestGamesStatistics),
                maxWidth: c.maxListWidth,
                horizontalPadding: c.utilPageMargin,
                background: bg,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsetsGeometry.only(bottom: valueExt.utilPageMarginBottom, top: 6),
                  child: MyScoreTable(games: statistics.bestGames, showLayout: showLayout),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
