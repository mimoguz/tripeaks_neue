import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/list_tile.dart';

class ThemeModeSetting extends StatelessWidget {
  const ThemeModeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = AppLocalizations.of(context)!;
    final radioTextStyle = TextStyle(fontSize: 14.0);
    return VerticalSettingTile(
      title: Text(s.themeModeControl),
      control: Observer(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final mode in ThemeMode.values)
                MyListTile(
                  leading: Radio<ThemeMode>(
                    value: mode,
                    visualDensity: VisualDensity.compact,
                    groupValue: settings.themeMode,
                    onChanged: (value) => Actions.handler(context, SetThemeModeIntent(value!))?.call(),
                  ),
                  title: Text(_valueLabel(mode, s), style: radioTextStyle),
                  onTap: () => Actions.handler(context, SetThemeModeIntent(mode))?.call(),
                ),
            ],
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
