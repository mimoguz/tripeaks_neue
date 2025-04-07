import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/widget_group.dart';

class DecorSetting extends StatefulWidget {
  const DecorSetting({super.key});

  @override
  State<DecorSetting> createState() => _DecorSettingState();
}

class _DecorSettingState extends State<DecorSetting> {
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
                  children: <Widget>[for (final decor in Decor.values) DecorItem(decor: decor)],
                ),
              ),
            ),
      ),
    );
  }
}

class DecorItem extends StatefulWidget {
  const DecorItem({super.key, required this.decor});

  final Decor decor;

  @override
  State<DecorItem> createState() => _DecorItemState();
}

class _DecorItemState extends State<DecorItem> {
  final FocusNode _focus = FocusNode();
  Color? _fill;

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
    _fill = _focus.hasFocus ? colours.tertiaryContainer : colours.onSecondaryFixed;
    return Material(
      color: _fill,
      borderRadius: _borderRadius,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: _sideLength,
        height: _sideLength,
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: _onTap,
          focusNode: _focus,
          child: Observer(
            builder: (context) {
              return Stack(
                children: [
                  Icon(widget.decor.icon, size: _sideLength, color: Colors.white30),
                  Positioned(
                    left: 2.0,
                    top: 2.0,
                    child: Builder(
                      builder: (context) {
                        return AnimatedSwitcher(
                          duration: Durations.medium2,
                          child:
                              (widget.decor == settings.decor)
                                  ? Icon(
                                    key: ValueKey((widget.decor, true)),
                                    Icons.radio_button_checked,
                                    color: Colors.white,
                                  )
                                  : Icon(
                                    key: ValueKey((widget.decor, false)),
                                    Icons.radio_button_off,
                                    color: Colors.white,
                                  ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _onFocusChange() {
    setState(() {
      _fill =
          _focus.hasFocus
              ? Theme.of(context).colorScheme.tertiaryContainer
              : Theme.of(context).colorScheme.secondaryContainer;
    });
  }

  void _onTap() {
    Actions.handler(context, SetDecorIntent(widget.decor))?.call();
    _focus.requestFocus();
  }

  static const _borderRadius = BorderRadius.all(Radius.circular(c.commonRadius * 0.85));
  static const _sideLength = c.cardSize * 0.75;
}
