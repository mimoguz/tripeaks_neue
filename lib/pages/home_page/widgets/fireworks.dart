import 'dart:math';

import 'package:flutter/material.dart';

class Fireworks extends StatefulWidget {
  const Fireworks({
    super.key,
    required this.color,
    required this.duration,
    required this.id,
    this.maxRadius = 16.0,
    this.maxDistance = 200,
    this.trailThickness = 2.0,
    this.particleCount = 8,
  });

  final Color color;
  final double maxRadius;
  final double maxDistance;
  final double trailThickness;
  final int id;
  final int particleCount;
  final Duration duration;

  @override
  State<Fireworks> createState() => _FireworksState();
}

class _FireworksState extends State<Fireworks> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _t = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller.addListener(_animate);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.removeListener(_animate);
    _controller.dispose();
    super.dispose();
  }

  void _animate() {
    setState(() {
      _t = _controller.value > 0 ? sqrt(_controller.value) : 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = (widget.maxRadius + widget.maxDistance) * 2.0;
    // _controller.forward();
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          Center(
            child: AnimatedSwitcher(
              duration: widget.duration,
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
              child: Icon(
                key: ValueKey(widget.id + 1),
                Icons.stars,
                size: 48.0,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
            ),
          ),
          Center(
            child: CustomPaint(
              painter: _FireworkPainter(
                t: _t,
                color: widget.color,
                maxRadius: widget.maxRadius,
                maxDistance: widget.maxDistance,
                trailThickness: widget.trailThickness,
                particleCount: widget.particleCount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FireworkPainter extends CustomPainter {
  _FireworkPainter({
    required this.t,
    required this.color,
    required this.maxRadius,
    required this.maxDistance,
    required this.trailThickness,
    required this.particleCount,
  }) : _paint = Paint()
          ..color = color
          ..strokeWidth = trailThickness;

  final double t;
  final double maxRadius;
  final double trailThickness;
  final double maxDistance;
  final Color color;
  final int particleCount;
  final Paint _paint;

  @override
  void paint(Canvas canvas, Size size) {
    if (t > 1) {
      return;
    }
    final d1 = t * maxDistance;
    final d0 = d1 > 1.0 ? sqrt(d1) : 0.0;
    final r = max(t * maxRadius, trailThickness / 2.0);
    final rotation = t * pi;
    _paint.color = color.withValues(alpha: 1.0 - t);
    for (var particle = 0; particle < particleCount; particle++) {
      final angle = 2 * pi * particle / particleCount + rotation;
      final cosine = cos(angle);
      final sine = sin(angle);
      final x0 = cosine * d0;
      final y0 = sine * d0;
      final x1 = cosine * d1;
      final y1 = sine * d1;
      canvas.drawLine(Offset(x0, y0), Offset(x1, y1), _paint);
      canvas.drawCircle(Offset(x1, y1), r, _paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is _FireworkPainter && oldDelegate.t != t;
}
