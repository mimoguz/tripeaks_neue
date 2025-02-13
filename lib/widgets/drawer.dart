import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                style: Theme.of(context).textTheme.titleLarge,
                children: [
                  TextSpan(
                    text: " NEUE",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontVariations: [FontVariation("wght", 200)],
                      letterSpacing: 4.0,
                      color: colours.outlineVariant,
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
                  leading: const Icon(Peaks.newGame),
                  title: Text(s.newGameAction),
                  shape: StadiumBorder(),
                  visualDensity: VisualDensity.comfortable,
                  onTap: Actions.handler(context, const NewGameIntent()),
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  iconColor: iconColour,
                  leading: const Icon(Peaks.pickAndPlay),
                  title: Text(s.newGameWithLayoutAction),
                  shape: StadiumBorder(),
                  visualDensity: VisualDensity.comfortable,
                  onTap: () {},
                ),
                ListTile(
                  style: ListTileStyle.drawer,
                  iconColor: iconColour,
                  leading: const Icon(Icons.restart_alt),
                  title: Text(s.restartGameAction),
                  shape: StadiumBorder(),
                  visualDensity: VisualDensity.comfortable,
                  onTap: () {},
                ),
                Divider(color: colours.outlineVariant, indent: 20, endIndent: 20),
                ListTile(
                  style: ListTileStyle.drawer,
                  iconColor: iconColour,
                  leading: const Icon(Icons.bar_chart),
                  title: Text(s.statisticsAction),
                  visualDensity: VisualDensity.comfortable,
                  shape: StadiumBorder(),
                  onTap: () {},
                ),
                Divider(color: colours.outlineVariant, indent: 20, endIndent: 20),
                ListTile(
                  style: ListTileStyle.drawer,
                  iconColor: iconColour,
                  leading: const Icon(Icons.exit_to_app),
                  title: Text(s.exitAction),
                  shape: StadiumBorder(),
                  visualDensity: VisualDensity.comfortable,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
