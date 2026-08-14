import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({super.key, this.actions, this.title, this.tint, required this.content});

  final List<Widget>? actions;
  final Widget? title;
  final Widget content;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog.adaptive(
      contentPadding: EdgeInsets.zero,
      titlePadding: const EdgeInsets.fromLTRB(
        c.dialogPadding,
        c.dialogPadding,
        c.dialogPadding,
        c.itemSpacing,
      ),
      actionsPadding: const EdgeInsets.fromLTRB(
        c.dialogPadding,
        c.itemSpacing - 10,
        c.dialogPadding,
        c.dialogPadding - 6,
      ),
      titleTextStyle: theme.textTheme.titleMedium?.copyWith(fontWeight: .w600),
      surfaceTintColor: tint ?? theme.colorScheme.primaryContainer,
      scrollable: false,
      backgroundColor: theme.colorScheme.surfaceBright,
      shape: RoundedRectangleBorder(borderRadius: c.commonBorderRadius),
      elevation: 20.0,
      shadowColor: theme.colorScheme.shadow,
      title: title,
      content: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: c.itemSpacing,
          children: [
            Flexible(
              child: ScrollIndicator(child: SingleChildScrollView(child: content)),
            ),
          ],
        ),
      ),
      actions: actions,
    );
  }
}
