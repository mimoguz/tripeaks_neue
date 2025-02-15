import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/my_dropdown_button.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';

class LayoutSetting extends StatelessWidget {
  const LayoutSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    return HorizontalSettingTile(
      title: Text(s.layoutControl),
      control: Observer(
        builder: (context) {
          return SizedBox(
            child: MyDropdownButton<Peaks>(
              value: session.layout,
              items: [
                for (final layout in Peaks.values)
                  DropdownMenuItem(value: layout, child: DropdownItemText(text: _valueLabel(layout, s))),
              ],
              onChanged: (value) => Actions.handler(context, SetLayoutIntent(value!))?.call(),
            ),
          );
        },
      ),
    );
  }

  String _valueLabel(Peaks value, AppLocalizations s) => switch (value) {
    Peaks.threePeaks => s.threePeaksLayoutLabel,
    Peaks.diamonds => s.diamondsLayoutLabel,
    Peaks.valley => s.valleyLayoutLabel,
  };
}
