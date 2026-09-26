import 'package:tripeaks_neue/stores/data/back_options.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/cards.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:material_ui/material_ui.dart';

class const LandscapeBoard({
  super.key,
  required final Game game,
  required final BackOptions back,
  required final double scale,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cellSize = c.cardSize + c.cellPadding;
    final quarter = cellSize / 2.0;
    final rowShift = quarter;
    final width = quarter * game.layout.width;
    final height = rowShift * game.layout.height;
    return SizedBox(
      width: (width * scale).floorToDouble(),
      height: (height * scale).floorToDouble(),
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

class const PortraitBoard({
  super.key,
  required final Game game,
  required final BackOptions back,
  required final double scale,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cellSize = c.cardSize + c.cellPadding;
    final quarter = cellSize / 2.0;
    final width = quarter * game.layout.height;
    final height = quarter * game.layout.width;
    return SizedBox(
      width: (width * scale).floorToDouble(),
      height: (height * scale).floorToDouble(),
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
    );
  }
}
