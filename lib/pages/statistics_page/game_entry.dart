import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/statistics_page/result_chip.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
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
      leftSpacing: c.cardPaddingHorizontal,
      title: Text(_dateFormat.format(game.ended), style: theme.textTheme.titleSmall),
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 6),
      subtitle: Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        spacing: 8.0,
        children: <Widget>[ResultChip(game), if (showLayout) Text(game.layout.label(s))],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: c.cardPaddingHorizontal - 2.0,
        children: <Widget>[
          Text(game.score.toString(), style: theme.textTheme.titleMedium),
          Icon(CustomIcons.star16, size: 16, color: theme.colorScheme.onSurfaceVariant),
        ],
      ),
    );
  }

  static final _dateFormat = DateFormat("d MMMM y, HH:mm");
}

final class Order extends StatelessWidget {
  const Order(this.value, {super.key});

  final int value;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(color: colours.onSurfaceVariant, shape: BoxShape.circle),
      width: 24.0,
      height: 24.0,
      child: Center(
        child: Text(value.toString(), style: _style.copyWith(color: colours.surfaceContainerHigh)),
      ),
    );
  }

  static const _style = TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600, letterSpacing: -1.0);
}
