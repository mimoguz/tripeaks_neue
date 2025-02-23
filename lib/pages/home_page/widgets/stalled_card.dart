import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

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
    return ClipRRect(
      borderRadius: c.commonBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
        child: Container(
          color: Theme.of(context).colorScheme.surfaceContainerLow.withAlpha(200),
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("images/empty.png", width: 90, height: 90),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        s.stalledCardMessage(score),
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Observer(
                  builder: (context) {
                    return TextButton(
                      onPressed: Actions.handler(context, const RollbackIntent()),
                      child: Text(s.stalledCardRollbackAction),
                    );
                  },
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: Actions.handler(context, const NewGameIntent()),
                  child: Text(s.stalledCardNewGameAction),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
