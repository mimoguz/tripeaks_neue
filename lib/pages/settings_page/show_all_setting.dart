import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';

final class ShowAllSetting extends StatelessWidget {
  const ShowAllSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    return Observer(
      builder: (context) {
        return SettingTile(
          title: s.showAllControl,
          location: Location.only,
          onTap: () => session.showAll = !session.showAll,
          subtitle: session.showAll ? s.showAllOnLabel : s.showAllOffLabel,
          trailing: Switch(
            value: session.showAll,
            onChanged: (v) => session.showAll = v,
            thumbIcon: const WidgetStateProperty.fromMap({
              WidgetState.selected: Icon(CustomIcons.visible16),
              WidgetState.any: Icon(CustomIcons.invisible16),
            }),
          ),
          showArrow: false,
        );
      },
    );
  }
}
