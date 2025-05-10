import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';

final class EnsureSolvableSetting extends StatelessWidget {
  const EnsureSolvableSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;
    return Observer(
      builder: (context) {
        return SettingTile(
          title: s.ensureSolvableControl,
          location: Location.last,
          onTap: () => session.ensureSolvable = !session.ensureSolvable,
          subtitle: session.ensureSolvable ? s.ensureSolvableOnLabel : s.ensureSolvableOffLabel,
          trailing: Switch(
            value: session.ensureSolvable,
            onChanged: (v) => session.ensureSolvable = v,
            thumbIcon: const WidgetStateProperty.fromMap({
              WidgetState.selected: Icon(CustomIcons.algorithm16),
              WidgetState.any: Icon(CustomIcons.random16),
            }),
          ),
          showArrow: false,
        );
      },
    );
  }
}
