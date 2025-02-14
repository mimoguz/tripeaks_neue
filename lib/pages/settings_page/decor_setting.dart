import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class DecorSetting extends StatelessWidget {
  const DecorSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    return SettingTile(
      title: Text(s.showAllControl),
      control: Observer(
        builder: (context) {
          return Row(
            children: [
              SizedBox(
                width: c.cardSize * 2,
                height: c.cardSize,
                child: CarouselView(
                  itemExtent: c.cardSize,
                  children: const <Widget>[
                    Icon(Peaks.backCheckered, size: c.cardSize),
                    Icon(Peaks.backCrossHatch, size: c.cardSize),
                    Icon(Peaks.backNeue, size: c.cardSize),
                    Icon(Peaks.backOhRain, size: c.cardSize),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
