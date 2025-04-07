import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/widget_group.dart';

class ColourSetting extends StatefulWidget {
  const ColourSetting({super.key});

  @override
  State<ColourSetting> createState() => _ColourSettingState();
}

class _ColourSettingState extends State<ColourSetting> {
  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final settings = Provider.of<Settings>(context);

    return WidgetGroup(
      title: Text(s.decorControl),
      subtitle: Observer(builder: (context) => Text(settings.decor.name(s))),
      child: LayoutBuilder(
        builder:
            (context, constraints) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Center(
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: <Widget>[for (final colour in DecorColour.values) ColourSwatch(colour: colour)],
                ),
              ),
            ),
      ),
    );
  }
}

class ColourSwatch extends StatefulWidget {
  const ColourSwatch({super.key, required this.colour});

  final DecorColour colour;

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
    final settings = Provider.of<Settings>(context);
    final colours = Theme.of(context).colorScheme;
    final fill =
        colours.brightness == Brightness.dark ? widget.colour.darkBackground : widget.colour.lightBackground;
    final foreground =
        colours.brightness == Brightness.dark
            ? widget.colour.darkControlForeground
            : widget.colour.lightControlForeground;
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
              onTap: _onTap,
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
                            widget.colour == settings.decorColour
                                ? Icon(
                                  Icons.radio_button_checked,
                                  key: ValueKey("selected"),
                                  color: foreground,
                                )
                                : Icon(
                                  Icons.radio_button_off,
                                  key: ValueKey("unselected"),
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
      _borderColour = _focus.hasFocus ? Theme.of(context).colorScheme.tertiaryContainer : Colors.transparent;
    });
  }

  void _onTap() {
    Actions.handler(context, SetDecorColourIntent(widget.colour))?.call();
    _focus.requestFocus();
  }
}
