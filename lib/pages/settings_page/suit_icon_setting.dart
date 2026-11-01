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
                VariantItem(
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

class const VariantItem({
  super.key,
  required final SuitIconTheme variant,
  required final bool isSelected,
  required final AppLocalizations strings,
  final VoidCallback? onTap,
}) extends StatefulWidget {
  @override
  State<VariantItem> createState() => _VariantItemState();
}

class _VariantItemState extends State<VariantItem> {
  final FocusNode _focus = FocusNode();
  Color? _borderColour;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colours = theme.colorScheme;
    final name = widget.variant.label(widget.strings);
    final textColour = widget.isSelected ? colours.onPrimaryContainer : colours.onSurfaceVariant;
    final red = widget.isSelected ? colours.onPrimaryContainer : colours.tertiary;
    _borderColour = _focus.hasFocus ? colours.primary : Colors.transparent;
    return Material(
      color: Colors.transparent,
      borderRadius: c.commonBorderRadius,
      clipBehavior: .antiAlias,
      child: InkWell(
        onTap: widget.onTap,
        focusNode: _focus,
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(width: 4.0, color: _borderColour!),
            borderRadius: c.commonBorderRadius,
            color: widget.isSelected ? colours.primaryContainer : colours.sheetHeader,
          ),

          child: Padding(
            padding: const EdgeInsets.fromLTRB(c.cellPadding, c.cellPadding, c.cellPadding, 0),
            child: Column(
              spacing: 8,
              children: [
                Row(
                  mainAxisSize: .min,
                  spacing: c.cellPadding,
                  children: [
                    Icon(CustomIcons.suitIcon(.hearts, widget.variant), size: 36, color: red),
                    Icon(CustomIcons.suitIcon(.spades, widget.variant), size: 36, color: textColour),
                  ],
                ),
                Row(
                  mainAxisSize: .min,
                  spacing: c.cellPadding,
                  children: [
                    Icon(CustomIcons.suitIcon(.clubs, widget.variant), size: 36, color: textColour),
                    Icon(CustomIcons.suitIcon(.diamonds, widget.variant), size: 36, color: red),
                  ],
                ),
                Text(name, style: theme.textTheme.labelMedium?.copyWith(color: textColour)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onFocusChange() {
    setState(() {
      _borderColour = _focus.hasFocus ? context.colours.onSurface : context.colours.surfaceContainer;
    });
  }
}
