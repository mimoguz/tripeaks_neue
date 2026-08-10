import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class CommonDialog extends StatelessWidget {
  const CommonDialog({super.key, this.actions, this.title, required this.content});

  final List<Widget>? actions;
  final Widget? title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog.adaptive(
      contentPadding: EdgeInsets.zero,
      backgroundColor: theme.colorScheme.surfaceBright,
      shape: RoundedRectangleBorder(borderRadius: c.commonBorderRadius),
      elevation: 20.0,
      shadowColor: theme.colorScheme.shadow,
      content: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: _borderColour),
            borderRadius: c.commonBorderRadius,
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 16.0,
              children: [
                if (title != null)
                  DefaultTextStyle(
                    style: theme.textTheme.titleMedium!,
                    child: Row(children: [title!]),
                  ),
                Flexible(
                  child: ScrollIndicator(child: SingleChildScrollView(child: content)),
                ),
                if (actions != null && actions!.isNotEmpty)
                  Row(mainAxisAlignment: MainAxisAlignment.end, spacing: 12.0, children: actions!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const _borderColour = Color(0x15b0d0f0);
}
