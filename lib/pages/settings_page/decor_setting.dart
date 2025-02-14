import 'dart:math';

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
          return Expanded(
            child: LayoutBuilder(
              builder:
                  (context, constraints) => ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: c.cardSize, maxWidth: c.cardSize * 3.5),
                    child: CarouselView(
                      itemExtent: c.cardSize,
                      scrollDirection: Axis.horizontal,
                      shape: const RoundedRectangleBorder(borderRadius: c.commonBorderRadius),
                      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
                      children: const <Widget>[
                        Icon(Peaks.backCheckered, size: c.cardSize, color: Colors.white30),
                        Icon(Peaks.backCrossHatch, size: c.cardSize, color: Colors.white30),
                        Icon(Peaks.backNeue, size: c.cardSize, color: Colors.white30),
                        Icon(Peaks.backOhRain, size: c.cardSize, color: Colors.white30),
                      ],
                    ),
                  ),
            ),
          );
        },
      ),
    );
  }
}
