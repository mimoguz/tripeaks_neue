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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: c.itemSpacing,
            children: [
              if (title != null)
                Padding(
                  padding: const EdgeInsets.fromLTRB(c.dialogPadding, c.dialogPadding, c.dialogPadding, 0),
                  child: DefaultTextStyle(
                    style: theme.textTheme.titleMedium!,
                    child: Row(children: [title!]),
                  ),
                ),
              Flexible(
                child: ScrollIndicator(child: SingleChildScrollView(child: content)),
              ),
              if (actions != null && actions!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    c.dialogPadding,
                    0.0,
                    c.dialogPadding,
                    c.dialogPadding,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: c.itemSpacing,
                    children: actions!,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  static const _borderColour = Color(0x15b0d0f0);
}

class CircleIcon extends StatelessWidget {
  const CircleIcon({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(shape: BoxShape.circle, color: colours.tertiaryContainer),
      child: Center(child: Icon(icon, size: 24, color: colours.onTertiaryContainer)),
    );
  }
}
