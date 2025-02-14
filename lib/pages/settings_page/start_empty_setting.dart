import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/multi_state_switch.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/session.dart';

class StartEmptySetting extends StatelessWidget {
  const StartEmptySetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    return SettingTile(
      title: Text(s.startEmptyControl),
      control: Observer(
        builder: (context) {
          return MultiStateSwitch(
            selected: session.startEmpty ? 1 : 0,
            onChange: (index) => Actions.handler(context, SetStartEmptyIntent(index == 1))?.call(),
            optionIcons: <Widget>[
              Icon(Peaks.emptyDiscardOff20, size: 20),
              Icon(Peaks.emptyDiscardOn20, size: 20),
            ],
          );
        },
      ),
      value: Observer(builder: (context) => Text(session.startEmpty.toString())),
    );
  }
}
