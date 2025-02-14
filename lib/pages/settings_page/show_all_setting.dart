import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/pages/settings_page/multi_state_switch.dart';
import 'package:tripeaks_neue/pages/shared/item_container.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ShowAllSetting extends StatelessWidget {
  const ShowAllSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
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
                        Text(s.startEmptyControl, style: Theme.of(context).textTheme.titleMedium),
                        Text(
                          session.showAll.toString(),
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  ),
                  MultiStateSwitch(
                    selected: session.showAll ? 1 : 0,
                    onChange: (index) => Actions.handler(context, SetShowAllIntent(index == 1))?.call(),
                    optionIcons: <Widget>[
                      Icon(Icons.visibility_off, size: 20),
                      Icon(Icons.visibility, size: 20),
                    ],
                  ),
                ],
              ),
        ),
      ),
    );
  }
}
