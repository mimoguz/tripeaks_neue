import 'dart:io';

import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final iconColour = colours.outline;
    final s = AppLocalizations.of(context)!;
    return Drawer(
      surfaceTintColor: colours.surfaceTint,
      width: 360.0,
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.zero)),
      clipBehavior: Clip.antiAlias,
      child: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            pinned: true,
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
                      color: colours.outline,
                      fontVariations: [FontVariation("wght", 200)],
                    ),
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
            leading: CloseButton(),
            actions: [
              IconButton(icon: const Icon(Icons.help), tooltip: s.infoTooltip, onPressed: () {}),
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
                ListTile(
                  style: ListTileStyle.drawer,
                  iconColor: iconColour,
                  leading: const Icon(CustomIcons.newGame),
                  title: Text(s.newGameAction),
                  shape: StadiumBorder(),
                  visualDensity: VisualDensity.comfortable,
                  onTap: Actions.handler(context, const NewGameIntent()),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  iconColor: iconColour,
                  leading: const Icon(CustomIcons.pickAndPlay),
                  title: Text(s.newGameWithLayoutAction),
                  shape: StadiumBorder(),
                  visualDensity: VisualDensity.comfortable,
                  onTap: Actions.handler(context, const NewGameWithLayoutIntent()),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  iconColor: iconColour,
                  leading: const Icon(Icons.restart_alt),
                  title: Text(s.restartGameAction),
                  shape: StadiumBorder(),
                  visualDensity: VisualDensity.comfortable,
                  onTap: Actions.handler(context, const RestartIntent()),
                ),
                Divider(color: colours.outlineVariant, indent: 20, endIndent: 20),
                ListTile(
                  style: ListTileStyle.drawer,
                  iconColor: iconColour,
                  leading: const Icon(Icons.bar_chart),
                  title: Text(s.statisticsAction),
                  visualDensity: VisualDensity.comfortable,
                  shape: StadiumBorder(),
                  onTap: Actions.handler(context, const NavigateToStatisticsIntent()),
                ),
                if (!Platform.isIOS) Divider(color: colours.outlineVariant, indent: 20, endIndent: 20),
                if (!Platform.isIOS)
                  ListTile(
                    style: ListTileStyle.drawer,
                    iconColor: iconColour,
                    leading: const Icon(Icons.exit_to_app),
                    title: Text(s.exitAction),
                    shape: StadiumBorder(),
                    visualDensity: VisualDensity.comfortable,
                    onTap: Actions.handler(context, const ExitIntent()),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
