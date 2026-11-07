import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/util/platform_utils.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_dialog.dart';
import 'package:tripeaks_neue/widgets/selection_dialog.dart';

Future<T?> showCommonDialog<T>(BuildContext context, Widget Function(BuildContext) builder) =>
    showGeneralDialog<T>(
      context: context,
      barrierColor: context.theme.extension<MyColourThemeExt>()!.platformBarrier,
      barrierDismissible: true,
      barrierLabel: "",
      transitionDuration: _transitionDuration,
      pageBuilder: (context, _, _) => builder(context),
      transitionBuilder: (context, animation, _, child) => FadeTransition(opacity: animation, child: child),
    );

Future<T?> showCommonBottomSheet<T>(BuildContext context, Widget Function(BuildContext) builder) {
  final colourExt = context.theme.extension<MyColourThemeExt>()!;
  return showModalBottomSheet<T>(
    context: context,
    barrierColor: colourExt.platformBarrier,
    backgroundColor: colourExt.dialogBackground,
    shape: c.DialogMetrics.bottomSheetShape,
    isScrollControlled: true,
    elevation: 4.0,
    builder: (context) => builder(context),
  );
}

Future<T?> showPlatformPopover<T>(
  BuildContext context, {
  required Widget title,
  required Widget Function(BuildContext) builder,
}) => showCommonBottomSheet<T>(context, (context) => MyBottomSheet(title: title, content: builder(context)));

Future<T?> showPlatformSelectionPopover<T>(
  BuildContext context, {
  required Widget title,
  required Widget Function(T) itemBuilder,
  required List<T> values,
  required T selected,
}) => showCommonBottomSheet<T>(
  context,
  (context) =>
      MySelectionSheet<T>(title: title, itemBuilder: itemBuilder, selected: selected, values: values),
);

const _transitionDuration = Duration(milliseconds: 150);
