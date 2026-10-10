import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/ending_card.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

final class const StalledCardAnimated({
  super.key,
  required final int score,
  required final int id,
  required final bool show,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.medium1,
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: show ? StalledCard(key: ValueKey(id), score: score) : SizedBox(),
    );
  }
}

final class const StalledCard({super.key, required final int score}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final theme = context.theme;
    return EndingCard(
      width: 290,
      content: Column(
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
      actions: [
        Observer(
          builder: (context) {
            return TextButton(
              onPressed: Actions.handler(context, const RollbackIntent()),
              child: Text(s.stalledCardRollbackAction),
            );
          },
        ),
        TextButton(
          onPressed: Actions.handler(context, const NewGameIntent()),
          child: Text(s.stalledCardNewGameAction),
        ),
      ],
    );
  }
}
