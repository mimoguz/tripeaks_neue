import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/colour_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/decor_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/layout_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/show_all_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/sound_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/start_empty_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/theme_mode_setting.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/group_title.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';
import 'package:tripeaks_neue/widgets/selection_dialog.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';

final class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return Actions(
      actions: <Type, Action<Intent>>{
        SetThemeModeIntent: SetThemeModeAction(),
        SetShowAllIntent: SetShowAllAction(),
        SetStartEmptyIntent: SetStartEmptyAction(),
        SetDecorIntent: SetDecorAction(),
        SetDecorColourIntent: SetDecorColourAction(),
        SetLayoutIntent: SetLayoutAction(),
        SetSoundModeIntent: SetSoundModeAction(),
        ExitIntent: ExitAction(),
        GoBackIntent: GoBackAction(),
      },
      child: Builder(
        builder: (context) {
          return Shortcuts(
            shortcuts: <ShortcutActivator, Intent>{
              SingleActivator(LogicalKeyboardKey.keyQ, control: true): const ExitIntent(),
              SingleActivator(LogicalKeyboardKey.escape): const GoBackIntent(),
              SingleActivator(LogicalKeyboardKey.backspace): const GoBackIntent(saveSettings: true),
            },
            child: SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(s.settingsTitle),
                  backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                  leading: IconButton(
                    icon: const BackButtonIcon(),
                    onPressed: Actions.handler(context, const GoBackIntent(saveSettings: true)),
                  ),
                ),
                body: Focus(
                  focusNode: _focusNode,
                  autofocus: true,
                  skipTraversal: true,
                  descendantsAreFocusable: true,
                  descendantsAreTraversable: true,
                  child: const SettingsPageBody(),
                ),
              ),
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
                            padding: const EdgeInsets.fromLTRB(
                              c.utilPageMargin,
                              c.utilPageMargin,
                              c.utilPageMargin,
                              c.utilPageMargin / 2.0,
                            ),
                            child: GameItems(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: c.utilPageMargin,
                              vertical: c.utilPageMargin / 2.0,
                            ),
                            child: NextGameItems(),
                          ),
                          GroupTitle("Test Group"),
                          SettingTile(
                            title: "Test Settings",
                            showArrow: true,
                            subtitle: "Test value",
                            location: Location.first,
                            onTap: () => _testSelection(context),
                          ),
                          SettingTile(
                            title: "Test Settings",
                            showArrow: false,
                            subtitle: "Test value",
                            location: Location.centre,
                            trailing: Switch(
                              value: false,
                              onChanged: (_) {},
                              thumbIcon: const WidgetStateProperty.fromMap({
                                WidgetState.selected: Icon(Icons.check),
                                WidgetState.any: Icon(Icons.close),
                              }),
                            ),
                          ),
                          SettingTile(
                            title: "Test Settings",
                            showArrow: false,
                            subtitle: "Test value",
                            location: Location.last,
                            trailing: Switch(
                              value: true,
                              onChanged: (_) {},
                              thumbIcon: const WidgetStateProperty.fromMap({
                                WidgetState.selected: Icon(Icons.check),
                                WidgetState.any: Icon(Icons.close),
                              }),
                            ),
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

  void _testSelection(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder:
          (context) => SelectionDialog(
            title: "Select Things",
            options: <String>["Option 1", "Option 2", "Option 3"],
            selected: 1,
          ),
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
      children: const [LayoutSetting(), GroupTileDivider(), StartEmptySetting()],
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
        GroupTileDivider(),
        ThemeModeSetting(),
        GroupTileDivider(),
        ColourSetting(),
        GroupTileDivider(),
        DecorSetting(),
      ],
    );
  }
}
