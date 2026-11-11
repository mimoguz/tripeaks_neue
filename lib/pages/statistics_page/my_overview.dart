import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/pages/statistics_page/my_chart_card.dart';
import 'package:tripeaks_neue/pages/statistics_page/my_stat_card.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

class const MyOverview({super.key, required final Statistics stats, required final bool isNarrow})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.maybeWidthOf(context) ?? 300;
    final horizontal = width > (isNarrow ? 640.0 : 400.0);
    final s = context.strings;
    final brightness = context.theme.brightness;
    return horizontal
        ? SizedBox(
            key: ValueKey(1),
            height: 248,
            child: Row(
              spacing: 8,
              children: [
                Flexible(
                  flex: 5,
                  child: MyChartCard(played: stats.totalGames, cleared: stats.cleared),
                ),
                Flexible(
                  flex: 3,
                  child: Column(
                    spacing: 8,
                    children: [
                      Expanded(
                        child: MyStatCard(
                          value: stats.bestGames.firstOrNull?.score ?? 0,
                          label: s.bestScoreLabel,
                          icon: brightness == .dark ? CustomIcons.starDark32 : CustomIcons.starLight32,
                        ),
                      ),
                      Expanded(
                        child: MyStatCard(
                          value: stats.longestChain,
                          label: s.longestChainLabel,
                          icon: CustomIcons.chain32,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Column(
            key: ValueKey(2),
            spacing: 8,
            children: [
              MyChartCard(played: stats.totalGames, cleared: stats.cleared),
              Row(
                spacing: 8,
                children: [
                  Expanded(
                    child: MyStatCard(
                      value: stats.bestGames.firstOrNull?.score ?? 0,
                      label: s.bestScoreLabel,
                      icon: brightness == .dark ? CustomIcons.starDark32 : CustomIcons.starLight32,
                    ),
                  ),
                  Expanded(
                    child: MyStatCard(
                      value: stats.longestChain,
                      label: s.longestChainLabel,
                      icon: CustomIcons.chain32,
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
