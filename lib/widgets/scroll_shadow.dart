import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class const ScrollShadow({
  super.key,
  final bool showScrolledUnderShadow = true,
  required final ScrollController controller,
  required final Widget child,
}) extends StatefulWidget {
  @override
  State<ScrollShadow> createState() => _ScrollShadowState();
}

class _ScrollShadowState extends State<ScrollShadow> {
  bool _scrolled = false;
  bool _hasMore = false;
  bool _atEnd = false;

  @override
  void initState() {
    super.initState();
    widget.controller.removeListener(_scrollListener);
    widget.controller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_scrollListener);
  }

  @override
  void activate() {
    super.activate();
    widget.controller.removeListener(_scrollListener);
    widget.controller.addListener(_scrollListener);
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.controller.removeListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    return Stack(
      children: [
        NotificationListener<ScrollMetricsNotification>(
          onNotification: (notification) {
            setState(() {
              setState(() {
                _hasMore = notification.metrics.extentAfter > 0;
              });
            });
            return true;
          },
          child: widget.child,
        ),
        Positioned(
          right: 0,
          left: 0,
          child: IgnorePointer(
            child: _scrolled && widget.showScrolledUnderShadow
                ? Container(
                    key: ValueKey(_scrolled),
                    height: 4,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[colours.headerShadow, Colors.transparent],
                        begin: .topCenter,
                        end: .bottomCenter,
                      ),
                    ),
                  )
                : SizedBox(key: ValueKey(_scrolled)),
          ),
        ),
        Positioned(
          right: 0,
          left: 0,
          bottom: 0,
          child: IgnorePointer(
            child: _hasMore && !_atEnd
                ? Container(
                    key: ValueKey(_hasMore && !_atEnd),
                    height: 12,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[c.darkModeGlow, Colors.transparent],
                        begin: .bottomCenter,
                        end: .topCenter,
                      ),
                    ),
                  )
                : SizedBox(key: ValueKey(_hasMore && !_atEnd)),
          ),
        ),
      ],
    );
  }

  void _scrollListener() {
    setState(() {
      _scrolled = widget.controller.position.pixels > 1;
      _hasMore = widget.controller.position.extentAfter > 0;
      _atEnd = widget.controller.position.pixels >= (widget.controller.position.maxScrollExtent - 1);
    });
  }
}
