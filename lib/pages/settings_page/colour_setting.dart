import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/setting_tile.dart';
import 'package:tripeaks_neue/widgets/translucent_dialog.dart';

class ColourSetting extends StatelessWidget {
  const ColourSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = AppLocalizations.of(context)!;
    return Observer(
      builder: (context) {
        return SettingTile(
          title: s.decorColourControl,
          location: Location.centre,
          onTap: () => _showSelection(context, settings),
          subtitle: settings.decorColour.label(s),
          showArrow: true,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              width: 64.0,
              height: 24.0,
              decoration: BoxDecoration(
                color: settings.decorColour.background,
                borderRadius: c.commonBorderRadius,
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSelection(BuildContext context, Settings settings) async {
    final s = AppLocalizations.of(context)!;
    final result = await showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder:
          (context) => TranslucentDialog(
            title: Text(s.decorColourControl),
            content: Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: [
                for (final (index, colour) in DecorColour.values.indexed)
                  ColourSwatch(
                    colour: colour,
                    isSelected: settings.decorColour == colour,
                    onTap: () => Navigator.pop(context, index),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, -1),
                style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                child: Text(s.cancelAction),
              ),
            ],
          ),
    );
    if (result != null && result >= 0) {
      settings.decorColour = DecorColour.values[result];
    }
  }
}

class ColourSwatch extends StatefulWidget {
  const ColourSwatch({super.key, required this.colour, required this.isSelected, this.onTap});

  final DecorColour colour;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  State<ColourSwatch> createState() => _ColourSwatchState();
}

class _ColourSwatchState extends State<ColourSwatch> {
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
    final colours = Theme.of(context).colorScheme;
    final fill = widget.colour.background;
    final foreground = widget.colour.controlForeground;
    _borderColour = _focus.hasFocus ? colours.onSurface : Colors.transparent;
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        width: 42,
        height: 42,
        child: Stack(
          children: [
            InkWell(
              focusNode: _focus,
              borderRadius: BorderRadius.circular(100),
              onTap: widget.onTap,
              child: Ink(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 2.0, color: _borderColour!),
                  color: fill,
                ),
                child: Center(
                  child: Observer(
                    builder: (context) {
                      return AnimatedSwitcher(
                        duration: Durations.medium1,
                        child:
                            widget.isSelected
                                ? Icon(
                                  Icons.radio_button_checked,
                                  key: const ValueKey("selected"),
                                  color: foreground,
                                )
                                : Icon(
                                  Icons.radio_button_off,
                                  key: const ValueKey("unselected"),
                                  color: foreground,
                                ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onFocusChange() {
    setState(() {
      _borderColour = _focus.hasFocus ? Theme.of(context).colorScheme.onSurface : Colors.transparent;
    });
  }
}
