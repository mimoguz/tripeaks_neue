import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/ending_card.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

class const ClearedCardAnimated({
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
      child: show ? ClearedCard(key: ValueKey(id), stats: stats) : SizedBox(),
    );
  }
}

final class const ClearedCard({super.key, required final SingleGameStatistics stats})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final theme = context.theme;
    final colours = theme.colorScheme;
    final gradient = LinearGradient(
      colors: <Color>[colours.primary, colours.tertiary],
      begin: .bottomLeft,
      end: .topRight,
    ).createShader(Rect.fromLTWH(0, 0, 200, 20));
    return EndingCard(
      width: 250,
      stats: stats,
      image: Image.asset("images/tropy72.png", width: 72, height: 72),
      message: Text(
        s.clearedCardMessage,
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: .w700,
          // color: theme.colorScheme.onSurfaceVariant,
          foreground: Paint()..shader = gradient,
        ),
        textAlign: .start,
      ),
      actions: [
        FilledButton(
          onPressed: Actions.handler(context, const NewGameIntent()),
          style: FilledButton.styleFrom(
            shadowColor: Colors.transparent,
            backgroundColor: theme.colorScheme.primary.withAlpha(200),
          ),
          child: Text(s.clearedCardNewGameAction),
        ),
      ],
    );
  }
}
