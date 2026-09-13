import 'package:fast_rich_text/fast_rich_text.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/game_button.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';
import 'package:tripeaks_neue/widgets/shortcut_hint.dart';

final class const Interaction({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final paragraphStyle = theme.textTheme.bodyMedium!.copyWith(height: 1.8);
    final italic = paragraphStyle.copyWith(fontStyle: FontStyle.italic, color: theme.colorScheme.secondary);
    final s = context.strings;
    return ScrollIndicator(
      child: DefaultTextStyle(
        style: paragraphStyle,
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            c.cardPaddingHorizontal,
            0.0,
            c.cardPaddingHorizontal,
            c.cardPaddingVertical,
          ),
          children: [
            InteractionListCell(
              description: FastRichText(
                text: s.interactionP01,
                textStyle: paragraphStyle,
                italicTextStyle: italic,
              ),
              image: Icon(Icons.touch_app),
            ),
            const InteractionListDivider(),
            InteractionListCell(
              description: FastRichText(
                text: s.interactionRichP02,
                textStyle: paragraphStyle,
                italicTextStyle: italic,
              ),
              image: GameButton.narrow(
                scale: 0.7,
                icon: CustomIcons.draw,
                onPressed: () {},
                tooltip: s.drawTooltip,
              ),
              shorcut: _drawShortcut,
            ),
            const InteractionListDivider(),
            InteractionListCell(
              description: FastRichText(
                text: s.interactionP03,
                textStyle: paragraphStyle,
                italicTextStyle: italic,
              ),
              image: CircleGameButton(
                scale: 1.0,
                icon: CustomIcons.undo,
                tooltip: s.undoTooltip,
                onPressed: () {},
              ),
              shorcut: _undoShortcut,
            ),
            const InteractionListDivider(),
            InteractionListCell(
              description: FastRichText(
                text: s.interactionP04,
                textStyle: paragraphStyle,
                italicTextStyle: italic,
              ),
              image: Image.asset(
                theme.brightness == .light ? "images/card_counter_light.png" : "images/card_counter_dark.png",
                width: 11,
                height: 74,
              ),
            ),
            const InteractionListDivider(),
            InteractionListCell(
              description: FastRichText(
                text: s.interactionP05,
                textStyle: paragraphStyle,
                italicTextStyle: italic,
              ),
              image: CircleGameButton(
                scale: 1.0,
                icon: CustomIcons.menu,
                tooltip: s.menuTooltip,
                onPressed: () {},
              ),
              shorcut: _menuShortcut,
            ),
            const InteractionListDivider(),
            InteractionListCell(
              description: FastRichText(
                text: s.interactionP06,
                textStyle: paragraphStyle,
                italicTextStyle: italic,
              ),
              image: Icon(Icons.settings),
              shorcut: _settingsShortcut,
            ),
            const InteractionListDivider(),
            InteractionListCell(
              description: FastRichText(
                text: s.interactionP07,
                textStyle: paragraphStyle,
                italicTextStyle: italic,
              ),
              image: Icon(CustomIcons.pickAndPlay),
              shorcut: _newGameWithLayoutShortcut,
            ),
            const InteractionListDivider(),
            InteractionListCell(
              description: FastRichText(
                text: s.interactionP08,
                textStyle: paragraphStyle,
                italicTextStyle: italic,
              ),
              image: Image.asset("images/tropy.png", width: c.maxRealButtonSize, height: c.maxRealButtonSize),
            ),
            const InteractionListDivider(),
            InteractionListCell(
              description: FastRichText(
                text: s.interactionP09,
                textStyle: paragraphStyle,
                italicTextStyle: italic,
              ),
              image: Icon(Icons.screen_rotation),
            ),
            const InteractionListDivider(),
            InteractionListCell(
              description: FastRichText(
                text: s.interactionP10,
                textStyle: paragraphStyle,
                italicTextStyle: italic,
              ),
              image: Icon(Icons.more_vert),
            ),
            const InteractionListDivider(),
            Padding(
              padding: const EdgeInsets.only(bottom: 6.0),
              child: FastRichText(text: s.interactionP11, textStyle: theme.textTheme.titleSmall!),
            ),
            ShorcutListCell(title: s.infoPageTitle, shorcut: _infoShortcut, textStyle: paragraphStyle),
            ShorcutListCell(title: s.interactionP12, shorcut: _menuShortcutAlt, textStyle: paragraphStyle),
            ShorcutListCell(title: s.interactionP13, shorcut: _backShortcut, textStyle: paragraphStyle),
            ShorcutListCell(title: s.interactionP14, shorcut: _backShortcutAlt, textStyle: paragraphStyle),
            ShorcutListCell(title: s.exitAction, shorcut: _exitShortcut, textStyle: paragraphStyle),
          ],
        ),
      ),
    );
  }

  static final _drawShortcut = <LogicalKeyboardKey>[.keyD];
  static final _undoShortcut = <LogicalKeyboardKey>[.control, .keyZ];
  static final _menuShortcut = <LogicalKeyboardKey>[.keyM];
  static final _menuShortcutAlt = <LogicalKeyboardKey>[.f10];
  static final _settingsShortcut = <LogicalKeyboardKey>[.control, .period];
  static final _newGameWithLayoutShortcut = <LogicalKeyboardKey>[.control, .shift, .keyN];
  static final _infoShortcut = <LogicalKeyboardKey>[.f1];
  static final _backShortcut = <LogicalKeyboardKey>[.escape];
  static final _backShortcutAlt = <LogicalKeyboardKey>[.backspace];
  static final _exitShortcut = <LogicalKeyboardKey>[.control, .keyQ];
}

class const InteractionListCell({
  super.key,
  required final Widget description,
  final Widget? image,
  final List<LogicalKeyboardKey>? shorcut,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.0,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Column(
            spacing: 6,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              description,
              if (shorcut != null) ShortcutHint(shorcut: shorcut!),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8),
          width: c.buttonSize * 0.7,
          child: Align(alignment: Alignment.center, child: image),
        ),
      ],
    );
  }
}

class const ShorcutListCell({
  super.key,
  required final String title,
  required final List<LogicalKeyboardKey> shorcut,
  required final TextStyle textStyle,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: c.divPadding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FastRichText(text: title, textStyle: textStyle),
          ShortcutHint(shorcut: shorcut, showLabel: false),
        ],
      ),
    );
  }
}

class const InteractionListDivider({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const GroupTileDivider(padding: EdgeInsets.symmetric(vertical: 2));
  }
}
