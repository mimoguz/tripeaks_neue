import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
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
            return Center(
              child: Observer(
                builder: (context) {
                  final statistics = session.statistics;
                  return Text("Total played: ${statistics.totalGames}\nTotal cleared: ${statistics.cleared}");
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
