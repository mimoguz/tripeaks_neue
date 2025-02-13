import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/pages/shared/page_title_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final class PageTitle extends StatelessWidget {
  const PageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final colours = Theme.of(context).colorScheme;
    final iconColour = colours.outline;
    return SliverPersistentHeader(
      delegate: PageTitleDelegate(
        title: RichText(
          text: TextSpan(
            text: "TriPeaks ",
            style: Theme.of(context).textTheme.titleLarge,
            children: [TextSpan(text: "NEUE", style: TextStyle(color: colours.tertiary.withAlpha(100)))],
          ),
          overflow: TextOverflow.ellipsis,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.help),
            color: iconColour,
            tooltip: s.infoTooltip,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            color: iconColour,
            tooltip: s.settingsTooltip,
            onPressed: Actions.handler(context, NavigateToSettingsIntent()),
          ),
        ],
      ),
      pinned: true,
    );
  }
}
