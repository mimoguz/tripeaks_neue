import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:tripeaks_neue/pages/settings_page/multi_state_switch.dart';
import 'package:tripeaks_neue/pages/shared/item_container.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({super.key, required this.title, required this.control, required this.value});

  final Widget title;
  final Widget control;
  final Widget value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListItemContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0,
          children: [
            DefaultTextStyle(style: textTheme.titleMedium!, child: title),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8.0,
              children: [
                control,
                DefaultTextStyle(
                  style: textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                  child: value,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
