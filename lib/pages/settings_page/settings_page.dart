import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/pages/settings_page/decor_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/section_header.dart';
import 'package:tripeaks_neue/pages/settings_page/show_all_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/start_empty_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/theme_mode_setting.dart';
import 'package:tripeaks_neue/pages/shared/item_container.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';

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
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverPadding(padding: EdgeInsets.symmetric(horizontal: 12.0), sliver: GameItems()),
                  SectionHeader(title: "Next Game"),
                  SliverPadding(padding: EdgeInsets.symmetric(horizontal: 12.0), sliver: NextGameItems()),
                  SectionHeader(title: "Interface"),
                  SliverPadding(padding: EdgeInsets.symmetric(horizontal: 12.0), sliver: UiItems()),
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
    return SliverList.list(children: const <Widget>[ListItemContainer(child: ShowAllSetting())]);
  }
}

class NextGameItems extends StatelessWidget {
  const NextGameItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(children: const <Widget>[ListItemContainer(child: StartEmptySetting())]);
  }
}

class UiItems extends StatelessWidget {
  const UiItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: const <Widget>[
        ListItemContainer(child: ThemeModeSetting()),
        ListItemContainer(child: DecorSetting()),
      ],
    );
  }
}
