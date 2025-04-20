import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/statistics_page/order.dart';
import 'package:tripeaks_neue/pages/statistics_page/result_chip.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/widgets/list_tile.dart';

final class GameEntry extends StatelessWidget {
  const GameEntry({super.key, required this.place, required this.game, this.showLayout = true});

  final int place;
  final SingleGameStatistics game;
  final bool showLayout;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return MyListTile(
      leading: place > 0 ? Order(place) : null,
      title: Text(_dateFormat.format(game.ended), style: theme.textTheme.titleSmall),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      subtitle: Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        spacing: 12.0,
        children: <Widget>[if (showLayout) Text(game.layout.label(s)), ResultChip(game)],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 4,
        children: <Widget>[
          Text(game.score.toString(), style: theme.textTheme.titleMedium),
          Icon(CustomIcons.star16, size: 16, color: theme.colorScheme.outline),
        ],
      ),
    );
  }

  static final _dateFormat = DateFormat("d MMMM y, HH:mm");
}
