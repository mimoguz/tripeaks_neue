import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/card_value.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/selection_dialog.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';

// TODO: Strings
class const SuitIconSetting({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = context.strings;
    return Observer(
      builder: (context) {
        return SettingTile(
          titleText: "Suit icons",
          location: Location.centre,
          onTap: () => _showSelection(context, settings),
          subtitle: _valueLabel(settings.suitIconTheme, s),
          showArrow: true,
        );
      },
    );
  }

  Future<void> _showSelection(BuildContext context, Settings settings) async {
    final s = context.strings;
    final result = await showDialog<int>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (context) => SelectionDialog(
        title: "Suit icons",
        selected: settings.suitIconTheme,
        options: [SuitIcons(variant: 0), SuitIcons(variant: 1), SuitIcons(variant: 2)],
      ),
    );
    if (result != null && result >= 0 && result < 3) {
      settings.suitIconTheme = result;
    }
  }

  String _valueLabel(int value, AppLocalizations s) => switch (value) {
    1 => "Thin",
    2 => "Hair",
    _ => "Dark",
  };
}

class const SuitIcons({required this.variant, super.key}) extends StatelessWidget {
  final int variant;

  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    return Row(
      spacing: 4,
      children: [
        Icon(CustomIcons.suitIcon(Suit.hearts, variant), color: colours.tertiary, size: 40),
        Icon(CustomIcons.suitIcon(Suit.diamonds, variant), color: colours.tertiary, size: 40),
        Icon(CustomIcons.suitIcon(Suit.spades, variant), color: colours.onSurfaceVariant, size: 40),
        SizedBox(width: 2),
        Icon(CustomIcons.suitIcon(Suit.clubs, variant), color: colours.onSurfaceVariant, size: 40),
      ],
    );
  }
}
