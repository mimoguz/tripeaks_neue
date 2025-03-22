import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_horizontal_vertical_tabview/vertical_tab_view.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/statistics_page/statistics_tab.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_vertical_tab_view.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final useVertical = MediaQuery.sizeOf(context).height < c.verticalTabsThreshold;
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.keyQ, control: true): const ExitIntent(),
        SingleActivator(LogicalKeyboardKey.escape): const GoBackIntent(),
        SingleActivator(LogicalKeyboardKey.backspace): const GoBackIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{ExitIntent: ExitAction(), GoBackIntent: GoBackAction()},
        child: SafeArea(
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
                        bottom:
                            useVertical
                                ? null
                                : TabBar(
                                  isScrollable: true,
                                  tabAlignment: TabAlignment.center,
                                  dividerColor: Colors.transparent,
                                  tabs: <Widget>[
                                    Tab(text: s.overallStatisticsTitle),
                                    for (final entry in perLayoutStats) Tab(text: entry.key.label(s)),
                                  ],
                                ),
                      ),
                      body: Focus(
                        focusNode: _focusNode,
                        autofocus: true,
                        skipTraversal: true,
                        descendantsAreFocusable: true,
                        descendantsAreTraversable: true,
                        child:
                            useVertical
                                ? MyVerticalTabView(
                                  width: 180,
                                  tabs: <Tab>[
                                    Tab(text: s.overallStatisticsTitle),
                                    for (final entry in perLayoutStats) Tab(text: entry.key.label(s)),
                                  ],
                                  contents: <Widget>[
                                    StatisticsTab(statistics.overallStatistics, key: ValueKey("overall")),
                                    for (final layout in perLayoutStats)
                                      StatisticsTab(
                                        layout.value,
                                        showLayout: false,
                                        key: Key(layout.key.name),
                                      ),
                                  ],
                                )
                                : TabBarView(
                                  children: <Widget>[
                                    StatisticsTab(statistics.overallStatistics),
                                    for (final layout in perLayoutStats)
                                      StatisticsTab(layout.value, showLayout: false),
                                  ],
                                ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
