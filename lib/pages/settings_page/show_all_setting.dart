import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:tripeaks_neue/pages/settings_page/multi_state_switch.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ShowAllSetting extends StatelessWidget {
  const ShowAllSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    return SettingTile(
      title: Text(s.showAllControl),
      control: Observer(
        builder: (context) {
          return MultiStateSwitch(
            selected: session.showAll ? 1 : 0,
            onChange: (index) => Actions.handler(context, SetShowAllIntent(index == 1))?.call(),
            optionIcons: <Widget>[Icon(Peaks.showAllOff20, size: 20), Icon(Peaks.showAllOn20, size: 20)],
          );
        },
      ),
      value: Observer(builder: (context) => Text(session.showAll.toString())),
    );
  }
}
