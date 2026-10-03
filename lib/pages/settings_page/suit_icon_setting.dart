import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/selection_dialog.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';

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
    final result = await showAdaptiveDialog<int>(
      context: context,
      barrierColor: context.colours.barrier,
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
}

class const SuitVariantRow(final SuitIconTheme variant, final bool selected, {super.key})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    final black = selected ? colours.onSecondaryContainer : colours.onSurfaceVariant;
    final red = selected ? colours.tertiary : colours.tertiary.withAlpha(240);
    return Padding(
      padding: _padding,
      child: Row(
        spacing: 3.0,
        mainAxisAlignment: .start,
        children: [
          Icon(CustomIcons.suitIcon(.hearts, variant), size: _size, color: red),
          Icon(CustomIcons.suitIcon(.diamonds, variant), size: _size, color: red),
          Padding(
            padding: const EdgeInsets.only(right: _diamondFix),
            child: Icon(CustomIcons.suitIcon(.spades, variant), size: _size, color: black),
          ),
          Icon(CustomIcons.suitIcon(.clubs, variant), size: _size, color: black),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Text(_valueLabel(variant, context.strings), overflow: .fade, maxLines: 1),
            ),
          ),
        ],
      ),
    );
  }

  static const _size = 30.0;
  static const _diamondFix = 3.0;
  static const _padding = EdgeInsets.symmetric(vertical: 2);
}

String _valueLabel(SuitIconTheme value, AppLocalizations s) => switch (value) {
  .variant1 => s.suitIconVariant1Label,
  .variant2 => s.suitIconVariant2Label,
  .variant3 => s.suitIconVariant3Label,
  .variant4 => s.suitIconVariant4Label,
};
