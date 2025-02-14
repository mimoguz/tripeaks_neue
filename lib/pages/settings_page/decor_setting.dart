import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class DecorSetting extends StatelessWidget {
  const DecorSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;

    return SettingTile(
      title: Text(s.decorControl),
      control: Expanded(
        child: LayoutBuilder(
          builder:
              (context, constraints) => ConstrainedBox(
                constraints: BoxConstraints(maxHeight: c.cardSize, maxWidth: c.cardSize * 3.5),
                child: CarouselView(
                  itemExtent: c.cardSize,
                  scrollDirection: Axis.horizontal,
                  shape: const RoundedRectangleBorder(borderRadius: c.commonBorderRadius),
                  backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                  onTap: (i) => Actions.handler(context, SetDecorIntent(Decor.values[i]))?.call(),
                  children: <Widget>[for (final decor in Decor.values) CarouselItem(decor: decor)],
                ),
              ),
        ),
      ),
    );
  }
}

class CarouselItem extends StatelessWidget {
  const CarouselItem({super.key, required this.decor});

  final Decor decor;

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);

    return SizedBox(
      width: c.cardSize,
      height: c.cardSize,
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
                      (decor == settings.decor)
                          ? Icon(key: ValueKey(true), Icons.radio_button_checked, color: Colors.white)
                          : Icon(key: ValueKey(false), Icons.radio_button_off, color: Colors.white),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  IconData get _decorIcon => switch (decor) {
    Decor.checkered => Peaks.backCheckered,
    Decor.crosshatch => Peaks.backCrossHatch,
    Decor.neue => Peaks.backNeue,
    Decor.ohRain => Peaks.backOhRain,
  };
}
