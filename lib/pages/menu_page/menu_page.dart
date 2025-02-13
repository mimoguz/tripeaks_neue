import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:tripeaks_neue/pages/menu_page/list_button.dart';
import 'package:tripeaks_neue/pages/menu_page/page_title.dart';
import 'package:tripeaks_neue/pages/shared/item_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {
        NewGameIntent: NewGameAction(),
        NavigateToHomeIntent: NavigateToHomeAction(),
        NavigateToSettingsIntent: NavigateToSettingsAction(),
      },
      child: SafeArea(child: Scaffold(body: const MenuBody())),
    );
  }
}

final class MenuBody extends StatelessWidget {
  const MenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: const Center(
            child: CustomScrollView(
              shrinkWrap: true,
              slivers: [PageTitle(), SliverPadding(padding: EdgeInsets.all(12.0), sliver: MenuItems())],
            ),
          ),
        ),
      ],
    );
  }
}

final class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return SliverList.list(
      children: <Widget>[
        ListButton(
          icon: Icons.home,
          text: s.returnAction,
          onPressed: Actions.handler(context, NavigateToHomeIntent(replace: true)),
        ),
        const ListItemContainer(child: Divider(endIndent: 24, indent: 24, height: 16.0)),
        ListButton(
          icon: Peaks.newGame,
          text: s.newGameAction,
          onPressed: () => _callThenPop(context, Actions.handler(context, const NewGameIntent())),
        ),
        const SizedBox(height: 8.0),
        ListButton(icon: Peaks.pickAndPlay, text: s.newGameWithLayoutAction, onPressed: () {}),
        const SizedBox(height: 8.0),
        ListButton(icon: Icons.restart_alt, text: s.restartGameAction, onPressed: () {}),
        const ListItemContainer(child: Divider(endIndent: 24, indent: 24, height: 16.0)),
        ListButton(icon: Icons.bar_chart, text: s.statisticsAction, onPressed: () {}),
        const ListItemContainer(child: Divider(endIndent: 24, indent: 24, height: 16.0)),
        ListButton(icon: Icons.exit_to_app, text: s.exitAction, onPressed: () {}),
      ],
    );
  }

  void _callThenPop(BuildContext context, VoidCallback? action) {
    action?.call();
    Navigator.of(context).pop();
  }
}
