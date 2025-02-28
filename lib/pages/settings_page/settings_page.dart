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
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

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
                          Padding(padding: EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0), child: GameItems()),

                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                            child: NextGameItems(),
                          ),

                          Padding(padding: EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0), child: UiItems()),
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

class GameItems extends StatelessWidget {
  const GameItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GroupTile(children: [ShowAllSetting()]);
  }
}

class NextGameItems extends StatelessWidget {
  const NextGameItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GroupTile(title: "Next Game", children: [LayoutSetting(), Divider(), StartEmptySetting()]);
  }
}

class UiItems extends StatelessWidget {
  const UiItems({super.key});

  @override
  Widget build(BuildContext context) {
    return GroupTile(
      title: AppLocalizations.of(context)!.interfaceSettingGroupTitle,
      children: const [SoundSetting(), Divider(), ThemeModeSetting(), Divider(), DecorSetting()],
    );
  }
}
