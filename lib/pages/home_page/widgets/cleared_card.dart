import 'dart:ui';

import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

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
    return ClipRRect(
      borderRadius: c.commonBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        child: Container(
          color: theme.colorScheme.surfaceContainerLow.withAlpha(210),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 240),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16.0,
                children: [
                  Image.asset("images/tropy.png", width: 90, height: 90),
                  Text(s.clearedCardMessage, style: theme.textTheme.titleLarge, textAlign: TextAlign.center),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                  const Divider(),
                  TextButton(
                    onPressed: Actions.handler(context, const NewGameIntent()),
                    child: Text(s.clearedCardNewGameAction),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
