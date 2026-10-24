import 'package:material_ui/material_ui.dart';
import 'package:popover/popover.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

const Duration _transitionDuration = Duration(milliseconds: 100);

Future<T?> showCommonPopover<T>(
  BuildContext context,
  Widget Function(BuildContext) builder, {
  required double width,
  String? semanticsLabel,
  bool showArrow = true,
  PopoverDirection direction = .bottom,
  double dx = 0.0,
  double dy = -10.0,
}) => showPopover<T>(
  context: context,
  semanticsLabel: semanticsLabel,
  style: PopoverStyle(
    radius: c.commonRadius,
    backgroundColor: context.colours.surfaceBright,
    // barrierColor: context.colours.barrier,
    barrierColor: Colors.transparent,
    transitionDuration: _transitionDuration,
    arrowHeight: showArrow ? null : 0.0,
    shadow: <BoxShadow>[
      BoxShadow(color: c.faintShadowColour.withAlpha(50), offset: Offset(0.0, 4.0), blurRadius: 4.0),
    ],
  ),
  barrierDismissible: true,
  bodyBuilder: builder,
  width: width,
  direction: direction,
  contentDxOffset: dx,
  contentDyOffset: dy,
);
