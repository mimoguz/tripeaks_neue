import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
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
          titleText: s.suitIconsControl,
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
        title: s.suitIconsControl,
        selected: settings.suitIconTheme.index,
        options: SuitIconTheme.values
            .map((variant) => SuitVariantRow(variant, variant == settings.suitIconTheme))
            .toList(),
      ),
    );
    if (result != null && result >= 0 && result < SuitIconTheme.values.length) {
      settings.suitIconTheme = SuitIconTheme.values[result];
    }
  }

  String _valueLabel(SuitIconTheme value, AppLocalizations s) => switch (value) {
    .variant1 => s.suitIconVariant1Label,
    .variant2 => s.suitIconVariant2Label,
    .variant3 => s.suitIconVariant3Label,
  };
}

class const SuitVariantRow(final SuitIconTheme variant, final bool selected, {super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    final black = selected ? colours.onPrimary : colours.onSecondaryContainer;
    final red = selected ? colours.onPrimary : colours.tertiary;
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Material(
        borderRadius: c.commonBorderRadius,
        color: selected ? colours.primary : colours.secondaryContainer,
        child: Ink(
          child: Padding(
            padding: c.cardPadding,
            child: Row(
              spacing: c.itemSpacing,
              children: [
                Icon(CustomIcons.suitIcon(.hearts, variant), size: 40, color: red),
                Icon(CustomIcons.suitIcon(.diamonds, variant), size: 40, color: red),
                Padding(
                  padding: const EdgeInsets.only(right: 3.0),
                  child: Icon(CustomIcons.suitIcon(.spades, variant), size: 40, color: black),
                ),
                Icon(CustomIcons.suitIcon(.clubs, variant), size: 40, color: black),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
