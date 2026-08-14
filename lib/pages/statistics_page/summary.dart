import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/list_tile.dart';

final class Summary extends StatelessWidget {
  const Summary(this.statistics, {super.key});

  final Statistics statistics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trailingStyle = theme.textTheme.bodyMedium;
    final s = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: c.dialogPadding),
      child: Material(
        color: theme.colorScheme.surfaceContainer,
        elevation: 20,
        shadowColor: theme.colorScheme.shadow,
        child: SizedBox(height: 100),
      ),
    );

    return GroupTile(
      children: <Widget>[
        MyListTile(
          title: Text(s.totalPlayedLabel),
          trailing: Text(statistics.totalGames.toString(), style: trailingStyle),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        ),
        MyListTile(
          title: Text(s.totalClearedLabel),
          trailing: Text(statistics.cleared.toString(), style: trailingStyle),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        ),
        MyListTile(
          title: Text(s.bestScoreLabel),
          trailing: Text((statistics.bestGames.firstOrNull?.score ?? 0).toString(), style: trailingStyle),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        ),
        MyListTile(
          title: Text(s.longestChainLabel),
          trailing: Text((statistics.longestChain).toString(), style: trailingStyle),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
        ),
      ],
    );
  }
}

class LastGame extends StatelessWidget {
  const LastGame({super.key, required this.statistics});

  final SingleGameStatistics statistics;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final s = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: c.dialogPadding),
      child: Material(
        color: theme.colorScheme.surfaceContainer,
        elevation: 10,

        shadowColor: theme.colorScheme.shadow,
        child: SizedBox(height: 100),
      ),
    );
  }
}
