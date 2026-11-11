import 'package:flutter/widgets.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_card.dart';

class const MyStatCard({
  super.key,
  required final int value,
  required final String label,
  required final IconData icon,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colours = theme.colorScheme;
    final textExt = theme.extension<MyTextThemeExt>()!;
    return MyCard(
      padding: _padding,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 82),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          crossAxisAlignment: .center,
          children: [
            Icon(icon, size: 32, color: colours.onSurfaceVariant),
            Text(value.toString(), style: textExt.numericL.copyWith(color: colours.onSecondaryContainer)),
            Row(
              mainAxisAlignment: .center,
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: textExt.faintLabelM,
                    softWrap: true,
                    maxLines: 2,
                    overflow: .fade,
                    textAlign: .center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static const _padding = EdgeInsets.fromLTRB(
    c.cardPaddingHorizontal,
    c.cardPaddingVertical + 4,
    c.cardPaddingHorizontal,
    c.cardPaddingVertical + 6,
  );
}
