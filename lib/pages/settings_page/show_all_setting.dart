import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/my_dropdown_button.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/session.dart';

class ShowAllSetting extends StatelessWidget {
  const ShowAllSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    return HorizontalSettingTile(
      title: Text(s.showAllControl),
      control: Observer(
        builder: (context) {
          return MyDropdownButton<bool>(
            value: session.showAll,
            items: [
              DropdownMenuItem(value: false, child: DropdownItemText(text: s.showAllOffLabel)),
              DropdownMenuItem(value: true, child: DropdownItemText(text: s.showAllOnLabel)),
            ],
            onChanged: (value) => Actions.handler(context, SetShowAllIntent(value!))?.call(),
          );
        },
      ),
    );
  }
}
