import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/selection_dialog.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';

class ThemeModeSetting extends StatelessWidget {
  const ThemeModeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = AppLocalizations.of(context)!;
    return Observer(
      builder: (context) {
        return SettingTile(
          title: s.themeModeControl,
          location: Location.centre,
          onTap: () => _showSelection(context, settings),
          subtitle: _valueLabel(settings.themeMode, s),
          showArrow: true,
        );
      },
    );
  }

  Future<void> _showSelection(BuildContext context, Settings settings) async {
    final s = AppLocalizations.of(context)!;
    final result = await showDialog<int>(
      context: context,
      barrierColor: Colors.transparent,
      builder:
          (context) => SelectionDialog(
            title: s.themeModeControl,
            selected: settings.themeMode.index,
            options: ThemeMode.values.map((e) => _valueLabel(e, s)).toList(),
          ),
    );
    if (result != null && result >= 0) {
      settings.themeMode = ThemeMode.values[result];
    }
  }

  String _valueLabel(ThemeMode value, AppLocalizations s) => switch (value) {
    ThemeMode.system => s.systemThemeModeLabel,
    ThemeMode.light => s.lightThemeModeLabel,
    ThemeMode.dark => s.darkThemeModeLabel,
  };
}
