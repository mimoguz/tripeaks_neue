import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class SwipeArea extends StatefulWidget {
  const SwipeArea({super.key, required this.intent});

  final Intent intent;

  @override
  State<SwipeArea> createState() => _SwipeAreaState();
}

class _SwipeAreaState extends State<SwipeArea> {
  bool _watching = false;
  Offset _start = Offset.zero;
  Offset _end = Offset.zero;
  Color _fill = Colors.transparent;
  bool _drawAction = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragStart: _onDragStart,
      onVerticalDragEnd: (result) => _onDragEnd(context, result),
      onVerticalDragCancel: _onDragCancel,
      onVerticalDragUpdate: (d) => _onDragUpdate(d, Theme.of(context).colorScheme.tertiary),
      child: SizedBox.expand(
        child:
            _watching
                ? CustomPaint(
                  painter: _GesturePainter(
                    from: _start,
                    to: _end,
                    colour: _fill,
                    actionColour: Theme.of(context).colorScheme.surfaceContainerLow,
                    drawAction: _drawAction,
                  ),
                )
                : null,
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    _watching = true;
    _start = details.localPosition;
  }

  void _onDragUpdate(DragUpdateDetails details, Color tintColour) {
    if (!_watching) {
      return;
    }
    final distance = _start.dy - details.localPosition.dy;
    if (distance <= 0.0) {
      setState(() {
        _fill = Colors.transparent;
        if (_drawAction) {
          _drawAction = false;
        }
      });
      return;
    }
    final t = max(0.0, min(1.0, distance / _distanceThreshold) * 0.3);
    setState(() {
      _end = details.localPosition;
      _fill = tintColour.withValues(alpha: t);
      _drawAction = distance > _distanceThreshold;
    });
  }

  void _onDragEnd(BuildContext context, DragEndDetails details) {
    if (!_watching) {
      return;
    }
    if (details.primaryVelocity == null) {
      return;
    }

    final distance = _start.dy - details.localPosition.dy;

    setState(() {
      _fill = Colors.transparent;
      _watching = false;
      _start = Offset.zero;
      _end = Offset.zero;
    });

    if (distance > _distanceThreshold) {
      Actions.invoke(context, widget.intent);
    }
  }

  void _onDragCancel() {
    _watching = false;
    _start = Offset.zero;
  }

  static const double _distanceThreshold = 60.0;
}

class _GesturePainter extends CustomPainter {
  _GesturePainter({
    required this.from,
    required this.to,
    required this.colour,
    required this.actionColour,
    required this.drawAction,
  }) : _paint = Paint()..color = colour;

  final Offset from;
  final Offset to;
  final Color colour;
  final Color actionColour;
  final bool drawAction;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = RRect.fromLTRBR(
      from.dx - 24,
      max(from.dy, to.dy) + 24,
      from.dx + 24,
      min(from.dy, to.dy) - 24,
      _radius,
    );
    canvas.drawRRect(rect, _paint);
    if (drawAction) {
      _paint
        ..color = actionColour
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0;
      canvas.drawPath(
        Path()
          ..moveTo(from.dx - 10, from.dy)
          ..lineTo(from.dx - 3, from.dy + 8)
          ..lineTo(from.dx + 10, from.dy - 8),
        _paint,
      );
      _paint
        ..color = colour
        ..style = PaintingStyle.fill;
    }
  }

  @override
  bool shouldRepaint(_GesturePainter oldDelegate) {
    return oldDelegate.colour != colour || oldDelegate.from != from || oldDelegate.to != to;
  }

  static const Radius _radius = Radius.circular(24.0);
}
