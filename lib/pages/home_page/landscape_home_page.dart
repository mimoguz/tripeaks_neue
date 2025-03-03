import 'dart:math';

import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/board.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/card_counter.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/card_placeholder.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/cards.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/cleared_card.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/game_button.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/stalled_card.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/stock.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/swipe_area.dart';
import 'package:tripeaks_neue/stores/data/back_options.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class LandscapeHomePage extends StatelessWidget {
  const LandscapeHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scale = _scale(MediaQuery.sizeOf(context));
    final session = Provider.of<Session>(context);
    final settings = Provider.of<Settings>(context);
    return Observer(
      builder: (context) {
        final game = session.game;
        final back = BackOptions(showValue: session.showAll, decor: settings.decor.icon);
        return Actions(
          actions: <Type, Action<Intent>>{
            TakeIntent: TakeAction(game, settings.sounds),
            DrawIntent: DrawAction(game, settings.sounds),
            RollbackIntent: RollbackAction(game, settings.sounds),
          },
          child: Builder(
            builder: (context) {
              return Container(
                color: Theme.of(context).colorScheme.surfaceContainerLow,
                child: Padding(
                  padding: EdgeInsets.all((24.0 * scale).roundToDouble()),
                  child: Stack(
                    children: [
                      SwipeArea(intent: const DrawIntent()),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 24.0 * scale,
                        children: [
                          LandscapeHomePageBoard(game: game, scale: scale, back: back),
                          LandscapeHomePageCounter(game: game, scale: scale),
                          LandscapeHomePageBottomArea(game: game, scale: scale, back: back),
                        ],
                      ),
                      Center(
                        child: Observer(
                          builder: (context) {
                            return ClearedCardAnimated(
                              id: game.started.millisecondsSinceEpoch,
                              score: game.score,
                              show: game.isCleared,
                            );
                          },
                        ),
                      ),
                      Center(
                        child: Observer(
                          builder: (context) {
                            return StalledCardAnimated(
                              score: game.score,
                              id: game.started.millisecondsSinceEpoch + 1,
                              show: game.isStalled,
                            );
                          },
                        ),
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
  const LandscapeHomePageBoard({super.key, required this.game, required this.scale, required this.back});

  final Game game;
  final double scale;
  final BackOptions back;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [LandscapeBoard(game: game, scale: scale, back: back)],
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
    return IgnorePointer(
      child: Row(
        children: [
          Expanded(
            child: Observer(
              builder: (context) => CardCounter(maxCount: game.layout.cardCount, count: game.remaining),
            ),
          ),
        ],
      ),
    );
  }
}

class LandscapeHomePageBottomArea extends StatelessWidget {
  const LandscapeHomePageBottomArea({super.key, required this.game, required this.scale, required this.back});

  final Game game;
  final double scale;
  final BackOptions back;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 16.0 * scale,
      children: [
        CircleGameButton(
          scale: scale,
          icon: CustomIcons.menu,
          smallIcon: CustomIcons.menu16,
          tooltip: s.menuTooltip,
          onPressed: () => Scaffold.of(context).openDrawer(),
          // onPressed: () => Navigator.of(context).push(createRoute(() => const MenuPage())),
        ),
        Observer(
          builder:
              (context) => CircleGameButton(
                scale: scale,
                icon: CustomIcons.undo,
                smallIcon: CustomIcons.undo16,
                tooltip: s.undoTooltip,
                onPressed: Actions.handler(context, const RollbackIntent()),
              ),
        ),
        IgnorePointer(
          child: SizedBox(
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
                              back: back,
                              orientation: Orientation.landscape,
                            ),
                          ),
            ),
          ),
        ),
        Spacer(),
        IgnorePointer(child: LandscapeStock(game, scale: scale, back: back)),
        Observer(
          builder:
              (context) => GameButton.narrow(
                scale: scale,
                icon: CustomIcons.draw,
                smallIcon: CustomIcons.draw16,
                tooltip: s.drawTooltip,
                onPressed: Actions.handler(context, const DrawIntent()),
              ),
        ),
      ],
    );
  }
}
