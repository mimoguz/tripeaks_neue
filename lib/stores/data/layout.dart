import 'package:tripeaks_neue/stores/data/pin.dart';

final class Layout {
  const Layout({
    required this.width,
    required this.height,
    required this.cardCount,
    required this.pins,
    required this.below,
    required this.above,
    required this.tag,
  }) : assert(pins.length == cardCount),
       assert(below.length == cardCount);

  /// Width of the board, in terms of pins.
  final int width;

  /// Height of the board, in terms of pins.
  final int height;

  /// Total number of cards.
  final int cardCount;

  /// List of pins. Its length must be equal to cardCount.
  ///
  /// Each tile will be pinned at its top-left corner and
  /// will occupy four squares.
  final List<Pin> pins;

  /// Which pins a card pinned to given index will block.
  /// Its length must be equal to cardCount.
  final List<List<int>> below;

  /// Which pins a card pinned to given index is blocked by.
  /// Its length must be equal to cardCount.
  final List<List<int>> above;

  final Peaks tag;
}

final baseGameLayout = Layout(
  width: 20,
  height: 5,
  cardCount: 28,
  pins: List<Pin>.unmodifiable([
    Pin(index: 0, mainAxis: 0, crossAxis: 3, z: 3, startsOpen: false),
    Pin(index: 1, mainAxis: 0, crossAxis: 9, z: 3, startsOpen: false),
    Pin(index: 2, mainAxis: 0, crossAxis: 15, z: 3, startsOpen: false),
    Pin(index: 3, mainAxis: 1, crossAxis: 2, z: 2, startsOpen: false),
    Pin(index: 4, mainAxis: 1, crossAxis: 4, z: 2, startsOpen: false),
    Pin(index: 5, mainAxis: 1, crossAxis: 8, z: 2, startsOpen: false),
    Pin(index: 6, mainAxis: 1, crossAxis: 10, z: 2, startsOpen: false),
    Pin(index: 7, mainAxis: 1, crossAxis: 14, z: 2, startsOpen: false),
    Pin(index: 8, mainAxis: 1, crossAxis: 16, z: 2, startsOpen: false),
    Pin(index: 9, mainAxis: 2, crossAxis: 1, z: 1, startsOpen: false),
    Pin(index: 10, mainAxis: 2, crossAxis: 3, z: 1, startsOpen: false),
    Pin(index: 11, mainAxis: 2, crossAxis: 5, z: 1, startsOpen: false),
    Pin(index: 12, mainAxis: 2, crossAxis: 7, z: 1, startsOpen: false),
    Pin(index: 13, mainAxis: 2, crossAxis: 9, z: 1, startsOpen: false),
    Pin(index: 14, mainAxis: 2, crossAxis: 11, z: 1, startsOpen: false),
    Pin(index: 15, mainAxis: 2, crossAxis: 13, z: 1, startsOpen: false),
    Pin(index: 16, mainAxis: 2, crossAxis: 15, z: 1, startsOpen: false),
    Pin(index: 17, mainAxis: 2, crossAxis: 17, z: 1, startsOpen: false),
    Pin(index: 18, mainAxis: 3, crossAxis: 0, z: 0, startsOpen: true),
    Pin(index: 19, mainAxis: 3, crossAxis: 2, z: 0, startsOpen: true),
    Pin(index: 20, mainAxis: 3, crossAxis: 4, z: 0, startsOpen: true),
    Pin(index: 21, mainAxis: 3, crossAxis: 6, z: 0, startsOpen: true),
    Pin(index: 22, mainAxis: 3, crossAxis: 8, z: 0, startsOpen: true),
    Pin(index: 23, mainAxis: 3, crossAxis: 10, z: 0, startsOpen: true),
    Pin(index: 24, mainAxis: 3, crossAxis: 12, z: 0, startsOpen: true),
    Pin(index: 25, mainAxis: 3, crossAxis: 14, z: 0, startsOpen: true),
    Pin(index: 26, mainAxis: 3, crossAxis: 16, z: 0, startsOpen: true),
    Pin(index: 27, mainAxis: 3, crossAxis: 18, z: 0, startsOpen: true),
  ]),
  below: List<List<int>>.unmodifiable([
    List<int>.unmodifiable([]), //       index: 0
    List<int>.unmodifiable([]), //       index: 1
    List<int>.unmodifiable([]), //       index: 2
    List<int>.unmodifiable([0]), //      index: 3
    List<int>.unmodifiable([0]), //      index: 4
    List<int>.unmodifiable([1]), //      index: 5
    List<int>.unmodifiable([1]), //      index: 6
    List<int>.unmodifiable([2]), //      index: 7
    List<int>.unmodifiable([2]), //      index: 8
    List<int>.unmodifiable([3]), //      index: 9
    List<int>.unmodifiable([3, 4]), //   index: 10
    List<int>.unmodifiable([4]), //      index: 11
    List<int>.unmodifiable([5]), //      index: 12
    List<int>.unmodifiable([5, 6]), //   index: 13
    List<int>.unmodifiable([6]), //      index: 14
    List<int>.unmodifiable([7]), //      index: 15
    List<int>.unmodifiable([7, 8]), //   index: 16
    List<int>.unmodifiable([8]), //      index: 17
    List<int>.unmodifiable([9]), //      index: 18
    List<int>.unmodifiable([9, 10]), //  index: 19
    List<int>.unmodifiable([10, 11]), // index: 20
    List<int>.unmodifiable([11, 12]), // index: 21
    List<int>.unmodifiable([12, 13]), // index: 22
    List<int>.unmodifiable([13, 14]), // index: 23
    List<int>.unmodifiable([14, 15]), // index: 24
    List<int>.unmodifiable([15, 16]), // index: 25
    List<int>.unmodifiable([16, 17]), // index: 26
    List<int>.unmodifiable([17]), //     index: 27
  ]),
  above: List<List<int>>.unmodifiable([
    List<int>.unmodifiable([3, 4]), //   index: 0
    List<int>.unmodifiable([5, 6]), //   index: 1
    List<int>.unmodifiable([7, 8]), //   index: 2
    List<int>.unmodifiable([9, 10]), //  index: 3
    List<int>.unmodifiable([10, 11]), // index: 4
    List<int>.unmodifiable([12, 13]), // index: 5
    List<int>.unmodifiable([13, 14]), // index: 6
    List<int>.unmodifiable([15, 16]), // index: 7
    List<int>.unmodifiable([16, 17]), // index: 8
    List<int>.unmodifiable([18, 19]), // index: 9
    List<int>.unmodifiable([19, 20]), // index: 10
    List<int>.unmodifiable([20, 21]), // index: 11
    List<int>.unmodifiable([21, 22]), // index: 12
    List<int>.unmodifiable([22, 23]), // index: 13
    List<int>.unmodifiable([23, 24]), // index: 14
    List<int>.unmodifiable([24, 25]), // index: 15
    List<int>.unmodifiable([25, 26]), // index: 16
    List<int>.unmodifiable([26, 27]), // index: 17
    List<int>.unmodifiable([]), //       index: 18
    List<int>.unmodifiable([]), //       index: 19
    List<int>.unmodifiable([]), //       index: 20
    List<int>.unmodifiable([]), //       index: 21
    List<int>.unmodifiable([]), //       index: 22
    List<int>.unmodifiable([]), //       index: 23
    List<int>.unmodifiable([]), //       index: 24
    List<int>.unmodifiable([]), //       index: 25
    List<int>.unmodifiable([]), //       index: 26
    List<int>.unmodifiable([]), //       index: 27
  ]),
  tag: Peaks.baseGame,
);

enum Peaks { baseGame }

extension PeaksExt on Peaks {
  Layout get layout => switch (this) {
    Peaks.baseGame => baseGameLayout,
  };
}
