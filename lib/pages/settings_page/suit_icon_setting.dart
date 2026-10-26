import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';
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
    final result = await showCommonDialog<SuitIconTheme>(
      context,
      (context) => MySelectionDialog<SuitIconTheme>(
        title: Text(s.suitIconsControl),
        selected: settings.suitIconTheme,
        values: SuitIconTheme.values,
        itemBuilder: (v) => SuitVariantRow(v, v == settings.suitIconTheme, s),
      ),
    );
    if (result != null) {
      settings.suitIconTheme = result;
    }
  }
}

class const SuitVariantRow(
  final SuitIconTheme variant,
  final bool selected,
  final AppLocalizations s, {
  super.key,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    final black = colours.onSurfaceVariant;
    final red = colours.tertiary;
    return Padding(
      padding: _padding,
      child: Row(
        mainAxisAlignment: .start,
        spacing: 2.0,
        children: [
          Icon(CustomIcons.suitIcon(.hearts, variant), size: _size, color: red),
          Icon(CustomIcons.suitIcon(.diamonds, variant), size: _size, color: red),
          Icon(CustomIcons.suitIcon(.spades, variant), size: _size, color: black),
          Icon(CustomIcons.suitIcon(.clubs, variant), size: _size, color: black),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 4.0),
              child: Text(_valueLabel(variant, s), overflow: .fade, maxLines: 1),
            ),
          ),
        ],
      ),
    );
  }

  static const _size = 36.0;
  static const _padding = EdgeInsets.symmetric(vertical: 3);
}

String _valueLabel(SuitIconTheme value, AppLocalizations s) => switch (value) {
  .variant1 => s.suitIconVariant1Label,
  .variant2 => s.suitIconVariant2Label,
  .variant3 => s.suitIconVariant3Label,
  .variant4 => s.suitIconVariant4Label,
};
