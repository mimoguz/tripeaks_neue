import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:tripeaks_neue/pages/settings_page/multi_state_switch.dart';
import 'package:tripeaks_neue/pages/shared/item_container.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ThemeModeSelection extends StatelessWidget {
  const ThemeModeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = AppLocalizations.of(context)!;
    return ListItemContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Observer(
          builder:
              (context) => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8.0,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(s.themeModeControl, style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          settings.themeMode.name,
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                  MultiStateSwitch(
                    selected: settings.themeMode.index,
                    onChange:
                        (index) =>
                            Actions.handler(context, SetThemeModeIntent(ThemeMode.values[index]))?.call(),
                    optionIcons: <Widget>[
                      Icon(Peaks.themeModeAuto, size: 20),
                      Icon(Peaks.themeModeLight, size: 20),
                      Icon(Peaks.themeModeDark, size: 20),
                    ],
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
