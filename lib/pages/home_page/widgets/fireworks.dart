import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';

class Fireworks extends StatefulWidget {
  const Fireworks({
    super.key,
    required this.color,
    required this.duration,
    required this.id,
    required this.score,
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
  final int score;
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
    _controller = AnimationController(vsync: this, duration: widget.duration);
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
              transitionBuilder:
                  (child, animation) => SlideTransition(
                    position: Tween<Offset>(begin: Offset(0, 1), end: Offset.zero).animate(animation),
                    child: FadeTransition(opacity: animation, child: child),
                  ),
              child: ClearedCard(key: ValueKey(widget.id), score: widget.score),
            ),
          ),
        ],
      ),
    );
  }
}

class ClearedCard extends StatelessWidget {
  const ClearedCard({super.key, required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return Card.filled(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16.0,
            children: [
              Image.asset("images/tropy.png", width: 90, height: 90),
              Text("Cleared!", style: Theme.of(context).textTheme.titleLarge, textAlign: TextAlign.center),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 8,
                children: [
                  Icon(Icons.stars, size: 24.0, color: Theme.of(context).colorScheme.tertiary),
                  Text("$score", style: Theme.of(context).textTheme.labelMedium),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: Actions.handler(context, const NewGameIntent()),
                    child: Text(s.newGameButtonLabel),
                  ),
                ],
              ),
            ],
          ),
        ),
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
  }) : _paint =
           Paint()
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
