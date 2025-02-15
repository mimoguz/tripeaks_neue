import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/my_dropdown_button.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/settings.dart';

class ThemeModeSetting extends StatelessWidget {
  const ThemeModeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = AppLocalizations.of(context)!;
    return HorizontalSettingTile(
      title: Text(s.themeModeControl),
      control: Observer(
        builder: (context) {
          return SizedBox(
            child: MyDropdownButton<ThemeMode>(
              value: settings.themeMode,
              items: [
                for (final mode in ThemeMode.values)
                  DropdownMenuItem(value: mode, child: DropdownItemText(text: _valueLabel(mode, s))),
              ],
              onChanged: (value) => Actions.handler(context, SetThemeModeIntent(value!))?.call(),
            ),
          );
        },
      ),
    );
  }

  String _valueLabel(ThemeMode value, AppLocalizations s) => switch (value) {
    ThemeMode.system => s.systemThemeModeLabel,
    ThemeMode.light => s.lightThemeModeLabel,
    ThemeMode.dark => s.darkThemeModeLabel,
  };
}
