import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/ending_card.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

class const ClearedCardAnimated({
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
      child: show ? ClearedCard(key: ValueKey(id), score: score) : SizedBox(),
    );
  }
}

final class const ClearedCard({super.key, required final int score}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final theme = context.theme;
    return EndingCard(
      width: 240,
      content: Column(
        mainAxisSize: .min,
        spacing: 12.0,
        children: [
          Image.asset("images/tropy72.png", width: 72, height: 72),
          Text(s.clearedCardMessage, style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
          Row(
            mainAxisSize: .min,
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            spacing: 2,
            children: [
              Icon(Icons.stars, size: 24.0, color: theme.colorScheme.tertiary),
              Text(
                "$score",
                style: theme.textTheme.titleLarge!.copyWith(
                  color: theme.colorScheme.tertiary,
                  fontVariations: [FontVariation("wght", 600)],
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: Actions.handler(context, const NewGameIntent()),
          child: Text(s.clearedCardNewGameAction),
        ),
      ],
    );
  }
}
