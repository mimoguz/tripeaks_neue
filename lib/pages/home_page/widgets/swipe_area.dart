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
  bool _drawAction = false;
  OverlayEntry? _overlay;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onVerticalDragStart: (d) => _onDragStart(d, context),
      onVerticalDragEnd: (result) => _onDragEnd(context, result),
      onVerticalDragCancel: _onDragCancel,
      onVerticalDragUpdate: (d) => _onDragUpdate(d, Theme.of(context).colorScheme.tertiary, context),
      child: SizedBox.expand(),
    );
  }

  void _onDragStart(DragStartDetails details, BuildContext context) {
    _watching = true;
    _start = details.globalPosition;
    _updateOverlay(context);
  }

  void _onDragUpdate(DragUpdateDetails details, Color tintColour, BuildContext context) {
    if (!_watching) {
      return;
    }
    final distance = _start.dy - details.globalPosition.dy;
    if (distance <= 0.0) {
      setState(() {
        _fill = Colors.transparent;
        if (_drawAction) {
          _drawAction = false;
        }
      });
      _updateOverlay(context);
      return;
    }
    final t = max(0.0, min(1.0, distance / _distanceThreshold) * 0.667);
    setState(() {
      _end = details.globalPosition;
      _fill = tintColour.withValues(alpha: t);
      _drawAction = distance > _distanceThreshold;
    });
    _updateOverlay(context);
  }

  void _onDragEnd(BuildContext context, DragEndDetails details) {
    _removeOverlay();

    if (!_watching) {
      return;
    }
    if (details.primaryVelocity == null) {
      return;
    }

    final distance = _start.dy - details.globalPosition.dy;

    setState(() {
      _fill = Colors.transparent;
      _watching = false;
      _start = Offset.zero;
      _end = Offset.zero;
      _drawAction = false;
    });

    if (distance > _distanceThreshold) {
      Actions.invoke(context, widget.intent);
    }
  }

  void _onDragCancel() {
    setState(() {
      _watching = false;
      _start = Offset.zero;
      _drawAction = false;
    });
    _removeOverlay();
  }

  void _removeOverlay() {
    _overlay?.remove();
    _overlay?.dispose();
    _overlay = null;
  }

  void _updateOverlay(BuildContext context) {
    _overlay?.remove();
    _overlay?.dispose();
    _overlay = OverlayEntry(
      builder:
          (_) => IgnorePointer(
            child: SizedBox.expand(
              child: CustomPaint(
                painter: _GesturePainter(
                  from: _start,
                  to: _end,
                  colour: _fill,
                  actionColour: Theme.of(context).colorScheme.surfaceContainerLow,
                  drawAction: _drawAction,
                ),
              ),
            ),
          ),
    );
    Overlay.of(context).insert(_overlay!);
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
  }) : _paint =
           Paint()
             ..style = PaintingStyle.stroke
             ..strokeCap = StrokeCap.round;

  final Offset from;
  final Offset to;
  final Color colour;
  final Color actionColour;
  final bool drawAction;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    _paint
      ..color = colour
      ..strokeWidth = 42.0;
    canvas.drawLine(from, Offset(from.dx, to.dy), _paint);
    if (drawAction) {
      _paint
        ..color = actionColour
        ..strokeWidth = 3.0;
      canvas.drawPath(
        Path()
          ..moveTo(from.dx - 10, from.dy)
          ..lineTo(from.dx - 3, from.dy + 7)
          ..lineTo(from.dx + 10, from.dy - 7),
        _paint,
      );
    }
  }

  @override
  bool shouldRepaint(_GesturePainter oldDelegate) {
    return oldDelegate.colour != colour || oldDelegate.from != from || oldDelegate.to != to;
  }
}
