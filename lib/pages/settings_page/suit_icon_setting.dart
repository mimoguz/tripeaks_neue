import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_dialog.dart';
import 'package:tripeaks_neue/widgets/show_dialog.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';
import 'package:tripeaks_neue/widgets/variant_card.dart';

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
          subtitle: settings.suitIconTheme.label(s),
          showArrow: true,
        );
      },
    );
  }

  Future<void> _showSelection(BuildContext context, Settings settings) async {
    final s = context.strings;
    final result = await showCommonBottomSheet<SuitIconTheme>(
      context,
      (context) => MyBottomSheet(
        title: Text(s.decorTitle, overflow: .fade, softWrap: false, maxLines: 1),
        content: Padding(
          padding: c.DialogMetrics.contentPadding,
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              for (final variant in SuitIconTheme.values)
                SuitVariantCard(
                  variant: variant,
                  isSelected: settings.suitIconTheme == variant,
                  strings: s,
                  onTap: () => Navigator.pop(context, variant),
                ),
            ],
          ),
        ),
      ),
    );
    if (result != null) {
      settings.suitIconTheme = result;
    }
  }
}

class const SuitVariantCard({
  super.key,
  required final SuitIconTheme variant,
  required final bool isSelected,
  required final AppLocalizations strings,
  required final VoidCallback onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VariantCard<SuitIconTheme>(
      variant: variant,
      isSelected: isSelected,
      label: variant.label(strings),
      onTap: onTap,
      child: SizedBox(
        width: 80,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Wrap(
            runSpacing: 1,
            children: [
              Icon(CustomIcons.suitIcon(.hearts, variant), size: 36),
              Icon(CustomIcons.suitIcon(.diamonds, variant), size: 36),
              Icon(CustomIcons.suitIcon(.spades, variant), size: 36),
              Icon(CustomIcons.suitIcon(.clubs, variant), size: 36),
            ],
          ),
        ),
      ),
    );
  }
}
