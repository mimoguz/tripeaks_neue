import 'package:flutter/material.dart';

class ScrollIndicator extends StatefulWidget {
  const ScrollIndicator({super.key, required this.child});

  final Widget child;

  @override
  State<ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<ScrollIndicator> {
  bool _atEnd = false;

  bool get atEnd => _atEnd;
  set atEnd(bool value) {
    if (value == _atEnd) {
      return;
    }
    setState(() => _atEnd = value);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          right: 8.0,
          bottom: 8.0,
          child: AnimatedSwitcher(
            duration: Durations.medium3,
            child: _atEnd ? SizedBox() : Icon(Icons.more_horiz, color: Theme.of(context).colorScheme.outline),
          ),
        ),
        NotificationListener<ScrollMetricsNotification>(
          onNotification: (notification) {
            atEnd = notification.metrics.pixels >= notification.metrics.maxScrollExtent;
            return true;
          },
          child: widget.child,
        ),
      ],
    );
  }
}
