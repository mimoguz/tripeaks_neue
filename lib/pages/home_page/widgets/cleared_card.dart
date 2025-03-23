import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class ClearedCardAnimated extends StatelessWidget {
  const ClearedCardAnimated({super.key, required this.score, required this.id, required this.show});

  final int score;
  final int id;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.medium1,
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: show ? ClearedCard(key: ValueKey(id), score: score) : SizedBox(),
    );
  }
}

final class ClearedCard extends StatelessWidget {
  const ClearedCard({super.key, required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return ClipRRect(
      borderRadius: c.commonBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
        child: Container(
          color: Theme.of(context).colorScheme.surfaceContainerLow.withAlpha(210),
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
                  Text(
                    s.clearedCardMessage,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 2,
                    children: [
                      Icon(Icons.stars, size: 24.0, color: Theme.of(context).colorScheme.tertiary),
                      Text(
                        "$score",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.tertiary,
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
