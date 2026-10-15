import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/ending_card.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

final class const StalledCardAnimated({
  super.key,
  required final SingleGameStatistics stats,
  required final int id,
  required final bool show,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.medium1,
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: show ? StalledCard(key: ValueKey(id), stats: stats) : SizedBox(),
    );
  }
}

final class const StalledCard({super.key, required final SingleGameStatistics stats})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final theme = context.theme;
    return EndingCard(
      width: 260,
      content: Column(
        crossAxisAlignment: .start,
        children: [
          Image.asset("images/empty72.png", width: 72, height: 72),
          // Text(s.clearedCardMessage, style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
          SizedBox(height: 16.0),
          Text("Ran out of moves…", style: theme.textTheme.titleLarge, textAlign: .start),
          SizedBox(height: 4.0),
          Row(
            spacing: 32.0,
            children: [
              Row(
                spacing: 6.0,
                children: [
                  Icon(Icons.star_outline, size: 20.0, color: theme.colorScheme.onSurfaceVariant),
                  Text("${stats.score}"),
                ],
              ),
              Row(
                spacing: 6.0,
                children: [
                  Icon(Icons.link, size: 20.0, color: theme.colorScheme.onSurfaceVariant),
                  Text("${stats.longestChain}"),
                ],
              ),
            ],
          ),
        ],
      ),

      /*
      Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        children: [
          Image.asset("images/empty72.png", width: 72, height: 72),
          const SizedBox(height: c.cardPaddingVertical),
          Row(
            mainAxisAlignment: .center,
            mainAxisSize: .min,
            children: [
              Flexible(
                child: Text(
                  s.stalledCardMessage(score),
                  softWrap: true,
                  style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
                ),
              ),
            ],
          ),
        ],
      ),
      */
      actions: [
        Observer(
          builder: (context) {
            return FilledButton(
              onPressed: Actions.handler(context, const RollbackIntent()),
              style: FilledButton.styleFrom(
                shadowColor: Colors.transparent,
                backgroundColor: theme.colorScheme.primary.withAlpha(200),
              ),
              child: Text(s.stalledCardRollbackAction),
            );
          },
        ),
        FilledButton(
          onPressed: Actions.handler(context, const NewGameIntent()),
          style: FilledButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: theme.colorScheme.primary.withAlpha(200),
          ),
          child: Text(s.stalledCardNewGameAction),
        ),
      ],
    );
  }
}
