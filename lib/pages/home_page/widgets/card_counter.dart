import 'package:flutter/material.dart';

class CardCounter extends StatelessWidget {
  const CardCounter({super.key, required this.maxCount, required this.count});

  final int maxCount;
  final int count;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final bold = colours.outline;
    final thin = colours.outlineVariant;
    return Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final segmentWidth = (constraints.maxWidth / maxCount).floorToDouble();
              final paintWidth = segmentWidth * maxCount;
              final left = ((constraints.maxWidth - paintWidth) / 2.0).floorToDouble();
              return SizedBox(
                height: 2,
                width: constraints.maxWidth,
                child: Stack(
                  children: [
                    CustomPaint(
                      painter: SegmentPainter(
                        allSegments: maxCount,
                        highlightedSegments: count,
                        segmentWidth: segmentWidth,
                        left: left,
                        bold: bold,
                        thin: thin,
                      ),
                    ),
                    if (count > 0)
                      AnimatedPositioned(
                        top: 0.0,
                        left: (count - 1) * segmentWidth + left,
                        duration: Durations.medium3,
                        curve: Curves.easeInOutCirc,
                        child: CounterSegment(width: segmentWidth),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class CounterSegment extends StatelessWidget {
  const CounterSegment({super.key, required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _space),
      child: Container(
        width: width - 2.0 * _space,
        height: 2.0,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}

final class SegmentPainter extends CustomPainter {
  SegmentPainter({
    required this.allSegments,
    required this.highlightedSegments,
    required this.segmentWidth,
    required this.left,
    required this.bold,
    required this.thin,
  }) : _paint = Paint()..style = PaintingStyle.stroke;

  final int allSegments;
  final int highlightedSegments;
  final double segmentWidth;
  final double left;
  final Color bold;
  final Color thin;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final last = highlightedSegments - 1;
    _paint
      ..color = bold
      ..strokeWidth = 2.0;
    for (var i = 0; i < last; i++) {
      canvas.drawLine(
        Offset(left + i * segmentWidth + _space, 1.0),
        Offset(left + (i + 1) * segmentWidth - _space, 1.0),
        _paint,
      );
    }

    _paint
      ..color = thin
      ..strokeWidth = 1.0;
    for (var i = highlightedSegments; i < allSegments; i++) {
      canvas.drawLine(
        Offset(left + i * segmentWidth + _space, 0.5),
        Offset(left + (i + 1) * segmentWidth - _space, 0.5),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is SegmentPainter && oldDelegate.highlightedSegments != highlightedSegments;
}

const _space = 2.0;
