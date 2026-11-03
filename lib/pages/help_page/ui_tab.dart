import 'package:fast_rich_text/fast_rich_text.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/constrained.dart';
import 'package:tripeaks_neue/widgets/shortcut_hint.dart';
import 'package:tripeaks_neue/widgets/sliver_text.dart';

class UiTab extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final s = context.strings;
    final normal = theme.textTheme.bodyMedium!.copyWith(height: 1.8);
    final italic = normal.copyWith(fontStyle: .italic, color: theme.colorScheme.primary);
    return Container(
      color: theme.colorScheme.pageBackground,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverMainAxisGroup(
            slivers: [
              H(Text("How to Use This Application")),
              UiHelpTile(
                description: FastRichText(text: s.interactionP01, textStyle: normal, italicTextStyle: italic),
                image: Icon(Icons.touch_app, color: theme.colorScheme.onSurfaceVariant),
              ),
              SliverDivider(),
              UiHelpTile(
                description: FastRichText(text: s.interactionP04, textStyle: normal, italicTextStyle: italic),
                image: Image.asset(
                  theme.brightness == .light
                      ? "images/card_counter_light.png"
                      : "images/card_counter_dark.png",
                  width: 11,
                  height: 74,
                ),
              ),
              SliverDivider(),
              UiHelpTile(
                description: FastRichText(
                  text: s.interactionRichP02,
                  textStyle: normal,
                  italicTextStyle: italic,
                ),
                image: Container(
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: c.commonBorderRadius,
                  ),
                  child: Icon(CustomIcons.draw, color: theme.colorScheme.onPrimaryContainer),
                ),
                shorcut: _drawShortcut,
              ),
              SliverDivider(),
              UiHelpTile(
                description: FastRichText(text: s.interactionP03, textStyle: normal, italicTextStyle: italic),
                image: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline, width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(CustomIcons.undo, color: theme.colorScheme.primary),
                ),
                shorcut: _undoShortcut,
              ),
              SliverDivider(),
              UiHelpTile(
                description: FastRichText(text: s.interactionP05, textStyle: normal, italicTextStyle: italic),
                image: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    border: Border.all(color: theme.colorScheme.outline, width: 2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(CustomIcons.menu, color: theme.colorScheme.primary),
                ),
                shorcut: _menuShortcut,
              ),
              SliverDivider(),
              UiHelpTile(
                description: FastRichText(text: s.interactionP06, textStyle: normal, italicTextStyle: italic),
                image: Icon(Icons.settings, color: theme.colorScheme.onSurfaceVariant),
                shorcut: _settingsShortcut,
              ),
              SliverDivider(),
              UiHelpTile(
                description: FastRichText(text: s.interactionP07, textStyle: normal, italicTextStyle: italic),
                image: Icon(CustomIcons.pickAndPlay, color: theme.colorScheme.onSurfaceVariant),
                shorcut: _newGameWithLayoutShortcut,
              ),
              SliverDivider(),
              UiHelpTile(
                description: FastRichText(text: s.interactionP08, textStyle: normal, italicTextStyle: italic),
                image: Image.asset("images/tropy72.png", width: 64, height: 64),
              ),
              SliverDivider(),
              UiHelpTile(
                description: FastRichText(text: s.interactionP09, textStyle: normal, italicTextStyle: italic),
                image: Icon(Icons.screen_rotation_rounded, color: theme.colorScheme.onSurfaceVariant),
              ),
              SliverDivider(),
              UiHelpTile(
                description: FastRichText(text: s.interactionP10, textStyle: normal, italicTextStyle: italic),
                image: Icon(Icons.more_vert, color: theme.colorScheme.onSurfaceVariant),
              ),
              SliverDivider(),
            ],
          ),
          SliverMainAxisGroup(
            slivers: [
              H(Text(s.interactionP11, style: TextStyle(fontSize: 16))),
              UiShortcutTile(title: s.infoTooltip, shorcut: _infoShortcut, textStyle: normal),
              UiShortcutTile(title: s.interactionP12, shorcut: _menuShortcutAlt, textStyle: normal),
              UiShortcutTile(title: s.interactionP13, shorcut: _backShortcut, textStyle: normal),
              UiShortcutTile(title: s.interactionP14, shorcut: _backShortcutAlt, textStyle: normal),
              SliverPadding(
                padding: EdgeInsetsGeometry.only(bottom: c.utilPageInsets.bottom),
                sliver: UiShortcutTile(title: s.exitAction, shorcut: _exitShortcut, textStyle: normal),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class const UiHelpTile({
  super.key,
  required final Widget description,
  required final Widget image,
  final List<LogicalKeyboardKey>? shorcut,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedSliver(
      child: Row(
        spacing: c.itemSpacing,
        children: [
          SizedBox(
            width: 64,
            child: Row(mainAxisAlignment: .center, children: [image]),
          ),
          Expanded(
            child: shorcut == null
                ? description
                : Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .start,
                    spacing: c.cellPadding,
                    children: [
                      description,
                      ShortcutHint(shorcut: shorcut!),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

final class const UiShortcutTile({
  super.key,
  required final String title,
  required final List<LogicalKeyboardKey> shorcut,
  required final TextStyle textStyle,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedSliver(
      padding: const EdgeInsets.symmetric(horizontal: c.utilPageMargin, vertical: c.cellPadding),
      child: Row(
        children: [
          Expanded(
            child: FastRichText(text: title, textStyle: textStyle),
          ),
          ShortcutHint(shorcut: shorcut, showLabel: false),
        ],
      ),
    );
  }
}

final _drawShortcut = <LogicalKeyboardKey>[.keyD];
final _undoShortcut = <LogicalKeyboardKey>[.control, .keyZ];
final _menuShortcut = <LogicalKeyboardKey>[.keyM];
final _menuShortcutAlt = <LogicalKeyboardKey>[.f10];
final _settingsShortcut = <LogicalKeyboardKey>[.control, .period];
final _newGameWithLayoutShortcut = <LogicalKeyboardKey>[.control, .shift, .keyN];
final _infoShortcut = <LogicalKeyboardKey>[.f1];
final _backShortcut = <LogicalKeyboardKey>[.escape];
final _backShortcutAlt = <LogicalKeyboardKey>[.backspace];
final _exitShortcut = <LogicalKeyboardKey>[.control, .keyQ];
