import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/widgets/list_tile.dart';
import 'package:tripeaks_neue/widgets/selection_dialog.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';
import 'package:tripeaks_neue/widgets/widget_group.dart';

class LayoutSetting extends StatelessWidget {
  const LayoutSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    return Observer(
      builder: (context) {
        return SettingTile(
          title: s.layoutControl,
          location: Location.first,
          onTap: () => _showSelection(context, session),
          subtitle: session.layout.label(s),
          showArrow: true,
        );
      },
    );
  }

  Future<void> _showSelection(BuildContext context, Session session) async {
    final s = AppLocalizations.of(context)!;
    final result = await showDialog(
      context: context,
      builder:
          (context) => SelectionDialog(
            title: s.layoutControl,
            selected: session.layout.index,
            options: Peaks.values.map((e) => e.label(AppLocalizations.of(context)!)).toList(),
          ),
    );
    if (result >= 0) {
      session.layout = Peaks.values[result];
    }
  }
}
