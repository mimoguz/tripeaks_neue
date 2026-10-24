import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/common_popover.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/wrapping_popover.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';

class const ColourSetting({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = context.strings;
    return Observer(
      builder: (context) {
        return SettingTile(
          titleText: s.decorColourControl,
          location: Location.centre,
          onTap: (context) => _showSelection(context, settings),
          subtitle: settings.decorColour.label(s),
          showArrow: true,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(color: settings.decorColour.background, shape: .circle),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSelection(BuildContext context, Settings settings) async {
    final result = await showCommonPopover<DecorColour>(
      context,
      width: 430,
      semanticsLabel: context.strings.decorColourControl,
      (context) => WrappingPopover(
        width: 430,
        values: DecorColour.values,
        selected: settings.decorColour,
        itemBuilder: (v, s) => ColourSwatch(
          colour: v,
          s: s,
          isSelected: settings.decorColour == v,
          onTap: () {
            Navigator.pop(context, v);
          },
        ),
      ),
    );
    if (result != null) {
      settings.decorColour = result;
    }
  }
}

class const ColourSwatch({
  super.key,
  required final DecorColour colour,
  required final bool isSelected,
  required final AppLocalizations s,
  final VoidCallback? onTap,
}) extends StatefulWidget {
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
    final fill = widget.colour.background;
    final foreground = widget.colour.controlForeground;
    _borderColour = _focus.hasFocus ? context.colours.onSurface : Colors.transparent;
    return Tooltip(
      message: widget.colour.label(widget.s),
      child: Material(
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
                    child: AnimatedSwitcher(
                      duration: Durations.medium1,
                      child: widget.isSelected
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFocusChange() {
    setState(() {
      _borderColour = _focus.hasFocus ? context.colours.onSurface : Colors.transparent;
    });
  }
}
