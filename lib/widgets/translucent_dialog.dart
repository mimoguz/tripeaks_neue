import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class TranslucentDialog extends StatelessWidget {
  const TranslucentDialog({super.key, this.actions, this.title, required this.content});

  final List<Widget>? actions;
  final Widget? title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return AlertDialog.adaptive(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: ClipRRect(
        borderRadius: c.commonBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
          child: Material(
            color: colours.surfaceContainer.withAlpha(210),
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: _borderColour),
                borderRadius: c.commonBorderRadius,
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 16.0,
                  children: [
                    if (title != null)
                      DefaultTextStyle(
                        style: Theme.of(context).textTheme.titleMedium!,
                        child: Row(children: [title!]),
                      ),
                    Flexible(child: ScrollIndicator(child: SingleChildScrollView(child: content))),
                    if (actions != null && actions!.isNotEmpty)
                      Row(mainAxisAlignment: MainAxisAlignment.end, spacing: 12.0, children: actions!),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  static const _borderColour = Color(0x15b0d0f0);
}
