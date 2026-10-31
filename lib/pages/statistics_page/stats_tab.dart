import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class const StatsTab(final Statistics statistics, {super.key, final bool showLayout = true})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: c.maxListWidth, maxHeight: 146),
        child: Material(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          shadowColor: Colors.black87,
          elevation: 3,
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Color(0x09000000), width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: 4,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 4.0,
                      crossAxisAlignment: .stretch,
                      children: [
                        Container(
                          height: 48,
                          padding: EdgeInsets.only(left: 20, right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12)),
                            color: Colors.blueGrey.shade400,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: .start,
                              crossAxisAlignment: .baseline,
                              textBaseline: .alphabetic,
                              spacing: 8,
                              children: [
                                SizedBox(
                                  width: 56,
                                  child: Text(
                                    "PLAYED",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: .w300,
                                      color: Colors.blueGrey.shade50,
                                      leadingDistribution: .proportional,
                                    ),
                                  ),
                                ),
                                Text(
                                  "500",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: .w600,
                                    color: Colors.blueGrey.shade50,
                                    leadingDistribution: .proportional,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          spacing: 8.0,
                          children: [
                            Text(
                              "40%",
                              style: TextStyle(fontSize: 16, fontWeight: .w600, color: Colors.grey.shade800),
                            ),
                            Expanded(
                              child: SizedBox(height: 24, child: CustomPaint(painter: BarChart(0.4))),
                            ),
                          ],
                        ),
                        Container(
                          height: 48,
                          padding: EdgeInsets.only(left: 20, right: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12)),
                            color: Colors.lightGreen.shade500,
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: .start,
                              crossAxisAlignment: .baseline,
                              textBaseline: .alphabetic,
                              spacing: 8,
                              children: [
                                SizedBox(
                                  width: 56,
                                  child: Text(
                                    "CLEARED",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: .w300,
                                      color: Colors.blueGrey.shade50,
                                      leadingDistribution: .proportional,
                                    ),
                                  ),
                                ),
                                Text(
                                  "200",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: .w600,
                                    color: Colors.blueGrey.shade50,
                                    leadingDistribution: .proportional,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: Column(
                      spacing: 4,
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(12)),
                              color: Colors.grey.shade300,
                            ),
                            padding: EdgeInsets.only(left: 8, right: 20),
                            child: Row(
                              mainAxisAlignment: .end,
                              children: [
                                Column(
                                  crossAxisAlignment: .end,
                                  mainAxisAlignment: .center,
                                  children: [
                                    Text(
                                      "HIGHEST SCORE",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: .w300,
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                    Text(
                                      "999",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: .w600,
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(12)),
                              color: Colors.grey.shade300,
                            ),
                            padding: EdgeInsets.only(left: 8, right: 20),
                            child: Row(
                              mainAxisAlignment: .end,
                              children: [
                                Column(
                                  crossAxisAlignment: .end,
                                  mainAxisAlignment: .center,
                                  children: [
                                    Text(
                                      "999",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: .w600,
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                    Text(
                                      "LONGEST CHAIN",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: .w300,
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

final class const BarChart(final double ratio, {final double shift = 4}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint();
    final leftWidth = (size.width * ratio).roundToDouble();
    final rightWidth = size.width - leftWidth;
    _drawLeft(canvas, Size(leftWidth, size.height), p);
    _drawRight(canvas, Size(rightWidth, size.height), Offset(leftWidth, 0), false, p);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void _drawLeft(Canvas canvas, Size size, Paint paint) {
    final rect = Offset.zero & size;
    paint
      ..color = Colors.lightGreen
      ..style = .fill;
    canvas.drawRRect(RRect.fromRectAndCorners(rect, topLeft: _radius, bottomLeft: _radius), paint);
  }

  void _drawRight(Canvas canvas, Size size, Offset offset, bool full, Paint paint) {
    final rect = offset & size;
    final h = size.height;
    final d = size.height * 0.5;
    final steps = ((size.width + d) / shift).ceil();
    final x0 = offset.dx;

    paint
      ..color = Colors.grey.shade500
      ..style = .stroke
      ..strokeWidth = 1.2;

    canvas.save();
    canvas.clipRRect(RRect.fromRectAndCorners(rect, topRight: _radius, bottomRight: _radius));
    for (var i = 0; i < steps; i++) {
      canvas.drawLine(Offset(x0 + i * shift - d, h), Offset(x0 + i * shift, 0), paint);
    }
    canvas.restore();
  }

  static const _radius = Radius.circular(12);
}

final class const GameTile({
  super.key,
  required final Widget description,
  required final Widget image,
  final List<LogicalKeyboardKey>? shorcut,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        clipBehavior: .none,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: c.maxParagraphWidth),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: c.cardPaddingHorizontal),
              child: Row(
                spacing: 24.0,
                children: [
                  SizedBox(
                    width: 64,
                    child: Row(mainAxisAlignment: .center, children: [image]),
                  ),
                  Expanded(
                    child: shorcut == null
                        ? description
                        : Column(
                            mainAxisSize: .min,
                            crossAxisAlignment: .start,
                            spacing: c.cellPadding,
                            children: [description],
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
