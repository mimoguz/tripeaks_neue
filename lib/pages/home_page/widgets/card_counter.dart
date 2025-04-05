import 'package:flutter/material.dart';

class CardCounter extends StatelessWidget {
  const CardCounter({super.key, required this.maxCount, required this.count, required this.chainLength});

  final int maxCount;
  final int count;
  final int chainLength;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final bold = colours.outline;
    final thin = colours.outlineVariant;
    final group = colours.primary;
    return Row(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final segmentWidth = (constraints.maxWidth / maxCount).floorToDouble();
              final paintWidth = segmentWidth * maxCount;
              final left = ((constraints.maxWidth - paintWidth) / 2.0).floorToDouble();
              return SizedBox(
                height: 5,
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
                        top: 1.0,
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
      ..strokeWidth = 3.0
      ..style = PaintingStyle.stroke;
    for (var i = 0; i < last; i++) {
      canvas.drawLine(
        Offset(left + i * segmentWidth + _space, 2.5),
        Offset(left + (i + 1) * segmentWidth - _space, 2.5),
        _paint,
      );
    }

    _paint
      ..color = thin
      ..strokeWidth = 1.0;
    for (var i = groupLast; i < allSegments; i++) {
      canvas.drawLine(
        Offset(left + i * segmentWidth + _space, 2.5),
        Offset(left + (i + 1) * segmentWidth - _space, 2.5),
        _paint,
      );
    }

    _paint
      ..color = group
      ..style = PaintingStyle.fill;
    for (var i = highlightedSegments; i < groupLast; i++) {
      // canvas.drawRRect(
      //   RRect.fromLTRBR(
      //     left + i * segmentWidth + _space,
      //     0.5,
      //     left + (i + 1) * segmentWidth - _space,
      //     4.5,
      //     _radius,
      //   ),
      //   _paint,
      // );
      canvas.drawCircle(Offset(left + (i + 0.5) * segmentWidth, 2.5), 5.0, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is SegmentPainter && oldDelegate.highlightedSegments != highlightedSegments;
}

const _space = 2.0;
const _radius = Radius.circular(5.0);
