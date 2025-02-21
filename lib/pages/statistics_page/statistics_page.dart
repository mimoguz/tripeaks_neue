import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/widgets/item_container.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/widgets/list_item.dart';

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
                        for (final layout in perLayoutStats) Tab(text: _valueLabel(layout.key, s)),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      StatisticsTabBody(statistics.overallStatistics),
                      for (final layout in perLayoutStats) StatisticsTabBody(layout.value, showLayout: false),
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

class StatisticsTabBody extends StatelessWidget {
  const StatisticsTabBody(this.statistics, {super.key, this.showLayout = true});

  final Statistics statistics;
  final bool showLayout;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final s = AppLocalizations.of(context)!;
    return Container(
      color: colours.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                    child: BasicStatistics(statistics),
                  ),
                  if (statistics.lastGame != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      child: StatGroup(
                        title: s.lastGameStatistics,
                        child: GameEntry(place: -1, game: statistics.lastGame!, showLayout: showLayout),
                      ),
                    ),
                  if (statistics.bestGames.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                      child: StatGroup(
                        title: s.bestGamesStatistics,
                        child: Column(
                          children: [
                            for (final (index, game) in statistics.bestGames.indexed)
                              GameEntry(place: index + 1, game: game, showLayout: showLayout),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final class StatGroup extends StatelessWidget {
  const StatGroup({super.key, required this.child, this.title});

  final Widget child;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ListItemContainer(
      child:
          title == null
              ? Card(
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                  child: child,
                ),
              )
              : Card(
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                  child: Column(
                    spacing: 4.0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      child,
                    ],
                  ),
                ),
              ),
    );
  }
}

final class BasicStatistics extends StatelessWidget {
  const BasicStatistics(this.statistics, {super.key});

  final Statistics statistics;

  @override
  Widget build(BuildContext context) {
    final trailingStyle = Theme.of(context).textTheme.bodyMedium;
    final s = AppLocalizations.of(context)!;
    return StatGroup(
      title: s.statisticsSummary,
      child: Column(
        children: [
          MyListTile(
            title: Text(s.totalPlayedLabel),
            trailing: Text(statistics.totalGames.toString(), style: trailingStyle),
          ),
          MyListTile(
            title: Text(s.totalClearedLabel),
            trailing: Text(statistics.cleared.toString(), style: trailingStyle),
          ),
          MyListTile(
            title: Text(s.bestScoreLabel),
            trailing: Text((statistics.bestGames.firstOrNull?.score ?? 0).toString(), style: trailingStyle),
          ),
        ],
      ),
    );
  }
}

final class GameEntry extends StatelessWidget {
  const GameEntry({super.key, required this.place, required this.game, this.showLayout = true});

  final int place;
  final SingleGameStatistics game;
  final bool showLayout;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return MyListTile(
      leading: place > 0 ? Order(place) : null,
      title: Text(_dateFormat.format(game.ended)),
      subtitle: Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        spacing: 12.0,
        children: [if (showLayout) Text(_valueLabel(game.layout, s)), StatusChip(game)],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 4,
        children: [
          Text(game.score.toString(), style: theme.textTheme.titleMedium),
          Icon(CustomIcons.star16, size: 16, color: theme.colorScheme.outline),
        ],
      ),
    );
  }

  static final _dateFormat = DateFormat("d MMMM y, HH:mm");
}

String _valueLabel(Peaks value, AppLocalizations s) => switch (value) {
  Peaks.threePeaks => s.threePeaksLayoutLabel,
  Peaks.diamonds => s.diamondsLayoutLabel,
  Peaks.valley => s.valleyLayoutLabel,
  Peaks.upDown => s.upDownLayoutLabel,
};

class StatusChip extends StatelessWidget {
  const StatusChip(this.game, {super.key});

  final SingleGameStatistics game;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final fill = game.isCleared ? colours.primary : colours.errorContainer;
    final text = game.isCleared ? colours.onPrimary : colours.onErrorContainer;
    final s = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(color: fill, borderRadius: const BorderRadius.all(Radius.circular(100.0))),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 1.0),
        child: Text(
          game.isCleared ? s.gameClearedLabel : s.gameNotClearedLabel,
          style: TextStyle(fontSize: 12, color: text),
        ),
      ),
    );
  }
}

final class Order extends StatelessWidget {
  const Order(this.value, {super.key});

  final int value;

  @override
  Widget build(BuildContext context) {
    return Text(value.toString(), style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600));
  }
}
