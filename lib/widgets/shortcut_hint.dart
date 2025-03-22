import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KeyboardKey extends StatelessWidget {
  const KeyboardKey({super.key, required this.keyboardKey});

  final LogicalKeyboardKey keyboardKey;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceBright,
        borderRadius: _borderRadius,
        boxShadow: <BoxShadow>[
          BoxShadow(color: theme.colorScheme.surfaceDim, blurRadius: 0, offset: _shadowOffset),
        ],
      ),
      padding: _padding,
      child: Text(keyboardKey.keyLabel, style: theme.textTheme.labelMedium),
    );
  }

  static const _borderRadius = BorderRadius.all(Radius.circular(4));
  static const _shadowOffset = Offset(0, 4);
  static const _padding = EdgeInsets.symmetric(horizontal: 8, vertical: 4);
}

class ShortcutHint extends StatelessWidget {
  const ShortcutHint({super.key, required this.shorcut, this.showLabel = true});

  final List<LogicalKeyboardKey> shorcut;
  final bool showLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [if (showLabel) Text("Shortcut: "), for (final k in shorcut) KeyboardKey(keyboardKey: k)],
    );
  }
}
