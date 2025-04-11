import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';

final class SoundSetting extends StatelessWidget {
  const SoundSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = AppLocalizations.of(context)!;
    return Observer(
      builder: (context) {
        return SettingTile(
          title: s.soundControl,
          location: Location.first,
          onTap: () => settings.setSoundOn(!settings.soundOn),
          subtitle: settings.soundOn ? s.soundOnLabel : s.soundMutedLabel,
          trailing: Switch(
            value: settings.soundOn,
            onChanged: (v) => settings.setSoundOn(v),
            thumbIcon: const WidgetStateProperty.fromMap({
              WidgetState.selected: Icon(Icons.volume_up),
              WidgetState.any: Icon(Icons.volume_off),
            }),
          ),
          showArrow: false,
        );
      },
    );
  }
}
