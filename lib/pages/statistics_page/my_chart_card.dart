import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/pages/statistics_page/pie_chart.dart';
import 'package:tripeaks_neue/util/format_ext.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_card.dart';

final class const MyChartCard({super.key, required final int played, required final int cleared})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colours = theme.colorScheme;
    final textExt = theme.extension<MyTextThemeExt>()!;
    final s = context.strings;
    final labelColour = colours.onTertiaryContainer.withAlpha(150);
    final numberStyle = textExt.numericXL.copyWith(color: colours.onTertiaryContainer);
    final percentSignStyle = textExt.numericL.copyWith(color: labelColour);
    final labelStyle = textExt.faintLabelL.copyWith(color: labelColour);
    final ratio = played > 0 ? (cleared == played ? 1.0 : cleared.toDouble() / played) : 0.0;
    return MyCard(
      background: colours.tertiaryContainer,
      padding: _padding,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: 216),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: Stack(
                alignment: .center,
                children: [
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: CustomPaint(
                      painter: PiePainter(ratio: ratio, circleColour: colours.onTertiaryContainer),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: .center,
                    mainAxisSize: .min,
                    children: [
                      SizedBox(height: (percentSignStyle.fontSize ?? 20) - 2),
                      Text(ratio.asPercent, style: numberStyle),
                      Text("%", style: percentSignStyle),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: .center,
              children: [
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: .end,
                    mainAxisAlignment: .center,
                    spacing: 5,
                    children: [
                      Text(
                        played.toString(),
                        style: numberStyle,
                        textAlign: .end,
                        overflow: .fade,
                        softWrap: false,
                      ),
                      Text(s.totalPlayedLabel, style: labelStyle, textAlign: .end),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Center(child: Container(width: 1, height: 54, color: labelColour)),
                ),
                Expanded(
                  flex: 4,
                  child: Column(
                    crossAxisAlignment: .start,
                    mainAxisAlignment: .center,
                    spacing: 5,
                    children: [
                      Text(
                        cleared.toString(),
                        style: numberStyle,
                        textAlign: .start,
                        overflow: .fade,
                        softWrap: false,
                      ),
                      Text(s.totalClearedLabel, style: labelStyle, textAlign: .start),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static const _padding = EdgeInsets.fromLTRB(4, c.cardPaddingVertical + 6, 4, c.cardPaddingVertical + 4);
}
