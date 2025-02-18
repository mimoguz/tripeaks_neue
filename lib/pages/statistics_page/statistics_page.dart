import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/pages/shared/item_container.dart';
import 'package:tripeaks_neue/stores/session.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Player Statistics")),
        body: Builder(
          builder: (context) {
            final session = Provider.of<Session>(context);
            return Container(
              color: Theme.of(context).colorScheme.surfaceContainerLow,
              child: Observer(
                builder: (context) {
                  final statistics = session.statistics;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Flexible(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ListItemContainer(
                                child: Card(
                                  color: Theme.of(context).colorScheme.surface,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text("Total played"),
                                          trailing: Text(statistics.totalGames.toString()),
                                        ),
                                        const Divider(),
                                        ListTile(
                                          title: Text("Total cleared"),
                                          trailing: Text(statistics.cleared.toString()),
                                        ),
                                        const Divider(),
                                        ListTile(
                                          title: Text("Best score"),
                                          trailing: Text(
                                            (statistics.bestGames.firstOrNull?.score ?? 0).toString(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              ListItemContainer(child: Text("Last Game")),
                              ListItemContainer(
                                child: Card(
                                  color: Theme.of(context).colorScheme.surface,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ListTile(
                                      title: Text(statistics.lastGame?.ended.toIso8601String() ?? "-"),
                                      subtitle:
                                          statistics.lastGame?.isCleared ?? false ? Text("Cleared") : null,
                                      trailing: Text(statistics.lastGame?.score.toString() ?? ""),
                                    ),
                                  ),
                                ),
                              ),
                              ListItemContainer(child: Text("Best games")),
                              ListItemContainer(
                                child: Card(
                                  color: Theme.of(context).colorScheme.surface,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        for (final (index, game) in statistics.bestGames.indexed)
                                          ListTile(
                                            leading: Text((index + 1).toString()),
                                            title: Text(game.ended.toIso8601String()),
                                            subtitle: game.isCleared ? Text("Cleared") : null,
                                            trailing: Text(game.score.toString()),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
