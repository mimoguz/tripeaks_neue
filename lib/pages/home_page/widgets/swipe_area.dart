import 'dart:math';

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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragStart: _onDragStart,
      onVerticalDragEnd: (result) => _onDragEnd(context, result),
      onVerticalDragCancel: _onDragCancel,
      onVerticalDragUpdate: (d) => _onDragUpdate(d, Theme.of(context).colorScheme.tertiary),
      child: SizedBox.expand(
        child: _watching ? CustomPaint(painter: _GesturePainter(_start, _end, _fill)) : null,
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
    if (distance <= _distanceThreshold) {
      setState(() => _fill = Colors.transparent);
      return;
    }
    final t = max(0.05, min(0.25, (distance - _distanceThreshold) / (_distanceThreshold * 10.0)));
    setState(() {
      _end = details.localPosition;
      _fill = tintColour.withValues(alpha: t);
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
  _GesturePainter(this.from, this.to, this.color) : _paint = Paint()..color = color;

  final Offset from;
  final Offset to;
  final Color color;
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
  }

  @override
  bool shouldRepaint(_GesturePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.from != from || oldDelegate.to != to;
  }

  static const Radius _radius = Radius.circular(24.0);
}
