import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

class const ScrollIndicator({super.key, required final Widget child}) extends StatefulWidget {
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
        NotificationListener<ScrollMetricsNotification>(
          onNotification: (notification) {
            atEnd = notification.metrics.pixels >= notification.metrics.maxScrollExtent;
            return true;
          },
          child: widget.child,
        ),
        Positioned(
          right: 8.0,
          bottom: 8.0,
          child: AnimatedSwitcher(
            duration: Durations.medium3,
            child: _atEnd ? SizedBox() : Icon(Icons.more_horiz, color: context.colours.secondary),
          ),
        ),
      ],
    );
  }
}
