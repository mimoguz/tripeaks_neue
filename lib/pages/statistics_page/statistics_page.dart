import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/pages/statistics_page/stats_tab.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/util/overlay_style.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
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
    final s = context.strings;
    final useVertical = MediaQuery.sizeOf(context).height < c.verticalTabsThreshold;
    setOverlayStyleOf(context);
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.keyQ, control: true): const ExitIntent(),
        SingleActivator(LogicalKeyboardKey.escape): const GoBackIntent(),
        SingleActivator(LogicalKeyboardKey.backspace): const GoBackIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          ExitIntent: ExitAction(),
          GoBackIntent: GoBackAction(),
          ImportStatsIntent: ImportStatsAction(),
          ExportStatsIntent: ExportStatsAction(),
          ClearStatsIntent: ClearStatsAction(),
        },
        child: SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (context) {
              final session = Provider.of<Session>(context);
              final theme = context.theme;
              final colours = theme.colorScheme;
              return Observer(
                builder: (context) {
                  final statistics = session.statistics;
                  final perLayoutStats = statistics.perLayoutStatistics.entries.toList()
                    ..sort((a, b) => a.key.index.compareTo(b.key.index));
                  return DefaultTabController(
                    initialIndex: 0,
                    length: perLayoutStats.length + 1,
                    child: Scaffold(
                      appBar: AppBar(
                        title: Text(s.statisticsPageTitle),
                        backgroundColor: colours.surfaceContainer,
                        surfaceTintColor: colours.surfaceContainer,
                        actionsPadding: EdgeInsets.only(right: 2.0),
                        actions: [
                          PopupMenuButton(
                            menuPadding: EdgeInsets.symmetric(vertical: c.commonRadiusValue),
                            shape: RoundedRectangleBorder(borderRadius: c.commonBorderRadius),
                            icon: Icon(Icons.more_vert, color: colours.onSurfaceVariant),
                            itemBuilder: (context) => _popupItems(context, s),
                          ),
                        ],
                        bottom: useVertical
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
                      body: Container(
                        color: colours.surfaceContainer,
                        child: Focus(
                          focusNode: _focusNode,
                          autofocus: true,
                          skipTraversal: true,
                          descendantsAreFocusable: true,
                          descendantsAreTraversable: true,
                          child: useVertical
                              ? MyVerticalTabView(
                                  background: colours.surfaceContainer,
                                  width: 180,
                                  tabs: <Tab>[
                                    Tab(text: s.overallStatisticsTitle),
                                    for (final entry in perLayoutStats) Tab(text: entry.key.label(s)),
                                  ],
                                  contents: <Widget>[
                                    StatsTab(
                                      statistics.overallStatistics,
                                      isNarrow: useVertical,
                                      key: ValueKey("overall"),
                                    ),
                                    for (final layout in perLayoutStats)
                                      StatsTab(
                                        layout.value,
                                        showLayout: false,
                                        isNarrow: useVertical,
                                        key: Key(layout.key.name),
                                      ),
                                  ],
                                )
                              : TabBarView(
                                  children: <Widget>[
                                    StatsTab(statistics.overallStatistics, isNarrow: useVertical),
                                    for (final layout in perLayoutStats)
                                      StatsTab(
                                        layout.value,
                                        showLayout: false,
                                        isNarrow: useVertical,
                                        key: Key(layout.key.name),
                                      ),
                                  ],
                                ),
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

  List<PopupMenuEntry> _popupItems(BuildContext context, AppLocalizations s) {
    final theme = context.theme;
    final colours = theme.colorScheme;
    final colourExt = theme.extension<MyColourThemeExt>()!;
    return [
      PopupMenuItem<Never>(
        onTap: Actions.handler(context, const ExportStatsIntent()),
        child: Row(
          spacing: 16,
          children: [
            Icon(Icons.upload, color: colours.onSurfaceVariant),
            Text(s.exportAction),
          ],
        ),
      ),
      PopupMenuItem<Never>(
        onTap: Actions.handler(context, const ImportStatsIntent()),
        child: Row(
          spacing: 16,
          children: [
            Icon(Icons.download, color: colours.onSurfaceVariant),
            Text(s.importAction),
          ],
        ),
      ),
      PopupMenuDivider(color: colourExt.dialogDivider),
      PopupMenuItem<Never>(
        onTap: Actions.handler(context, const ClearStatsIntent()),
        child: Row(
          spacing: 16,
          children: [
            Icon(Icons.delete, color: colours.error),
            Text(s.clearAction, style: TextStyle(color: colours.error)),
          ],
        ),
      ),
    ];
  }
}
