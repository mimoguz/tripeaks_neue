import 'package:flutter/material.dart';
import 'package:tripeaks_neue/assets/peaks.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class CardPlaceHolder extends StatelessWidget {
  const CardPlaceHolder({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colours.outlineVariant, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(c.commonRadius * scale)),
      ),
      width: c.cardSize * scale,
      height: c.cardSize * scale,
      // TODO: Specific icon
      child: Icon(scale < c.iconScaleThreshold ? Peaks.draw16 : Peaks.draw, color: colours.outlineVariant),
    );
  }
}
