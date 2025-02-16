import 'package:tripeaks_neue/stores/data/back_options.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/cards.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:flutter/material.dart';

class LandscapeBoard extends StatelessWidget {
  const LandscapeBoard({super.key, required this.game, required this.back, required this.scale});

  final Game game;
  final double scale;
  final BackOptions back;

  @override
  Widget build(BuildContext context) {
    final cellSize = c.cardSize + c.cellPadding;
    final quarter = cellSize / 2.0;
    final rowShift = quarter;
    final width = quarter * game.layout.width;
    final height = rowShift * game.layout.height;
    return SizedBox(
      width: width * scale,
      height: height * scale,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: SizedBox(
          width: width,
          height: height,
          child: Stack(
            children: [
              for (final tile in game.board)
                Positioned(
                  left: tile.pin.crossAxis * quarter,
                  top: tile.pin.mainAxis * rowShift,
                  child: TileCard(tile, back: back, orientation: Orientation.landscape),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PortraitBoard extends StatelessWidget {
  const PortraitBoard({super.key, required this.game, required this.back, required this.scale});

  final Game game;
  final double scale;
  final BackOptions back;

  @override
  Widget build(BuildContext context) {
    final cellSize = c.cardSize + c.cellPadding;
    final quarter = cellSize / 2.0;
    final width = quarter * game.layout.height;
    final height = quarter * game.layout.width;
    return Row(
      children: [
        SizedBox(
          width: width * scale,
          height: height * scale,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: SizedBox(
              width: width,
              height: height,
              child: Stack(
                children: [
                  for (final tile in game.board)
                    Positioned(
                      top: tile.pin.crossAxis * quarter,
                      left: tile.pin.mainAxis * quarter,
                      child: TileCard(tile, back: back, orientation: Orientation.portrait),
                    ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
