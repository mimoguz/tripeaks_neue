import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/multi_state_switch.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/settings.dart';

class ThemeModeSetting extends StatelessWidget {
  const ThemeModeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = AppLocalizations.of(context)!;
    return SettingTile(
      title: Text(s.themeModeControl),
      control: Observer(
        builder: (context) {
          return MultiStateSwitch(
            selected: settings.themeMode.index,
            onChange:
                (index) => Actions.handler(context, SetThemeModeIntent(ThemeMode.values[index]))?.call(),
            optionIcons: <Widget>[
              Icon(CustomIcons.themeModeAuto, size: 20),
              Icon(CustomIcons.themeModeLight, size: 20),
              Icon(CustomIcons.themeModeDark, size: 20),
            ],
          );
        },
      ),
      value: Observer(builder: (context) => Text(_valueLabel(settings.themeMode, s))),
    );
  }

  String _valueLabel(ThemeMode value, AppLocalizations s) => switch (value) {
    ThemeMode.system => s.systemThemeModeLabel,
    ThemeMode.light => s.lightThemeModeLabel,
    ThemeMode.dark => s.darkThemeModeLabel,
  };
}
