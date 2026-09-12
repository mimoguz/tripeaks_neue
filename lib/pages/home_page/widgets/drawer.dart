import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final s = AppLocalizations.of(context)!;
    final canExit = !(kIsWeb || kIsWasm || Platform.isIOS);
    final borderRadius = (kIsWeb || kIsWasm || Platform.isLinux)
        ? BorderRadius.all(Radius.zero)
        : BorderRadiusDirectional.horizontal(end: Radius.circular(c.commonRadius));
    return Drawer(
      surfaceTintColor: colours.surfaceTint,
      elevation: 10.0,
      shadowColor: colours.shadow,
      width: 340.0,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      clipBehavior: Clip.antiAlias,
      child: ScrollIndicator(
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              pinned: true,
              backgroundColor: colours.surfaceContainerLow,
              foregroundColor: colours.onSurfaceVariant,
              iconTheme: IconThemeData(color: colours.onSurfaceVariant),
              titleSpacing: 0,
              centerTitle: true,
              actionsPadding: EdgeInsets.symmetric(horizontal: 8.0),
              title: AppTitle(),
              leading: const CloseButton(),
              actions: [
                IconButton(
                  icon: const Icon(Icons.help),
                  tooltip: s.infoTooltip,
                  onPressed: () => Actions.invoke(context, const NavigateToInfoIntent(replace: false)),
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
                IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: s.settingsTooltip,
                  onPressed: () => Actions.invoke(context, const NavigateToSettingsIntent(replace: false)),
                ),
              ],
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
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
                  const Divider(indent: 20, endIndent: 20),
                  DrawerListTile(
                    icon: Icons.bar_chart,
                    title: s.statisticsAction,
                    intent: const NavigateToStatisticsIntent(),
                  ),
                  if (canExit) const Divider(indent: 20, endIndent: 20),
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

class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final style = TextStyle(
      fontFamily: "Peckish",
      fontSize: 13,
      color: colours.onSurfaceVariant,
      fontWeight: .w300,
    );
    final peak = colours.brightness == .dark ? "-" : "*";
    final neue = style.copyWith(color: colours.tertiary);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(Size.fromWidth(170.0)),
        child: Semantics(
          label: "TriPeaks NEUE",
          hint: "Application title",
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(peak, style: style),
              Text(peak, style: style),
              Text(peak, style: style),
              Text("N", style: neue),
              Text("E", style: neue),
              Text("U", style: neue),
              Text("E", style: neue),
            ],
          ),
        ),
      ),
    );
  }
}

class const DrawerListTile<T extends Intent> ({super.key, required final IconData icon, required final String title, required final T intent}) extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      style: .drawer,
      iconColor: Theme.of(context).colorScheme.onSurfaceVariant,
      leading: Icon(icon),
      title: Text(title),
      shape: StadiumBorder(),
      onTap: () => Actions.invoke<T>(context, intent),
    );
  }
}
