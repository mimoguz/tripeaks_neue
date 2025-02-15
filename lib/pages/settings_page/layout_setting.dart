import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/dropdown_item_container.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class LayoutSetting extends StatelessWidget {
  const LayoutSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    return HorizontalSettingTile(
      title: Text(s.themeModeControl),
      control: Observer(
        builder: (context) {
          return SizedBox(
            child: DropdownButton<Peaks>(
              value: session.layout,
              elevation: 0,
              dropdownColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: c.commonBorderRadius,
              underline: SizedBox(),
              items: [
                for (final layout in Peaks.values)
                  DropdownMenuItem(value: layout, child: DropDownItemContainer(text: _valueLabel(layout, s))),
              ],
              onChanged: (value) => Actions.handler(context, SetLayoutIntent(value!))?.call(),
            ),
          );
        },
      ),
    );
  }

  String _valueLabel(Peaks value, AppLocalizations s) => switch (value) {
    Peaks.threePeaks => "Three peaks",
    Peaks.diamonds => "Diamonds",
    Peaks.valley => "Valley",
  };
}
