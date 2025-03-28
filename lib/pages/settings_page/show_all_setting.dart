import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/widgets/list_tile.dart';
import 'package:tripeaks_neue/widgets/widget_group.dart';

class ShowAllSetting extends StatelessWidget {
  const ShowAllSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    return WidgetGroup(
      title: Text(s.showAllControl),
      child: Observer(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyListTile(
                leading: Radio<bool>(
                  value: false,
                  groupValue: session.showAll,
                  visualDensity: VisualDensity.compact,
                  onChanged: (value) => Actions.handler(context, SetShowAllIntent(value!))?.call(),
                ),
                title: Text(s.showAllOffLabel),
                onTap: () => Actions.handler(context, SetShowAllIntent(false))?.call(),
              ),
              MyListTile(
                leading: Radio<bool>(
                  value: true,
                  groupValue: session.showAll,
                  visualDensity: VisualDensity.compact,
                  onChanged: (value) => Actions.handler(context, SetShowAllIntent(value!))?.call(),
                ),
                title: Text(s.showAllOnLabel),
                onTap: () => Actions.handler(context, SetShowAllIntent(true))?.call(),
              ),
            ],
          );
        },
      ),
    );
  }
}
