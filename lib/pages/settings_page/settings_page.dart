import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
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
                slivers: [SliverPadding(padding: EdgeInsets.all(12.0), sliver: SettingsItems())],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class SettingsItems extends StatelessWidget {
  const SettingsItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: const <Widget>[
        ListItemContainer(child: ThemeModeSetting()),
        Padding(padding: EdgeInsets.only(top: 16.0), child: ListItemContainer(child: ShowAllSetting())),
        Padding(padding: EdgeInsets.only(top: 16.0), child: ListItemContainer(child: StartEmptySetting())),
      ],
    );
  }
}
