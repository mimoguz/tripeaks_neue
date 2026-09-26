import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/card_value.dart';
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
          titleText: "Suit icons",
          location: Location.centre,
          onTap: () => _showSelection(context, settings),
          subtitle: _valueLabel(settings.suitIconTheme, s),
          showArrow: true,
        );
      },
    );
  }

  // TODO. Strings
  Future<void> _showSelection(BuildContext context, Settings settings) async {
    final s = context.strings;
    final result = await showDialog<int>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (context) => CommonDialog(
        title: Text("Suit icons"),
        content: Padding(
          padding: const EdgeInsets.symmetric(horizontal: c.dialogPadding * 0.5),
          child: Wrap(
            spacing: 16.0,
            runSpacing: 16.0,
            children: [
              for (final (index, variant) in SuitIconTheme.values.indexed)
                SuitVariantItem(
                  variant: variant,
                  isSelected: settings.suitIconTheme == variant,
                  onTap: () => Navigator.pop(context, index),
                ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, -1),
            style: TextButton.styleFrom(foregroundColor: context.colours.error),
            child: Text(s.cancelAction),
          ),
        ],
      ),
    );
    if (result != null && result >= 0 && result < SuitIconTheme.values.length) {
      settings.suitIconTheme = SuitIconTheme.values[result];
    }
  }

  String _valueLabel(SuitIconTheme value, AppLocalizations s) => switch (value) {
    .variant1 => "Dark",
    .variant2 => "Thin",
    .variant3 => "Hair",
  };
}

class const SuitVariantItem({
  super.key,
  required final SuitIconTheme variant,
  required final bool isSelected,
  final VoidCallback? onTap,
}) extends StatefulWidget {
  @override
  State<SuitVariantItem> createState() => _SuitVariantItemState();
}

class _SuitVariantItemState extends State<SuitVariantItem> {
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
    final colours = context.colours;
    _borderColour = _focus.hasFocus ? colours.onSurface : colours.surfaceBright;
    return SizedBox(
      width: c.cardSize,
      height: c.cardSize,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: c.commonBorderRadius,
          focusNode: _focus,
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: _borderColour!),
              borderRadius: c.commonBorderRadius,
              color: widget.isSelected ? colours.primary : colours.secondaryContainer,
            ),
            child: Stack(
              children: [
                Positioned(
                  left: _padding,
                  top: _padding,
                  child: Icon(
                    CustomIcons.suitIcon(.hearts, widget.variant),
                    size: 40,
                    color: widget.isSelected ? colours.onPrimary : colours.tertiary,
                  ),
                ),
                Positioned(
                  right: _padding,
                  top: _padding,
                  child: Icon(
                    CustomIcons.suitIcon(.spades, widget.variant),
                    size: 40,
                    color: widget.isSelected ? colours.onPrimary : colours.onSurfaceVariant,
                  ),
                ),
                Positioned(
                  bottom: _padding,
                  left: _padding,
                  child: Icon(
                    CustomIcons.suitIcon(.clubs, widget.variant),
                    size: 40,
                    color: widget.isSelected ? colours.onPrimary : colours.onSurfaceVariant,
                  ),
                ),
                Positioned(
                  bottom: _padding,
                  right: _padding,
                  child: Icon(
                    CustomIcons.suitIcon(.diamonds, widget.variant),
                    size: 40,
                    color: widget.isSelected ? colours.onPrimary : colours.tertiary,
                  ),
                ),
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

  static const _padding = 12.0;
}
