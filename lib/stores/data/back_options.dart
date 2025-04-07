import 'package:flutter/widgets.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';

final class BackOptions {
  BackOptions({required this.showValue, required this.decor, required this.decorColour});

  final bool showValue;
  final IconData decor;
  final DecorColour decorColour;
}
