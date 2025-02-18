import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/shared/item_container.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
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
              final perLayoutStats = statistics.perLayoutStatistics.entries.toList();
              return DefaultTabController(
                initialIndex: 0,
                length: perLayoutStats.length + 1,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("Player Statistics"),
                    bottom: TabBar(
                      tabs: <Widget>[
                        Tab(text: "Overall"),
                        for (final layout in perLayoutStats) Tab(text: _valueLabel(layout.key, s)),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      StatisticsTabBody(statistics.overallStatistics),
                      for (final layout in perLayoutStats) StatisticsTabBody(layout.value),
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
  const StatisticsTabBody(this.statistics, {super.key});

  final Statistics statistics;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  BasicStatistics(statistics),
                  if (statistics.lastGame != null) StatGroupTitle(title: "Last Game"),
                  if (statistics.lastGame != null)
                    StatGroup(child: GameEntry(place: -1, game: statistics.lastGame!)),
                  StatGroupTitle(title: "Best Games"),
                  StatGroup(
                    child: Column(
                      children: [
                        for (final (index, game) in statistics.bestGames.indexed)
                          GameEntry(place: index + 1, game: game),
                      ],
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

final class StatGroupTitle extends StatelessWidget {
  const StatGroupTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListItemContainer(child: Text(title));
  }
}

class StatGroup extends StatelessWidget {
  const StatGroup({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListItemContainer(
      child: Card(
        color: Theme.of(context).colorScheme.surface,
        child: Padding(padding: const EdgeInsets.all(8.0), child: child),
      ),
    );
  }
}

final class BasicStatistics extends StatelessWidget {
  const BasicStatistics(this.statistics, {super.key});

  final Statistics statistics;

  @override
  Widget build(BuildContext context) {
    return StatGroup(
      child: Column(
        children: [
          ListTile(title: Text("Total played"), trailing: Text(statistics.totalGames.toString())),
          const Divider(),
          ListTile(title: Text("Total cleared"), trailing: Text(statistics.cleared.toString())),
          const Divider(),
          ListTile(
            title: Text("Best score"),
            trailing: Text((statistics.bestGames.firstOrNull?.score ?? 0).toString()),
          ),
        ],
      ),
    );
  }
}

final class GameEntry extends StatelessWidget {
  const GameEntry({super.key, required this.place, required this.game});

  final int place;
  final SingleGameStatistics game;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return ListTile(
      leading: place > 0 ? Text((place).toString()) : null,
      title: Text(game.ended.toIso8601String()),
      subtitle: Row(
        spacing: 12.0,
        children: [Text(_valueLabel(game.layout, s)), if (game.isCleared) Text("Cleared")],
      ),
      trailing: Text(game.score.toString()),
    );
  }
}

String _valueLabel(Peaks value, AppLocalizations s) => switch (value) {
  Peaks.threePeaks => s.threePeaksLayoutLabel,
  Peaks.diamonds => s.diamondsLayoutLabel,
  Peaks.valley => s.valleyLayoutLabel,
  Peaks.upDown => s.upDownLayoutLabel,
};
