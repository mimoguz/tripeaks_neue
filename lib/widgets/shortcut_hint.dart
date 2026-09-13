import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

class const KeyboardKey({super.key, required final LogicalKeyboardKey keyboardKey}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
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

class const ShortcutHint({
  super.key,
  required final List<LogicalKeyboardKey> shorcut,
  final bool showLabel = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: 6,
      children: [
        if (showLabel) Text(s.shortcutTitle, style: const TextStyle(fontStyle: FontStyle.italic)),
        for (final k in shorcut) KeyboardKey(keyboardKey: k),
      ],
    );
  }
}
