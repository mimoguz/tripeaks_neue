import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/statistics_page/statistics_tab.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return SafeArea(
      child: Builder(
        builder: (context) {
          final session = Provider.of<Session>(context);
          return Observer(
            builder: (context) {
              final statistics = session.statistics;
              final perLayoutStats =
                  statistics.perLayoutStatistics.entries.toList()
                    ..sort((a, b) => a.key.index.compareTo(b.key.index));
              return DefaultTabController(
                initialIndex: 0,
                length: perLayoutStats.length + 1,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text(s.statisticsPageTitle),
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                    bottom: TabBar(
                      isScrollable: true,
                      tabAlignment: TabAlignment.center,
                      dividerColor: Colors.transparent,
                      tabs: <Widget>[
                        Tab(text: s.overallStatisticsTitle),
                        for (final entry in perLayoutStats) Tab(text: entry.key.label(s)),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      StatisticsTab(statistics.overallStatistics),
                      for (final layout in perLayoutStats) StatisticsTab(layout.value, showLayout: false),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
