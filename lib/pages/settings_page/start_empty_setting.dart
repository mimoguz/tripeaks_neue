import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/dropdown_item_container.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class StartEmptySetting extends StatelessWidget {
  const StartEmptySetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    return HorizontalSettingTile(
      title: Text(s.startEmptyControl),
      control: Observer(
        builder: (context) {
          return DropdownButton<bool>(
            value: session.startEmpty,
            elevation: 0,
            dropdownColor: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: c.commonBorderRadius,
            underline: SizedBox(),
            items: [
              DropdownMenuItem(value: false, child: DropDownItemContainer(text: s.startEmptyOffLabel)),
              DropdownMenuItem(value: true, child: DropDownItemContainer(text: s.startEmptyOnLabel)),
            ],
            onChanged: (value) => Actions.handler(context, SetStartEmptyIntent(value!))?.call(),
          );
        },
      ),
    );
  }
}
