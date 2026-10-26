import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class const MyDialog({
  super.key,
  required final Widget title,
  required final Widget content,
  final List<Widget>? actions,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      titleTextStyle: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
      title: Row(
        mainAxisAlignment: .spaceBetween,
        crossAxisAlignment: .center,
        children: [
          title,
          CloseButton(
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
            ),
          ),
        ],
      ),
      titlePadding: c.DialogMetrics.titlePadding,
      contentPadding: EdgeInsets.zero,
      actionsPadding: c.DialogMetrics.actionsPadding,
      surfaceTintColor: theme.colorScheme.surfaceContainerHighest,
      backgroundColor: theme.colorScheme.surfaceContainerHighest,
      shadowColor: theme.shadowColor,
      actionsAlignment: .center,
      elevation: 4.0,
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          const DialogDivider(),
          Flexible(child: SingleChildScrollView(primary: false, child: content)),
          if (actions != null && actions!.isNotEmpty) const DialogDivider(),
        ],
      ),
      shape: c.DialogMetrics.shape,
      actions: actions,
    );
  }
}

final class DialogDivider extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Container(height: 1.0, color: colours.onSurface.withAlpha(colours.brightness == .light ? 50 : 15));
  }
}
