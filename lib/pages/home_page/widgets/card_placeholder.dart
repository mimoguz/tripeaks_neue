import 'package:flutter/material.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
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
      child: Icon(
        scale < c.iconScaleThreshold ? CustomIcons.draw16 : CustomIcons.draw,
        color: colours.outlineVariant,
      ),
    );
  }
}
