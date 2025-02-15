class Pin {
  const Pin({
    required this.index,
    required this.mainAxis,
    required this.crossAxis,
    required this.z,
    required this.startsOpen,
  });

  final int index;

  /// Rows in landscape orientation, columns in portrait
  final int mainAxis;

  /// Columns in landscape orientation, rows in portrait
  final int crossAxis;

  /// 0 is the top-most layer, goes up for each layer below
  final int z;

  final bool startsOpen;

  @override
  operator ==(Object other) => other is Pin && other.index == index;

  @override
  int get hashCode => index;

  static const unpin = Pin(index: -1, mainAxis: -1, crossAxis: -1, z: -1, startsOpen: false);
}
