import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/session.dart';

class StartEmptySetting extends StatelessWidget {
  const StartEmptySetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    final radioTextStyle = TextStyle(fontSize: 14.0);
    return VerticalSettingTile(
      title: Text(s.startEmptyControl),
      control: Observer(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                selected: !session.startEmpty,
                leading: Radio<bool>(
                  value: false,
                  groupValue: session.startEmpty,
                  onChanged: (value) => Actions.handler(context, SetStartEmptyIntent(value!))?.call(),
                ),
                title: Text(s.startEmptyOffLabel, style: radioTextStyle),
                onTap: () => Actions.handler(context, SetStartEmptyIntent(false))?.call(),
              ),
              ListTile(
                selected: session.startEmpty,
                leading: Radio<bool>(
                  value: true,
                  groupValue: session.startEmpty,
                  onChanged: (value) => Actions.handler(context, SetStartEmptyIntent(value!))?.call(),
                ),
                title: Text(s.startEmptyOnLabel, style: radioTextStyle),
                onTap: () => Actions.handler(context, SetStartEmptyIntent(true))?.call(),
              ),
            ],
          );
        },
      ),
    );
  }
}
