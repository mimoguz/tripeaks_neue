import 'package:fast_rich_text/fast_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/game_button.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';
import 'package:tripeaks_neue/widgets/shortcut_hint.dart';

final class Interaction extends StatelessWidget {
  const Interaction({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final paragraphStyle = theme.textTheme.bodyMedium!.copyWith(height: 1.8);
    final italic = paragraphStyle.copyWith(
      fontStyle: FontStyle.italic,
      color: theme.colorScheme.onSurfaceVariant,
    );
    final s = AppLocalizations.of(context)!;
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
                Theme.of(context).brightness == Brightness.light
                    ? "images/card_counter_light.png"
                    : "images/card_counter_dark.png",
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
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: FastRichText(
                text: s.interactionP10,
                textStyle: theme.textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ShorcutListCell(title: s.infoPageTitle, shorcut: _infoShortcut, textStyle: paragraphStyle),
            ShorcutListCell(title: s.interactionP11, shorcut: _menuShortcutAlt, textStyle: paragraphStyle),
            ShorcutListCell(title: s.interactionP12, shorcut: _backShortcut, textStyle: paragraphStyle),
            ShorcutListCell(title: s.interactionP13, shorcut: _backShortcutAlt, textStyle: paragraphStyle),
            ShorcutListCell(title: s.exitAction, shorcut: _exitShortcut, textStyle: paragraphStyle),
          ],
        ),
      ),
    );
  }

  static final _drawShortcut = <LogicalKeyboardKey>[LogicalKeyboardKey.keyD];
  static final _undoShortcut = <LogicalKeyboardKey>[LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ];
  static final _menuShortcut = <LogicalKeyboardKey>[LogicalKeyboardKey.keyM];
  static final _menuShortcutAlt = <LogicalKeyboardKey>[LogicalKeyboardKey.f10];
  static final _settingsShortcut = <LogicalKeyboardKey>[
    LogicalKeyboardKey.control,
    LogicalKeyboardKey.period,
  ];
  static final _infoShortcut = <LogicalKeyboardKey>[LogicalKeyboardKey.f1];
  static final _backShortcut = <LogicalKeyboardKey>[LogicalKeyboardKey.escape];
  static final _backShortcutAlt = <LogicalKeyboardKey>[LogicalKeyboardKey.backspace];
  static final _exitShortcut = <LogicalKeyboardKey>[LogicalKeyboardKey.control, LogicalKeyboardKey.keyQ];
}

class InteractionListCell extends StatelessWidget {
  const InteractionListCell({super.key, required this.description, this.image, this.shorcut});

  final Widget description;
  final Widget? image;
  final List<LogicalKeyboardKey>? shorcut;

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

class ShorcutListCell extends StatelessWidget {
  const ShorcutListCell({super.key, required this.title, required this.shorcut, required this.textStyle});

  final String title;
  final List<LogicalKeyboardKey> shorcut;
  final TextStyle textStyle;

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

class InteractionListDivider extends StatelessWidget {
  const InteractionListDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const GroupTileDivider(padding: EdgeInsets.symmetric(vertical: 2));
  }
}
