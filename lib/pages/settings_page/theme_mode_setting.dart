import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';
import 'package:tripeaks_neue/widgets/selection_dialog.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';

class ThemeModeSetting extends StatelessWidget {
  const ThemeModeSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = context.strings;
    return Observer(
      builder: (context) {
        return SettingTile(
          titleText: s.themeModeControl,
          location: Location.centre,
          onTap: () => _showSelection(context, settings),
          subtitle: _valueLabel(settings.themeMode, s),
          showArrow: true,
        );
      },
    );
  }

  Future<void> _showSelection(BuildContext context, Settings settings) async {
    final s = context.strings;
    final result = await showCommonBottomSheet<ThemeMode>(
      context,
      (context) => MySelectionSheet(
        title: Text(s.themeModeTitle),
        selected: settings.themeMode,
        values: ThemeMode.values,
        itemBuilder: (v) => Text(_valueLabel(v, s)),
      ),
    );
    if (result != null) {
      settings.themeMode = result;
    }
  }

  String _valueLabel(ThemeMode value, AppLocalizations s) => switch (value) {
    ThemeMode.system => s.systemThemeModeLabel,
    ThemeMode.light => s.lightThemeModeLabel,
    ThemeMode.dark => s.darkThemeModeLabel,
  };
}
