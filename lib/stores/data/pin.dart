class const Pin({
  required final int index,

  /// Rows in landscape orientation, columns in portrait
  required final int mainAxis,

  /// Columns in landscape orientation, rows in portrait
  required final int crossAxis,

  /// 0 is the top-most layer, goes up for each layer below
  required final int z,
  required final bool startsOpen,
}) {
  @override
  operator ==(Object other) => other is Pin && other.index == index;

  @override
  int get hashCode => index;

  static const unpin = Pin(index: -1, mainAxis: -1, crossAxis: -1, z: -1, startsOpen: false);

  /// This is a hack to add the end-game chain length to the history, so the longest chain search can see it.
  static const gameEnd = Pin(index: endIndex, mainAxis: -1, crossAxis: -1, z: -1, startsOpen: false);

  static const endIndex = 1000000;
}
