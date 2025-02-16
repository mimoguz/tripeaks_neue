import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/session.dart';

class ShowAllSetting extends StatelessWidget {
  const ShowAllSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    final radioTextStyle = TextStyle(fontSize: 14.0);
    return VerticalSettingTile(
      title: Text(s.showAllControl),
      control: Observer(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                selected: !session.showAll,
                leading: Radio<bool>(
                  value: false,
                  groupValue: session.showAll,
                  onChanged: (value) => Actions.handler(context, SetShowAllIntent(value!))?.call(),
                ),
                title: Text(s.showAllOffLabel, style: radioTextStyle),
                onTap: () => Actions.handler(context, SetShowAllIntent(false))?.call(),
              ),
              ListTile(
                selected: session.showAll,
                leading: Radio<bool>(
                  value: true,
                  groupValue: session.showAll,
                  onChanged: (value) => Actions.handler(context, SetShowAllIntent(value!))?.call(),
                ),
                title: Text(s.showAllOnLabel, style: radioTextStyle),
                onTap: () => Actions.handler(context, SetShowAllIntent(true))?.call(),
              ),
            ],
          );
        },
      ),
    );
  }
}
