import 'dart:math';

import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:tripeaks_neue/stores/data/card_value.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/stores/tile.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

final class TileCard extends StatelessWidget {
  const TileCard(
    this.tile, {
    required this.showInactive,
    super.key,
    this.t = 0.5,
    this.orientation = Orientation.portrait,
  });

  final Tile tile;
  final double t;
  final bool showInactive;
  final Orientation orientation;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        final (dx, dy) = _direction();
        final childKey = ValueKey((tile.isOpen, tile.isVisible, tile.card));
        return AnimatedSwitcher(
          duration: Durations.medium3,
          switchInCurve: Curves.fastOutSlowIn,
          switchOutCurve: Curves.fastOutSlowIn,
          transitionBuilder:
              (child, animation) => SlideTransition(
                position: Tween(begin: Offset(dx, dy), end: Offset.zero).animate(animation),
                child: FadeTransition(opacity: animation, child: child),
              ),
          child:
              !tile.isVisible
                  ? SizedBox(width: c.cardSize, height: c.cardSize, key: childKey)
                  : tile.isOpen
                  ? ActiveCard(tile, key: childKey)
                  : InactiveCard(
                    tile.card,
                    t: (tile.pin.z < 0 ? t : (1.0 / (tile.pin.z + 1)) * 0.6 + 0.4),
                    key: childKey,
                    showFace: showInactive,
                  ),
        );
      },
    );
  }

  (double dx, double dy) _direction() {
    final pin = tile.pin;
    return switch (orientation) {
      Orientation.landscape => (
        pin.index < 0 ? 0.5 : -min(1.0, pin.crossAxis / 10.0),
        pin.index < 0 ? 0.0 : 0.8,
      ),
      Orientation.portrait => (
        pin.index < 0 ? -0.5 : 0.8,
        pin.index < 0 ? 0.0 : -min(1.0, pin.crossAxis / 10.0),
      ),
    };
  }
}

// Shake animation: https://stackoverflow.com/a/62212730, by Vladimir Goldobin
final class ActiveCard extends StatelessWidget {
  const ActiveCard(this.tile, {super.key});

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return SizedBox(
      width: c.cardSize,
      height: c.cardSize,
      child: Material(
        color: colours.secondaryContainer,
        borderRadius: c.commonBorderRadius,
        child: InkWell(
          onTap: tile.pin.index >= 0 ? Actions.handler(context, TakeIntent(tile.pin)) : null,
          borderRadius: c.commonBorderRadius,
          child: Observer(
            builder: (context) {
              final t = tile.lastError?.millisecondsSinceEpoch ?? 0;
              return TweenAnimationBuilder(
                key: ValueKey(t),
                duration: t == 0 ? Duration.zero : Durations.medium4,
                tween: Tween(begin: 0.0, end: 1.0),
                builder:
                    (context, animation, child) =>
                        Transform.translate(offset: Offset(_shake(animation) * 24.0, 0.0), child: child),
                child: ActiveCardFace(tile.card),
              );
            },
          ),
        ),
      ),
    );
  }

  double _shake(double animation) => -2 * (0.5 - (0.5 - Curves.elasticOut.transform(animation)).abs());
}

final class ActiveCardFace extends StatelessWidget {
  const ActiveCardFace(this.card, {super.key});

  final CardValue card;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        spacing: 4.0,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [RankText(card), SuitImage(card)],
      ),
    );
  }
}

final class InactiveCard extends StatelessWidget {
  const InactiveCard(this.cardValue, {super.key, this.t = 0.5, this.showFace = false});

  final double t;
  final CardValue cardValue;
  final bool showFace;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colours = theme.colorScheme;
    return Material(
      color: Color.alphaBlend(
        theme.colorScheme.surface.withValues(alpha: 1.0 - t),
        colours.tertiaryContainer,
      ),
      // color: Color.lerp(
      //   colours.surfaceContainerHigh,
      //   colours.secondaryContainer,
      //   t,
      // ),
      borderRadius: c.commonBorderRadius,
      child: SizedBox(
        width: c.cardSize,
        height: c.cardSize,
        child:
            showFace
                ? Stack(
                  children: [
                    CardBack(t: t),
                    Align(alignment: Alignment.topLeft, child: HorizontalSmallFace(cardValue)),
                    Align(alignment: Alignment.bottomLeft, child: HorizontalSmallFaceAlt(cardValue)),
                  ],
                )
                : CardBack(t: t),
        // : SizedBox(),
      ),
    );
  }
}

final class HorizontalSmallFace extends StatelessWidget {
  const HorizontalSmallFace(this.cardValue, {super.key});

  final CardValue cardValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.0, 8.0, 12.0 - _suitCorrection(cardValue), 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [RankTextSm(cardValue), SuitImageSm(cardValue)],
      ),
    );
  }
}

final class HorizontalSmallFaceAlt extends StatelessWidget {
  const HorizontalSmallFaceAlt(this.cardValue, {super.key});

  final CardValue cardValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.0 - _suitCorrection(cardValue), 8.0, 12.0, 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [SuitImageSm(cardValue), RankTextSm(cardValue)],
      ),
    );
  }
}

class CardBack extends StatelessWidget {
  const CardBack({super.key, this.t = 1.0});

  final double t;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(c.commonRadius - 2.0)),
      child: Observer(
        builder: (context) {
          // TODO: Hoist this up, like showInactive param
          final icon = _decorIcon(Provider.of<Settings>(context).decor);
          return Icon(
            icon,
            size: c.cardSize,
            color: _foreground, // Theme.of(context).colorScheme.surface.withAlpha(38),
          );
        },
      ),
    );
  }

  IconData _decorIcon(Decor decor) => switch (decor) {
    Decor.checkered => Peaks.backCheckered,
    Decor.crosshatch => Peaks.backCrossHatch,
    Decor.neue => Peaks.backNeue,
    Decor.ohRain => Peaks.backOhRain,
  };

  static const _foreground = Color(0x30ffffff);
}

final class RankText extends StatelessWidget {
  const RankText(this.cardValue, {super.key});

  final CardValue cardValue;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final colour = cardValue.suit.isRed ? colours.tertiary : colours.onSurfaceVariant;
    return Baseline(
      baseline: (c.inactiveRankSize * 0.91667).roundToDouble(),
      baselineType: TextBaseline.alphabetic,
      child: Text(
        cardValue.rank.character,
        style: TextStyle(
          fontFamily: "Outfit",
          fontSize: c.activeRankSize,
          color: colour,
          fontVariations: [FontVariation("wght", 400)],
        ),
      ),
    );
  }
}

final class RankTextSm extends StatelessWidget {
  const RankTextSm(this.cardValue, {super.key});

  final CardValue cardValue;

  @override
  Widget build(BuildContext context) {
    // final colour = Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.white70;
    final colour = Colors.white70;
    return Baseline(
      baseline: (c.inactiveRankSize * 0.91667).roundToDouble(),
      baselineType: TextBaseline.alphabetic,
      child: Text(
        cardValue.rank.character,
        style: TextStyle(
          fontFamily: "Outfit",
          fontSize: c.inactiveRankSize,
          color: colour,
          fontVariations: [FontVariation("wght", 400)],
        ),
      ),
    );
  }
}

final class SuitImage extends StatelessWidget {
  const SuitImage(this.cardValue, {super.key});

  final CardValue cardValue;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final colour = cardValue.suit.isRed ? colours.tertiary : colours.onSurfaceVariant;
    return Icon(_icon, color: colour, size: c.activeSuitSize);
  }

  IconData get _icon => switch (cardValue.suit) {
    Suit.clubs => Peaks.clubs,
    Suit.diamonds => Peaks.diamonds,
    Suit.hearts => Peaks.hearts,
    Suit.spades => Peaks.spades,
  };
}

final class SuitImageSm extends StatelessWidget {
  const SuitImageSm(this.cardValue, {super.key});

  final CardValue cardValue;

  @override
  Widget build(BuildContext context) {
    // final colour = Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.white54;
    final colour = Colors.white54;
    return Icon(_icon, color: colour, size: c.inactiveSuitSize);
  }

  IconData get _icon => switch (cardValue.suit) {
    Suit.clubs => Peaks.clubsSm,
    Suit.diamonds => Peaks.diamondsSm,
    Suit.hearts => Peaks.heartsSm,
    Suit.spades => Peaks.spadesSm,
  };
}

final class TileShadow extends StatelessWidget {
  const TileShadow({super.key, this.centre = Alignment.topRight});

  final Alignment centre;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Container(
      width: c.cardSize - 2,
      height: c.cardSize - 2,
      decoration: BoxDecoration(
        borderRadius: c.commonBorderRadius,
        gradient: RadialGradient(
          colors: <Color>[colours.tertiaryContainer.withAlpha(80), Colors.transparent],
          stops: [0.0, 1.0],
          center: centre,
          radius: 1.0,
        ),
      ),
    );
  }
}

double _suitCorrection(CardValue card) => switch (card.suit) {
  Suit.clubs => 2.0,
  Suit.diamonds => 5.0,
  Suit.hearts => 2.0,
  Suit.spades => 2.0,
};
