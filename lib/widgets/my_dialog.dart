import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class const MyDialog({
  super.key,
  required final Widget title,
  required final Widget content,
  final List<Widget>? actions,
  final MainAxisAlignment? actionsAlignment,
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
              backgroundColor: theme.colorScheme.outlineVariant,
              foregroundColor: theme.colorScheme.onSurfaceVariant,
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
      actionsAlignment: actionsAlignment ?? .center,
      elevation: 4.0,
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          const DialogDivider(),
          Flexible(child: SingleChildScrollView(primary: false, child: content)),
          if (actions != null && actions!.isNotEmpty) const DialogDivider(),
          if (actions == null || actions!.isEmpty) const SizedBox(height: c.DialogMetrics.verticalPadding),
        ],
      ),
      shape: c.DialogMetrics.shape,
      actions: actions,
    );
  }
}

final class const MyBottomSheet({
  super.key,
  required final Widget title,
  required final Widget content,
  final List<Widget>? actions,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: .min,
      children: [
        Padding(
          padding: c.DialogMetrics.titlePadding,
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              DefaultTextStyle(style: theme.textTheme.headlineSmall!, child: title),
              CloseButton(
                style: FilledButton.styleFrom(
                  backgroundColor: theme.colorScheme.outlineVariant,
                  foregroundColor: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        DialogDivider(),
        Flexible(child: SingleChildScrollView(child: content)),
        if (actions != null && actions!.isNotEmpty) ...[
          DialogDivider(),
          Padding(
            padding: c.DialogMetrics.safeActionsPadding,
            child: Row(mainAxisAlignment: .end, spacing: 16.0, children: actions!),
          ),
        ],
        if (actions == null || actions!.isEmpty) SizedBox(height: c.DialogMetrics.safeActionsPadding.bottom),
      ],
    );
  }
}

final class DialogDivider extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Container(height: 1.0, color: colours.onSurface.withAlpha(colours.brightness == .light ? 30 : 15));
  }
}
