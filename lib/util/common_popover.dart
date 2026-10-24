import 'package:material_ui/material_ui.dart';
import 'package:popover/popover.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

const Duration _transitionDuration = Duration(milliseconds: 100);

Future<T?> showCommonPopover<T>(
  BuildContext context,
  Widget Function(BuildContext) builder, {
  double? width,
  String? semanticsLabel,
}) => showPopover<T>(
  context: context,
  semanticsLabel: semanticsLabel,
  style: PopoverStyle(
    radius: c.commonRadius,
    backgroundColor: context.colours.surfaceBright,
    barrierColor: context.colours.barrier,
    transitionDuration: _transitionDuration,
    arrowHeight: 0.0,
  ),
  barrierDismissible: true,
  bodyBuilder: builder,
  width: width,
  direction: .bottom,
  contentDyOffset: -68,
);
