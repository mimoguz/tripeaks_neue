import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final s = AppLocalizations.of(context)!;
    final canExit = !(kIsWeb || kIsWasm || Platform.isIOS);
    return Drawer(
      surfaceTintColor: colours.surfaceTint,
      elevation: 2.0,
      width: 340.0,
      shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.zero)),
      clipBehavior: Clip.antiAlias,
      child: ScrollIndicator(
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              pinned: true,
              foregroundColor: colours.onSurfaceVariant,
              title: RichText(
                text: TextSpan(
                  text: "TriPeaks",
                  style: TextStyle(
                    fontFamily: "Outfit",
                    fontSize: 18,
                    color: colours.onSurfaceVariant,
                    fontVariations: [FontVariation("wght", 400)],
                  ),
                  children: [
                    TextSpan(
                      text: " NEUE",
                      style: TextStyle(
                        fontFamily: "Outfit",
                        fontSize: 18,
                        letterSpacing: 4.0,
                        color: colours.tertiary.withAlpha(180),
                        fontVariations: [FontVariation("wght", 200)],
                      ),
                    ),
                  ],
                ),
                overflow: TextOverflow.ellipsis,
              ),
              leading: CloseButton(),
              actions: [
                IconButton(
                  icon: const Icon(Icons.help),
                  tooltip: s.infoTooltip,
                  onPressed: Actions.handler(context, const NavigateToInfoIntent(replace: false)),
                ),
                Observer(
                  builder: (context) {
                    final settings = Provider.of<Settings>(context);
                    return IconButton(
                      icon: const Icon(Icons.volume_off),
                      isSelected: settings.soundOn,
                      selectedIcon: const Icon(Icons.volume_up),
                      tooltip: settings.soundOn ? s.soundOnToolTip : s.soundOffToolTip,
                      onPressed: () => settings.setSoundOn(!settings.soundOn),
                    );
                  },
                ),
                const SizedBox(width: 4.0),
                IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: s.settingsTooltip,
                  onPressed: Actions.handler(context, const NavigateToSettingsIntent(replace: false)),
                ),
                const SizedBox(width: 8.0),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.all(12.0),
              sliver: SliverList.list(
                children: <Widget>[
                  DrawerListTile(
                    icon: CustomIcons.newGame,
                    title: s.newGameAction,
                    intent: const NewGameIntent(),
                  ),
                  DrawerListTile(
                    icon: CustomIcons.pickAndPlay,
                    title: s.newGameWithLayoutAction,
                    intent: const NewGameWithLayoutIntent(),
                  ),
                  DrawerListTile(
                    icon: Icons.restart_alt,
                    title: s.restartGameAction,
                    intent: const RestartIntent(),
                  ),
                  Divider(indent: 20, endIndent: 20),
                  DrawerListTile(
                    icon: Icons.bar_chart,
                    title: s.statisticsAction,
                    intent: const NavigateToStatisticsIntent(),
                  ),
                  if (canExit) Divider(indent: 20, endIndent: 20),
                  if (canExit)
                    DrawerListTile(icon: Icons.exit_to_app, title: s.exitAction, intent: const ExitIntent()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile<T extends Intent> extends StatelessWidget {
  const DrawerListTile({super.key, required this.icon, required this.title, required this.intent});

  final IconData icon;
  final String title;
  final T intent;

  @override
  Widget build(BuildContext context) => ListTile(
    style: ListTileStyle.drawer,
    iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
    leading: Icon(icon),
    title: Text(title),
    shape: StadiumBorder(),
    visualDensity: VisualDensity.comfortable,
    onTap: Actions.handler(context, intent),
  );
}
