import 'dart:math' as maths;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Pie extends StatelessWidget {
  const Pie({super.key, required this.total, required this.slice});

  final int total;
  final int slice;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Stack(
      alignment: .center,
      children: [
        SizedBox(
          width: 72,
          height: 72,
          child: CustomPaint(
            painter: PiePainter(
              total: total,
              slice: slice,
              ringColour: theme.colorScheme.tertiary,
              sliceColour: theme.colorScheme.primary,
              emptyColor: theme.colorScheme.onSurfaceVariant,
              ringThickness: 4.0,
              sliceThickness: 8.0,
            ),
          ),
        ),
        Text(total == 0 ? "-" : "${f.format(slice / total.toDouble() * 100.0)}%"),
      ],
    );
  }

  static final f = NumberFormat("##0.0", "en_GB");
}

final class PiePainter extends CustomPainter {
  PiePainter({
    required this.total,
    required this.slice,
    this.ringColour = Colors.blueGrey,
    this.sliceColour = Colors.deepOrange,
    this.emptyColor = Colors.grey,
    double? ringThickness,
    double? sliceThickness,
  }) : ringWidth = ringThickness ?? sliceThickness ?? 8.0,
       sliceWidth = sliceThickness ?? ringThickness ?? 8.0;

  final int total;
  final int slice;
  final double sliceWidth;
  final double ringWidth;
  final Color ringColour;
  final Color sliceColour;
  final Color emptyColor;

  @override
  void paint(Canvas canvas, Size size) {
    final maxWidth = ringWidth > sliceWidth ? ringWidth : sliceWidth;
    final rect = Rect.fromLTWH(maxWidth * 0.5, maxWidth * 0.5, size.width - maxWidth, size.height - maxWidth);
    final pt = Paint()
      ..strokeWidth = ringWidth
      ..style = .stroke
      ..strokeCap = .round;

    if (total == 0) {
      pt
        ..color = emptyColor
        ..strokeWidth = 1.0;
      canvas.drawOval(rect, pt);
      return;
    }

    if (slice == 0) {
      pt.color = ringColour;
      canvas.drawOval(rect, pt);
      return;
    }

    if (slice == total) {
      pt
        ..color = sliceColour
        ..strokeWidth = sliceWidth;
      canvas.drawOval(rect, pt);
      return;
    }

    final ringAngle = _tau * ((total - slice) / total.toDouble());
    final sliceAngle = _tau - ringAngle;

    pt.color = ringColour;
    canvas.drawArc(rect, sliceAngle + _gap - _start, ringAngle - _gap * 2.0, false, pt);

    pt
      ..color = sliceColour
      ..strokeWidth = sliceWidth;
    canvas.drawArc(rect, _gap - _start, sliceAngle - _gap * 2.0, false, pt);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  static const _tau = 2.0 * maths.pi;
  static const _start = maths.pi * 0.5;
  static const _gap = 0.12;
}
