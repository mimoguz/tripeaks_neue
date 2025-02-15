import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class DecorSetting extends StatefulWidget {
  const DecorSetting({super.key});

  @override
  State<DecorSetting> createState() => _DecorSettingState();
}

class _DecorSettingState extends State<DecorSetting> {
  final CarouselController _controller = CarouselController();

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;

    return VerticalSettingTile(
      title: Text(s.decorControl),
      control: Expanded(
        child: LayoutBuilder(
          builder:
              (context, constraints) => Wrap(
                spacing: 12.0,
                runSpacing: 12.0,
                children: <Widget>[for (final decor in Decor.values) CarouselItem(decor: decor)],
              ),
        ),
      ),
    );
  }
}

class CarouselItem extends StatefulWidget {
  const CarouselItem({super.key, required this.decor});

  final Decor decor;

  @override
  State<CarouselItem> createState() => _CarouselItemState();
}

class _CarouselItemState extends State<CarouselItem> {
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
      borderRadius: c.commonBorderRadius,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: c.cardSize,
        height: c.cardSize,
        child: InkWell(
          borderRadius: c.commonBorderRadius,
          onTap: _onTap,
          focusNode: _focus,
          child: Observer(
            builder: (context) {
              return Stack(
                children: [
                  Icon(_decorIcon, size: c.cardSize, color: Colors.white30),
                  Positioned(
                    left: 8.0,
                    top: 6.0,
                    child: AnimatedSwitcher(
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

  IconData get _decorIcon => switch (widget.decor) {
    Decor.checkered => CustomIcons.backCheckered,
    Decor.crosshatch => CustomIcons.backCrossHatch,
    Decor.neue => CustomIcons.backNeue,
    Decor.ohRain => CustomIcons.backOhRain,
  };

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
}
