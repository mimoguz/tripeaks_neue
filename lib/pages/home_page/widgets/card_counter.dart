import 'package:flutter/material.dart';

class CardCounter extends StatelessWidget {
  const CardCounter({super.key, required this.maxCount, required this.count, required this.chainLength});

  final int maxCount;
  final int count;
  final int chainLength;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final bold = colours.secondary;
    final thin = colours.outlineVariant;
    final group = colours.tertiary;
    return Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final segmentWidth = (constraints.maxWidth / maxCount).floorToDouble();
              final paintWidth = segmentWidth * maxCount;
              final left = ((constraints.maxWidth - paintWidth) / 2.0).floorToDouble();
              return SizedBox(
                height: 9.0,
                width: constraints.maxWidth,
                child: Stack(
                  children: [
                    CustomPaint(
                      painter: SegmentPainter(
                        allSegments: maxCount,
                        highlightedSegments: count,
                        groupSegments: chainLength,
                        segmentWidth: segmentWidth,
                        left: left,
                        bold: bold,
                        thin: thin,
                        group: group,
                      ),
                    ),
                    if (count > 0)
                      AnimatedPositioned(
                        top: 3.0,
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
        height: 3.0,
        color: Theme.of(context).colorScheme.tertiary,
      ),
    );
  }
}

final class SegmentPainter extends CustomPainter {
  SegmentPainter({
    required this.allSegments,
    required this.highlightedSegments,
    required this.groupSegments,
    required this.segmentWidth,
    required this.left,
    required this.bold,
    required this.thin,
    required this.group,
  }) : _paint = Paint()..style = PaintingStyle.stroke;

  final int allSegments;
  final int highlightedSegments;
  final int groupSegments;
  final double segmentWidth;
  final double left;
  final Color bold;
  final Color thin;
  final Color group;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final last = highlightedSegments - 1;
    final groupLast = highlightedSegments + groupSegments;

    _paint
      ..color = bold
      ..style = PaintingStyle.fill;
    for (var i = 0; i < last; i++) {
      final x0 = left + i * segmentWidth;
      canvas.drawRect(Rect.fromLTRB(x0 + _space, 3.0, x0 + segmentWidth - _space, 6.0), _paint);
    }

    _paint.color = thin;
    for (var i = groupLast; i < allSegments; i++) {
      final x0 = left + i * segmentWidth;
      canvas.drawRect(Rect.fromLTRB(x0 + _space, 4.0, x0 + segmentWidth - _space, 5.0), _paint);
    }

    _paint
      ..color = group
      ..strokeWidth = 1.0;
    for (var i = highlightedSegments; i < groupLast; i++) {
      final centre = Offset(left + (i + 0.5) * segmentWidth, 4.5);
      _paint.style = PaintingStyle.stroke;
      canvas.drawCircle(centre, 4.5, _paint);
      _paint.style = PaintingStyle.fill;
      canvas.drawCircle(centre, 2, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is SegmentPainter && oldDelegate.highlightedSegments != highlightedSegments;
}

const _space = 2.0;
