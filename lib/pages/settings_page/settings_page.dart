import 'package:flutter/material.dart';
import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/decor_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/layout_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/show_all_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/start_empty_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/theme_mode_setting.dart';
import 'package:tripeaks_neue/pages/shared/item_container.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return Actions(
      actions: <Type, Action<Intent>>{
        SetThemeModeIntent: SetThemeModeAction(),
        SetShowAllIntent: SetShowAllAction(),
        SetStartEmptyIntent: SetStartEmptyAction(),
        SetDecorIntent: SetDecorAction(),
        SetLayoutIntent: SetLayoutAction(),
      },
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(appBar: AppBar(title: Text(s.settingsTitle)), body: const SettingsPageBody()),
          );
        },
      ),
    );
  }
}

final class SettingsPageBody extends StatelessWidget {
  const SettingsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            color: Theme.of(context).colorScheme.surfaceContainerLow,
            child: const Center(
              child: Column(
                children: [
                  CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverPadding(padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0), sliver: GameItems()),

                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        sliver: NextGameItems(),
                      ),

                      SliverPadding(padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0), sliver: UiItems()),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class GameItems extends StatelessWidget {
  const GameItems({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(child: SettingsGroupCard(children: [ShowAllSetting()]));
  }
}

class NextGameItems extends StatelessWidget {
  const NextGameItems({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SettingsGroupCard(title: "Next Game", children: [StartEmptySetting(), LayoutSetting()]),
    );
  }
}

class UiItems extends StatelessWidget {
  const UiItems({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverToBoxAdapter(
      child: SettingsGroupCard(title: "Interface", children: [ThemeModeSetting(), Divider(), DecorSetting()]),
    );
  }
}

class SettingsGroupCard extends StatelessWidget {
  const SettingsGroupCard({super.key, this.title, required this.children});

  final List<Widget> children;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return ListItemContainer(
      child: Card(
        color: colours.surfaceContainer,
        surfaceTintColor: colours.surfaceTint,
        elevation: 1.0,
        shadowColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
          child: Column(
            spacing: 8.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Text(
                    title!,
                    style: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.outline),
                  ),
                ),
              for (final child in children) child,
            ],
          ),
        ),
      ),
    );
  }
}
