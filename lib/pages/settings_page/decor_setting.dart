import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_dialog.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';
import 'package:tripeaks_neue/widgets/show_dialog.dart';
import 'package:tripeaks_neue/widgets/variant_card.dart';

class const DecorSetting({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = context.strings;
    final colours = context.colours;
    return Observer(
      builder: (context) {
        return SettingTile(
          titleText: s.decorControl,
          location: Location.last,
          onTap: () => _showSelection(context, settings),
          subtitle: settings.decor.label(s),
          showArrow: true,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClipOval(
              child: Container(
                width: _boxWidth,
                height: _boxHeight,
                color: colours.surfaceContainerHighest,
                child: Transform.translate(
                  offset: _iconOffset,
                  child: Icon(settings.decor.icon, size: 116, color: colours.onSurfaceVariant),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSelection(BuildContext context, Settings settings) async {
    final s = context.strings;
    final result = await showCommonBottomSheet<int>(
      context,
      (context) => MyBottomSheet(
        title: Text(s.decorTitle, overflow: .fade, softWrap: false, maxLines: 1),
        content: Padding(
          padding: c.DialogMetrics.contentPadding,
          child: Wrap(
            runSpacing: 4,
            spacing: 4,
            children: [
              for (final (index, decor) in Decor.values.indexed)
                DecorVariantCard(
                  decor: decor,
                  colour: settings.decorColour,
                  isSelected: settings.decor == decor,
                  selectedDecorColour: settings.decorColour,
                  strings: s,
                  onTap: () => Navigator.pop(context, index),
                ),
            ],
          ),
        ),
      ),
    );
    if (result != null && result >= 0) {
      settings.decor = Decor.values[result];
    }
  }

  static const _boxWidth = 32.0;
  static const _boxHeight = 32.0;
  static const _iconOffset = Offset((c.cardSize - _boxWidth) / -2.0, (c.cardSize - _boxHeight) / -2.0);
}

final class const DecorVariantCard({
  super.key,
  required final Decor decor,
  required final DecorColour colour,
  required final bool isSelected,
  required final DecorColour selectedDecorColour,
  required final AppLocalizations strings,
  required final VoidCallback onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VariantCard<Decor>(
      variant: decor,
      selectedBackground: colour.background,
      selectedForeground: colour.controlForeground,
      isSelected: isSelected,
      label: decor.label(strings),
      onTap: onTap,
      child: Icon(decor.icon, size: 80),
    );
  }
}
