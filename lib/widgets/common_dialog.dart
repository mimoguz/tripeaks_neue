import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class const CommonDialog({
  super.key,
  final List<Widget>? actions,
  final Widget? title,
  final Color? tint,
  required final Widget content,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return AlertDialog.adaptive(
      contentPadding: EdgeInsets.zero,
      titlePadding: _titlePadding,
      actionsPadding: _actionsPadding,
      titleTextStyle: theme.textTheme.titleMedium,
      surfaceTintColor: tint,
      scrollable: false,
      backgroundColor: theme.colorScheme.surfaceBright,
      shape: RoundedRectangleBorder(borderRadius: c.commonBorderRadius),
      elevation: 4.0,
      shadowColor: c.faintShadowColour,
      title: title,
      content: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: c.itemSpacing,
          children: [Flexible(child: SingleChildScrollView(child: content))],
        ),
      ),
      actions: actions,
    );
  }

  static const _titlePadding = EdgeInsets.fromLTRB(
    c.dialogPadding,
    c.dialogPadding,
    c.dialogPadding,
    c.itemSpacing,
  );

  static const _actionsPadding = EdgeInsets.fromLTRB(
    c.dialogPadding,
    c.itemSpacing - 10,
    c.dialogPadding,
    c.dialogPadding - 6,
  );
}

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
