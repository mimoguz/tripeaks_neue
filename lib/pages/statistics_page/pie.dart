import 'dart:math' as maths;

import 'package:material_ui/material_ui.dart';
import 'package:intl/intl.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class const Pie({super.key, required final int total, required final int slice, final double size = 80})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Stack(
      alignment: .center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: PiePainter(
              total: total,
              slice: slice,
              ringColour: theme.colorScheme.onSurface.withAlpha(60),
              sliceColour: DecorColour.green.background,
              emptyColor: theme.colorScheme.onSurface.withAlpha(20),
              thickness: 12.0,
            ),
          ),
        ),
        Text(
          total == 0 ? "" : "${f.format(slice / total.toDouble() * 100.0)}%",
          style: theme.textTheme.titleMedium?.copyWith(fontWeight: .w800, fontFeatures: c.fontFeatures),
        ),
      ],
    );
  }

  static final f = NumberFormat("##0.#", "en_GB");
}

final class PiePainter({
  required final int total,
  required final int slice,
  required final Color ringColour,
  required final Color sliceColour,
  required final Color emptyColor,
  final double thickness = 8.0,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      thickness * 0.5,
      thickness * 0.5,
      size.width - thickness,
      size.height - thickness,
    );
    final pt = Paint()
      ..strokeWidth = thickness
      ..style = .stroke
      ..strokeCap = .round;

    if (total == 0) {
      pt.color = emptyColor;
      canvas.drawOval(rect, pt);
      return;
    }

    if (slice == total) {
      pt.color = sliceColour;
      _drawStar(
        canvas,
        pt,
        outerRect: Rect.fromPoints(Offset.zero, size.bottomRight(Offset.zero)),
        innerRect: Rect.fromLTRB(thickness, thickness, size.width - thickness, size.height - thickness),
      );
      return;
    }

    pt.color = ringColour;
    canvas.drawOval(rect, pt);

    if (slice == 0) {
      return;
    }

    final ringAngle = _tau * ((total - slice) / total.toDouble());
    final sliceAngle = _tau - ringAngle;
    // I need to fix the effect of the round stroke cap.
    // The overhang diameter will be the stroke thickness. Use that  estimate
    // the error angle:
    final fixAngle = maths.atan2(thickness, rect.width);
    pt.color = sliceColour;
    canvas.drawArc(rect, _start + fixAngle, sliceAngle - 2 * fixAngle, false, pt);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _drawStar(Canvas canvas, Paint pt, {required Rect outerRect, required Rect innerRect}) {
    final path = Path()..fillType = .evenOdd;
    final style = pt.style;
    pt.style = .fill;
    path.addPath(StarBorder(points: 20, innerRadiusRatio: 0.9).getOuterPath(outerRect), Offset.zero);
    path.addOval(innerRect);

    canvas.drawPath(path, pt);
    pt.style = style;
  }

  static const _tau = 2.0 * maths.pi;
  static const _start = maths.pi * -0.5;
  // static const _gap = 0.12;
}
