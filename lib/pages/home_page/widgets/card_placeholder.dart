import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class CardPlaceHolder extends StatelessWidget {
  const CardPlaceHolder({super.key, required this.scale});

  final double scale;

  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    final useSmall = scale < c.iconScaleThreshold;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: colours.outlineVariant, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(c.commonRadius * scale)),
      ),
      width: c.cardSize * scale,
      height: c.cardSize * scale,
      child: Icon(
        useSmall ? CustomIcons.draw16 : CustomIcons.draw,
        size: useSmall ? 16.0 : 24.0,
        color: colours.outlineVariant,
      ),
    );
  }
}
