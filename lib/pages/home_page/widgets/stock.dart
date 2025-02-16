import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/cards.dart';
import 'package:tripeaks_neue/stores/data/back_options.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class LandscapeStock extends StatelessWidget {
  const LandscapeStock(this.game, {super.key, required this.scale, required this.back});

  final Game game;
  final double scale;
  final BackOptions back;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return AnimatedSize(
          duration: Durations.medium3,
          alignment: Alignment.bottomLeft,
          child: LandscapeStackLayout(
            scale: scale,
            cards: <Widget>[
              for (final (index, tile) in game.stock.indexed)
                Stack(
                  children: [
                    TileCard(
                      tile,
                      t: game.stock.length > 1 ? (index / game.stock.length) * 0.4 + 0.6 : 1.0,
                      back: back,
                    ),
                    if (index < game.stock.length - 1) const TileShadow(centre: _shadowOrigin),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  static const _shadowOrigin = Alignment(1.0, -0.5);
}

class PortraitStock extends StatelessWidget {
  const PortraitStock(this.game, {super.key, required this.scale, required this.back});

  final Game game;
  final double scale;
  final BackOptions back;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return AnimatedSize(
          duration: Durations.medium3,
          alignment: Alignment.topRight,
          child: PortraitStackLayout(
            scale: scale,
            cards: <Widget>[
              for (final (index, tile) in game.stock.indexed)
                Stack(
                  children: [
                    TileCard(
                      tile,
                      t: game.stock.length > 1 ? (index / game.stock.length) * 0.4 + 0.6 : 1.0,
                      back: back,
                    ),
                    if (index < game.stock.length - 1) const TileShadow(centre: _shadowOrigin),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  static const _shadowOrigin = Alignment(1.0, 0.5);
}

class LandscapeStackLayout extends StatelessWidget {
  const LandscapeStackLayout({super.key, required this.scale, required this.cards});

  final double scale;
  final List<Widget> cards;

  @override
  Widget build(BuildContext context) {
    final width = cards.isEmpty ? 0.0 : (cards.length - 1) * c.stockShift + c.cardSize;
    return SizedBox(
      width: width * scale,
      height: c.cardSize * scale,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          width: width,
          height: c.cardSize,
          child: Stack(
            children: [
              for (var i = 0; i < cards.length; i++)
                Positioned(right: width - c.cardSize - i * c.stockShift, top: 0.0, child: cards[i]),
            ],
          ),
        ),
      ),
    );
  }
}

class PortraitStackLayout extends StatelessWidget {
  const PortraitStackLayout({super.key, required this.scale, required this.cards});

  final double scale;
  final List<Widget> cards;

  @override
  Widget build(BuildContext context) {
    final height = cards.isEmpty ? 0.0 : (cards.length - 1) * c.stockShift + c.cardSize;
    return SizedBox(
      height: height * scale,
      width: c.cardSize * scale,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          height: height,
          width: c.cardSize,
          child: Stack(
            children: [
              for (var i = 0; i < cards.length; i++)
                Positioned(bottom: height - c.cardSize - i * c.stockShift, left: 0.0, child: cards[i]),
            ],
          ),
        ),
      ),
    );
  }
}
