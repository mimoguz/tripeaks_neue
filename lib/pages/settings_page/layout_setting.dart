import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/settings_page/setting_tile.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/widgets/list_tile.dart';

class LayoutSetting extends StatelessWidget {
  const LayoutSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    final radioTextStyle = TextStyle(fontSize: 14.0);
    return VerticalSettingTile(
      title: Text(s.layoutControl),
      control: Observer(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final layout in Peaks.values)
                MyListTile(
                  leading: Radio<Peaks>(
                    value: layout,
                    groupValue: session.layout,
                    visualDensity: VisualDensity.compact,
                    onChanged: (value) => Actions.handler(context, SetLayoutIntent(value!))?.call(),
                  ),
                  title: Text(_valueLabel(layout, s), style: radioTextStyle),
                  onTap: () => Actions.handler(context, SetLayoutIntent(layout))?.call(),
                ),
            ],
          );
        },
      ),
    );
  }

  String _valueLabel(Peaks value, AppLocalizations s) => switch (value) {
    Peaks.threePeaks => s.threePeaksLayoutLabel,
    Peaks.diamonds => s.diamondsLayoutLabel,
    Peaks.valley => s.valleyLayoutLabel,
    Peaks.upDown => s.upDownLayoutLabel,
  };
}
