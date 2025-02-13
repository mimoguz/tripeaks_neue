import 'package:tripeaks_neue/pages/shared/page_title_delegate.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';

final class PageTitle extends StatelessWidget {
  const PageTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final colours = Theme.of(context).colorScheme;
    final iconColour = colours.outline;
    return SliverPersistentHeader(
      delegate: PageTitleDelegate(
        title: Text("Settings ", style: Theme.of(context).textTheme.titleLarge),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.home),
            color: iconColour,
            tooltip: s.homeTooltip,
            onPressed: () {},
          ),
        ],
      ),
      pinned: true,
    );
  }
}
