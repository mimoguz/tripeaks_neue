import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/widgets/list_tile.dart';
import 'package:tripeaks_neue/widgets/widget_group.dart';

class LayoutSetting extends StatelessWidget {
  const LayoutSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    final radioTextStyle = TextStyle(fontSize: 14.0);
    return WidgetGroup(
      title: Text(s.layoutControl),
      child: Observer(
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
                  title: Text(layout.label(s), style: radioTextStyle),
                  onTap: () => Actions.handler(context, SetLayoutIntent(layout))?.call(),
                ),
            ],
          );
        },
      ),
    );
  }
}
