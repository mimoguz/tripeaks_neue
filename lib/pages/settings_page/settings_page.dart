import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/pages/settings_page/colour_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/decor_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/ensure_solvable_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/layout_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/show_all_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/sound_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/start_empty_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/suit_icon_setting.dart';
import 'package:tripeaks_neue/pages/settings_page/theme_mode_setting.dart';
import 'package:tripeaks_neue/util/overlay_style.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/group_title.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

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
    final s = context.strings;
    setOverlayStyleOf(context);
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
              top: false,
              bottom: false,
              child: Scaffold(
                appBar: AppBar(
                  title: Text(s.settingsTitle),
                  backgroundColor: context.colours.surfaceContainerLow,
                  leading: BackButton(
                    onPressed: () => Actions.invoke(context, const GoBackIntent(saveSettings: true)),
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
    final s = context.strings;
    return Column(
      children: [
        Expanded(
          child: Container(
            color: context.colours.surfaceContainerLow,
            child: Center(
              child: Column(
                children: [
                  Flexible(
                    child: ScrollIndicator(
                      child: ListView(
                        shrinkWrap: true,
                        padding: c.utilPageInsets,
                        children: [
                          const ShowAllSetting(),
                          GroupTitle(s.nextGameSettingGroupTitle),
                          const LayoutSetting(),
                          const StartEmptySetting(),
                          const EnsureSolvableSetting(),
                          GroupTitle(s.interfaceSettingGroupTitle),
                          const SoundSetting(),
                          const ThemeModeSetting(),
                          const SuitIconSetting(),
                          const ColourSetting(),
                          const DecorSetting(),
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
