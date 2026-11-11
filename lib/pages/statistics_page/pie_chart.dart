import 'dart:math' as math;

import 'package:material_ui/material_ui.dart';

final class const PiePainter({
  required final double ratio,
  required final Color circleColour,
  final double thickness = 22,
}) extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final outerRect = Offset.zero & size;

    if (ratio == 0) {
      _draw0(canvas, outerRect);
      return;
    }

    if (ratio == 1) {
      _draw1(canvas, outerRect);
      return;
    }

    _drawRatio(canvas, outerRect);
  }

  @override
  bool shouldRepaint(PiePainter oldDelegate) => circleColour != oldDelegate.circleColour;

  void _drawRatio(Canvas canvas, Rect outerRect) {
    final halfThickness = thickness * 0.5;

    final doughnut = Path()
      ..addOval(outerRect)
      ..addOval(
        Rect.fromLTRB(thickness, thickness, outerRect.width - thickness, outerRect.height - thickness),
      )
      ..fillType = .evenOdd;

    final doughnutPaint = Paint()
      ..style = .fill
      ..color = circleColour;
    canvas.drawPath(doughnut, doughnutPaint);

    final r = outerRect.height * 0.5 - halfThickness;
    final zeroAngle = math.pi * -0.5;
    final arcAngle = math.pi * 2 * ratio;
    final angleCorrection = math.atan2(halfThickness + 0.5, r);
    final sweepAngle = arcAngle - angleCorrection * 2;
    final startAngle = zeroAngle + angleCorrection;
    final rect = Rect.fromLTWH(halfThickness, halfThickness, 2 * r, 2 * r);

    canvas.save();
    canvas.clipPath(doughnut);

    final shadowPnt = Paint()
      ..color = Colors.blueGrey.shade400
      ..style = .stroke
      ..strokeWidth = 4
      ..maskFilter = .blur(.normal, 5)
      ..blendMode = .multiply;

    canvas.drawPath(doughnut.shift(const Offset(0, 2)), shadowPnt);

    shadowPnt
      ..strokeWidth = thickness
      ..strokeCap = .round;
    canvas.drawArc(rect, startAngle, sweepAngle, false, shadowPnt);

    canvas.restore();

    final arcPnt = Paint()
      ..style = .stroke
      ..strokeCap = .round
      ..strokeWidth = thickness + 1
      ..color = Colors.green
      ..shader = SweepGradient(
        colors: <Color>[Colors.green, Colors.lightGreen, Colors.lightGreen.shade400],
        // startAngle: math.pi * 3 / 4.0,
        stops: <double>[0, ratio * 0.5, ratio + 0.01],
        transform: GradientRotation(zeroAngle - 0.01),
      ).createShader(outerRect);

    canvas.drawArc(rect, startAngle, sweepAngle, false, arcPnt);
  }

  void _draw0(Canvas canvas, Rect outerRect) {
    final doughnut = Path()
      ..addOval(outerRect)
      ..addOval(
        Rect.fromLTRB(thickness, thickness, outerRect.width - thickness, outerRect.height - thickness),
      )
      ..fillType = .evenOdd;

    final arcPnt = Paint()
      ..style = .fill
      ..color = circleColour;

    canvas.drawPath(doughnut, arcPnt);
  }

  void _draw1(Canvas canvas, Rect outerRect) {
    final width = 20.0;
    final innerRect = Rect.fromLTRB(width, width, outerRect.right - width, outerRect.bottom - width);
    final path = Path()
      ..addPath(
        StarBorder(
          points: 12,
          innerRadiusRatio: (outerRect.width - width * 2) / outerRect.width,
          pointRounding: 0,
          valleyRounding: 0,
        ).getOuterPath(outerRect),
        Offset.zero,
      )
      ..addOval(innerRect)
      ..fillType = .evenOdd;

    final shader = RadialGradient(
      colors: <Color>[Colors.green, Colors.lightGreen.shade400, Colors.lightGreen.shade300],
    ).createShader(outerRect);
    final arcPnt = Paint()
      ..style = .fill
      ..color = Colors.green
      ..shader = shader;
    canvas.drawPath(path, arcPnt);

    final shadowPnt = Paint()
      ..color = Colors.green.shade500
      ..style = .stroke
      ..strokeWidth = 4
      ..maskFilter = .blur(.normal, 5)
      ..blendMode = .multiply;
    canvas.save();
    canvas.clipPath(path);
    canvas.drawPath(path.shift(const Offset(0, 2)), shadowPnt);
    canvas.restore();
  }
}
