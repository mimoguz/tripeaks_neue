import 'dart:math';

import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/board.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/card_counter.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/cards.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/fireworks.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/game_button.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/stock.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class LandscapeHomePage extends StatelessWidget {
  const LandscapeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = _scale(MediaQuery.sizeOf(context));
    final session = Provider.of<Session>(context);
    return Observer(
      builder: (context) {
        final game = session.game;
        return Actions(
          actions: <Type, Action<Intent>>{
            TakeIntent: TakeAction(game),
            DrawIntent: DrawAction(game),
            RollbackIntent: RollbackAction(game),
          },
          child: Builder(
            builder: (context) {
              return Container(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                child: Padding(
                  padding: EdgeInsets.all((24.0 * scale).roundToDouble()),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 24.0 * scale,
                    children: [
                      Observer(
                        builder: (context) {
                          return LandscapeHomePageBoard(
                            game: game,
                            scale: scale,
                            showInactive: session.showAll,
                          );
                        },
                      ),
                      LandscapeHomePageCounter(game: game, scale: scale),
                      Observer(
                        builder: (context) {
                          return LandscapeHomePageBottomArea(
                            game: game,
                            scale: scale,
                            showInactive: session.showAll,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  double _scale(Size mediaSize) {
    final sx = (mediaSize.width - 2 * c.pagePadding) / c.requiredWidth;
    final sy = (mediaSize.height - 2 * c.pagePadding) / c.requiredHeight;
    return min(1.0, min(sx, sy));
  }
}

final class LandscapeHomePageBoard extends StatelessWidget {
  const LandscapeHomePageBoard({
    super.key,
    required this.game,
    required this.scale,
    required this.showInactive,
  });

  final Game game;
  final double scale;
  final bool showInactive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Observer(
        builder:
            (context) => Center(
              child:
                  game.isCleared
                      ? Fireworks(
                        key: ValueKey(game.started.millisecondsSinceEpoch),
                        color: Theme.of(context).colorScheme.primary,
                        duration: Durations.long4,
                        id: game.started.millisecondsSinceEpoch,
                      )
                      : LandscapeBoard(game: game, scale: scale, showInactive: showInactive),
            ),
      ),
    );
  }
}

class LandscapeHomePageCounter extends StatelessWidget {
  const LandscapeHomePageCounter({super.key, required this.game, required this.scale});

  final Game game;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Observer(
            builder: (context) => CardCounter(maxCount: game.layout.cardCount, count: game.remaining),
          ),
        ),
      ],
    );
  }
}

class LandscapeHomePageBottomArea extends StatelessWidget {
  const LandscapeHomePageBottomArea({
    super.key,
    required this.game,
    required this.scale,
    required this.showInactive,
  });

  final Game game;
  final double scale;
  final bool showInactive;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 16.0 * scale,
      children: [
        CircleGameButton(
          scale: scale,
          icon: Peaks.menu,
          smallIcon: Peaks.menu16,
          tooltip: s.menuTooltip,
          onPressed: () => Scaffold.of(context).openDrawer(),
          // onPressed: () => Navigator.of(context).push(createRoute(() => const MenuPage())),
        ),
        Observer(
          builder:
              (context) => CircleGameButton(
                scale: scale,
                icon: Peaks.undo,
                smallIcon: Peaks.undo16,
                tooltip: s.undoTooltip,
                onPressed: Actions.handler(context, const RollbackIntent()),
              ),
        ),
        SizedBox(
          width: c.cardSize * scale,
          height: c.cardSize * scale,
          child: Observer(
            builder:
                (context) =>
                    game.discard.isEmpty
                        ? SizedBox(width: c.cardSize, height: c.cardSize)
                        : FittedBox(
                          child: TileCard(
                            game.discard.last
                              ..open()
                              ..put(),
                            showInactive: false,
                            orientation: Orientation.landscape,
                          ),
                        ),
          ),
        ),
        Spacer(),
        LandscapeStock(game, scale: scale, showValues: showInactive),
        Observer(
          builder:
              (context) => GameButton.narrow(
                scale: scale,
                icon: Peaks.draw,
                smallIcon: Peaks.draw16,
                tooltip: s.drawTooltip,
                onPressed: Actions.handler(context, const DrawIntent()),
              ),
        ),
      ],
    );
  }
}
