import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/list_tile.dart';
import 'package:tripeaks_neue/widgets/widget_group.dart';

class SoundSetting extends StatelessWidget {
  const SoundSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = AppLocalizations.of(context)!;
    return WidgetGroup(
      title: Text(s.soundControl),
      control: Observer(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyListTile(
                leading: Radio<bool>(
                  value: false,
                  groupValue: settings.soundOn,
                  visualDensity: VisualDensity.compact,
                  onChanged: (value) => Actions.handler(context, SetSoundModeIntent(value!))?.call(),
                ),
                title: Text(s.soundMutedLabel),
                onTap: () => Actions.handler(context, SetSoundModeIntent(false))?.call(),
              ),
              MyListTile(
                leading: Radio<bool>(
                  value: true,
                  groupValue: settings.soundOn,
                  visualDensity: VisualDensity.compact,
                  onChanged: (value) => Actions.handler(context, SetSoundModeIntent(value!))?.call(),
                ),
                title: Text(s.soundOnLabel),
                onTap: () => Actions.handler(context, SetSoundModeIntent(true))?.call(),
              ),
            ],
          );
        },
      ),
    );
  }
}
