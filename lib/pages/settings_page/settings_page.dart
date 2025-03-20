import 'package:flutter/material.dart';
import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/decor_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/layout_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/show_all_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/sound_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/start_empty_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/theme_mode_setting.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

final class SettingsPage extends StatelessWidget {
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
        SetSoundModeIntent: SetSoundModeAction(),
      },
      child: Builder(
        builder: (context) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(s.settingsTitle),
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
              ),
              body: const SettingsPageBody(),
            ),
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
            child: Center(
              child: Column(
                children: [
                  Flexible(
                    child: ScrollIndicator(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              c.utilPageMargin,
                              c.utilPageMargin * 2,
                              c.utilPageMargin,
                              c.utilPageMargin / 2.0,
                            ),
                            child: GameItems(),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: c.utilPageMargin,
                              vertical: c.utilPageMargin / 2.0,
                            ),
                            child: NextGameItems(),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                              c.utilPageMargin,
                              c.utilPageMargin / 2.0,
                              c.utilPageMargin,
                              c.utilPageMargin,
                            ),
                            child: UiItems(),
                          ),
                        ],
                      ),
                    ),
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

final class GameItems extends StatelessWidget {
  const GameItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GroupTile(children: [ShowAllSetting()]);
  }
}

final class NextGameItems extends StatelessWidget {
  const NextGameItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GroupTile(
      title: AppLocalizations.of(context)!.nextGameSettingGroupTitle,
      children: const [LayoutSetting(), GroupDivider(), StartEmptySetting()],
    );
  }
}

final class UiItems extends StatelessWidget {
  const UiItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GroupTile(
      title: AppLocalizations.of(context)!.interfaceSettingGroupTitle,
      children: const <Widget>[
        SoundSetting(),
        GroupDivider(),
        ThemeModeSetting(),
        GroupDivider(),
        DecorSetting(),
      ],
    );
  }
}

class GroupDivider extends StatelessWidget {
  const GroupDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.only(bottom: 8.0), child: Divider());
  }
}
