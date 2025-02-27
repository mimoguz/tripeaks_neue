import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/info_page/howto_tab.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("How to & About"),
            backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
            bottom: TabBar(
              tabAlignment: TabAlignment.center,
              dividerColor: Colors.transparent,
              tabs: <Widget>[Tab(text: "How to Play"), Tab(text: "About the Game")],
            ),
          ),
          body: TabBarView(children: <Widget>[HowtoTab(), Placeholder()]),
        ),
      ),
    );
  }
}
