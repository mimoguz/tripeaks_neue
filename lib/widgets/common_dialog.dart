import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

Future<T?> showCommonDialog<T>(BuildContext context, Widget Function(BuildContext) builder) =>
    showGeneralDialog<T>(
      context: context,
      barrierColor: context.colours.barrier,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: _transitionDuration,
      pageBuilder: (context, _, _) => builder(context),
      transitionBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
    );

Future<T?> showCommonBottomSheet<T>(BuildContext context, Widget Function(BuildContext) builder) {
  final colours = context.colours;
  return showModalBottomSheet<T>(
    context: context,
    barrierColor: colours.barrier,
    backgroundColor: colours.dialogBackground,
    shape: c.DialogMetrics.bottomSheetShape,
    isScrollControlled: true,
    elevation: 4.0,
    builder: (context) => builder(context),
  );
}

const _transitionDuration = Duration(milliseconds: 150);
