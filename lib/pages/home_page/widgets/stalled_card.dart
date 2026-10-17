import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/ending_card.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

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
      width: 250,
      content: Column(
        crossAxisAlignment: .center,
        children: [
          Image.asset("images/empty72.png", width: 72, height: 72),
          // Text(s.clearedCardMessage, style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
          SizedBox(height: 16.0),
          Text(s.stalledCardMessage, style: theme.textTheme.titleMedium, textAlign: .start),
          SizedBox(height: 4.0),
          HighlightsLine(stats: stats),
        ],
      ),
      actions: [
        Observer(
          builder: (context) {
            return FilledButton(
              onPressed: Actions.handler(context, const RollbackIntent()),

              child: Text(s.stalledCardRollbackAction),
            );
          },
        ),
        FilledButton(
          onPressed: Actions.handler(context, const NewGameIntent()),

          child: Text(s.stalledCardNewGameAction),
        ),
      ],
    );
  }
}
