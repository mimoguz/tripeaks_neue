import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';

class StalledCardAnimated extends StatelessWidget {
  const StalledCardAnimated({super.key, required this.score, required this.id, required this.show});

  final int score;
  final int id;
  final bool show;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.medium1,
      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
      child: show ? StalledCard(key: ValueKey(id), score: score) : SizedBox(),
    );
  }
}

final class StalledCard extends StatelessWidget {
  const StalledCard({super.key, required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return Card.filled(
      color: Theme.of(context).colorScheme.surfaceContainer.withAlpha(235),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 14.0,
            children: [
              Image.asset("images/empty.png", width: 90, height: 90),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Text(
                      "Unfortunately, you ran out of moves. How do you want to proceed?",
                      softWrap: true,
                    ),
                  ),
                ],
              ),

              Observer(
                builder: (context) {
                  return TextButton(
                    onPressed: Actions.handler(context, const RollbackIntent()),
                    child: Text("Undo last move"),
                  );
                },
              ),
              TextButton(
                onPressed: Actions.handler(context, const NewGameIntent()),
                child: Text(s.newGameButtonLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
