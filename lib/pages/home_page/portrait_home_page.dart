import 'dart:math';

import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/card_paceholder.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/board.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/card_counter.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/cards.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/pages/home_page/widgets/fireworks.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/game_button.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/stock.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class PortraitHomePage extends StatelessWidget {
  const PortraitHomePage({super.key});

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
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 24.0 * scale,
                    children: [
                      Observer(
                        builder: (context) {
                          return PortraitHomePageBoard(
                            game: game,
                            scale: scale,
                            showInactive: session.showAll,
                          );
                        },
                      ),
                      Observer(
                        builder: (context) {
                          return PortraitHomePageRightArea(
                            game: game,
                            scale: scale,
                            showInactive: session.showAll,
                          );
                        },
                      ),
                      PortraitHomePageCounter(game: game, scale: scale),
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
    final sx = (mediaSize.width - 2 * c.pagePadding) / c.requiredHeight;
    final sy = (mediaSize.height - 2 * c.pagePadding) / c.requiredWidth;
    return min(1.0, min(sx, sy));
  }
}

final class PortraitHomePageBoard extends StatelessWidget {
  const PortraitHomePageBoard({
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
            (context) => Row(
              children: [
                game.isCleared
                    ? Fireworks(
                      key: ValueKey(game.started.millisecondsSinceEpoch),
                      color: Theme.of(context).colorScheme.primary,
                      duration: Durations.long4,
                      id: game.started.millisecondsSinceEpoch,
                    )
                    : PortraitBoard(game: game, scale: scale, showInactive: showInactive),
              ],
            ),
      ),
    );
  }
}

class PortraitHomePageCounter extends StatelessWidget {
  const PortraitHomePageCounter({super.key, required this.game, required this.scale});

  final Game game;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Observer(
            builder:
                (context) => RotatedBox(
                  quarterTurns: 3,
                  child: CardCounter(maxCount: game.layout.cardCount, count: game.remaining),
                ),
          ),
        ),
      ],
    );
  }
}

class PortraitHomePageRightArea extends StatelessWidget {
  const PortraitHomePageRightArea({
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
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
                        ? CardPlaceHolder(scale: scale)
                        : FittedBox(
                          child: TileCard(
                            game.discard.last
                              ..open()
                              ..put(),
                            showInactive: showInactive,
                            orientation: Orientation.portrait,
                          ),
                        ),
          ),
        ),
        Spacer(),
        PortraitStock(game, scale: scale, showValues: showInactive),
        Observer(
          builder:
              (context) => GameButton.wide(
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
