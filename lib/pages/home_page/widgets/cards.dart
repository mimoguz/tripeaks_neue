import 'dart:math';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/stores/data/back_options.dart';
import 'package:tripeaks_neue/stores/data/card_value.dart';
import 'package:tripeaks_neue/stores/tile.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

final class const TileCard(
  final Tile tile, {
  super.key,
  required final BackOptions back,
  final double t = 0.5,
  final Orientation orientation = Orientation.portrait,
}) extends StatelessWidget {
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
          transitionBuilder: (child, animation) => SlideTransition(
            position: Tween(begin: Offset(dx, dy), end: Offset.zero).animate(animation),
            child: FadeTransition(opacity: animation, child: child),
          ),
          child: !tile.isVisible
              ? SizedBox(width: c.cardSize, height: c.cardSize, key: childKey)
              : tile.isOpen
              ? ActiveCard(tile, key: childKey)
              : InactiveCard(
                  tile.card,
                  t: (tile.pin.z < 0 ? t : (1.0 / (tile.pin.z + 1)) * 0.6 + 0.4),
                  key: childKey,
                  back: back,
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
final class const ActiveCard(final Tile tile, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    return SizedBox(
      width: c.cardSize,
      height: c.cardSize,
      child: Material(
        color: colours.secondaryContainer,
        borderRadius: c.commonBorderRadius,
        child: InkWell(
          onTap: tile.pin.index >= 0 ? () => Actions.invoke(context, TakeIntent(tile.pin)) : null,
          borderRadius: c.commonBorderRadius,
          child: Observer(
            builder: (context) {
              final t = tile.lastError?.millisecondsSinceEpoch ?? 0;
              return TweenAnimationBuilder(
                key: ValueKey(t),
                duration: t == 0 ? Duration.zero : Durations.medium4,
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, animation, child) =>
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

final class const ActiveCardFace(final CardValue card, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: c.cardSize,
      child: Padding(
        padding: const EdgeInsets.only(top: 1.0),
        child: Column(mainAxisAlignment: .center, spacing: 8.0, children: [RankText(card), SuitImage(card)]),
      ),
    );
  }
}

final class const InactiveCard(
  final CardValue cardValue, {
  super.key,
  required final BackOptions back,
  final double t = 0.5,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fill = back.decorColour.background;
    return IgnorePointer(
      child: Material(
        color: Color.alphaBlend(context.colours.surface.withValues(alpha: 1.0 - t), fill),
        borderRadius: c.commonBorderRadius,
        child: SizedBox(
          width: c.cardSize,
          height: c.cardSize,
          child: back.showValue
              ? Stack(
                  children: [
                    CardBack(t: t, back: back),
                    Align(alignment: Alignment.topLeft, child: HorizontalSmallFace(cardValue)),
                    Align(alignment: Alignment.bottomLeft, child: HorizontalSmallFaceAlt(cardValue)),
                  ],
                )
              : CardBack(t: t, back: back),
          // : SizedBox(),
        ),
      ),
    );
  }
}

final class const HorizontalSmallFace(final CardValue cardValue, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [RankTextSm(cardValue), SuitImageSm(cardValue)],
      ),
    );
  }
}

final class const HorizontalSmallFaceAlt(final CardValue cardValue, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [SuitImageSm(cardValue), RankTextSm(cardValue)],
      ),
    );
  }
}

class const CardBack({super.key, required final BackOptions back, final double t = 1.0})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(c.commonRadius - 2.0)),
      child: Icon(back.decor, size: c.cardSize, color: back.decorColour.foreground),
    );
  }
}

final class const RankText(final CardValue cardValue, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    final colour = cardValue.suit.isRed ? colours.tertiary : colours.onSurfaceVariant;
    return Text(
      cardValue.rank.character,
      style: TextStyle(
        fontFamily: "Peckish",
        fontSize: c.activeRankSize,
        fontWeight: .w500,
        color: colour,
        letterSpacing: 1.0,
        height: 1.0,
      ),
    );
  }
}

final class const RankTextSm(final CardValue cardValue, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colour = Colors.white70;
    return Text(
      cardValue.rank.character,
      style: TextStyle(fontFamily: "Peckish", fontSize: c.inactiveRankSize, color: colour, fontWeight: .w400),
    );
  }
}

final class const SuitImage(final CardValue cardValue, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    final colour = cardValue.suit.isRed ? colours.tertiary : colours.onSurfaceVariant;
    return Icon(CustomIcons.suitIcon(cardValue.suit), size: c.activeSuitSize, color: colour);
  }
}

final class const SuitImageSm(final CardValue cardValue, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colour = Colors.white54;
    return Text(
      _suitChar(cardValue.suit),
      style: TextStyle(fontFamily: "Peckish", fontWeight: .w400, fontSize: 20, color: colour),
    );
  }
}

final class const TileShadow({super.key, final Alignment centre = Alignment.topRight})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: c.cardSize,
      height: c.cardSize,
      decoration: BoxDecoration(
        borderRadius: c.commonBorderRadius,
        gradient: RadialGradient(
          colors: <Color>[context.colours.tertiaryContainer.withAlpha(80), Colors.transparent],
          stops: [0.0, 1.0],
          center: centre,
          radius: 1.0,
        ),
      ),
    );
  }
}

String _suitChar(Suit suit) => switch (suit) {
  Suit.clubs => "\u2663",
  Suit.diamonds => "\u2666",
  Suit.hearts => "\u2665",
  Suit.spades => "\u2660",
};
