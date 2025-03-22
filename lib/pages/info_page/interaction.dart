import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/game_button.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';
import 'package:tripeaks_neue/widgets/shortcut_hint.dart';

final class Interaction extends StatelessWidget {
  const Interaction({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final s = AppLocalizations.of(context)!;
    return ScrollIndicator(
      child: DefaultTextStyle(
        style: textTheme.bodyMedium!.copyWith(height: 1.8),
        // TODO: Move to arb
        // TODO: Add keyboard shortcuts
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          children: [
            InteractionListCell(
              description: const Text(
                "To remove a card from the board, just tap on it. If it is a valid move, "
                "the card will be moved on top of the discard pile; otherwise, it will "
                "wobble momentarily.",
              ),
              image: Icon(Icons.touch_app),
            ),
            const SizedBox(height: 24.0),
            InteractionListCell(
              description: RichText(
                text: TextSpan(
                  text: "This is the draw button. Pressing this, ",
                  style: textTheme.bodyMedium!.copyWith(height: 1.8),
                  children: const <TextSpan>[
                    TextSpan(
                      text:
                          "or swiping up on an otherwise non-actionable part (except the very edges) "
                          "of the game screen",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                    TextSpan(
                      text: " will draw a card from the stock and place it on top of the discard pile.",
                    ),
                  ],
                ),
              ),
              image: GameButton.narrow(
                scale: 0.7,
                icon: CustomIcons.draw,
                onPressed: () {},
                tooltip: s.drawTooltip,
              ),
              shorcut: _drawShortcut,
            ),
            const SizedBox(height: 24.0),
            InteractionListCell(
              description: const Text(
                "This is the undo button. Pressing this will roll back the last move. "
                "This can go back to the very beginning of the game.",
              ),
              image: CircleGameButton(
                scale: 1.0,
                icon: CustomIcons.undo,
                tooltip: s.undoTooltip,
                onPressed: () {},
              ),
              shorcut: _undoShortcut,
            ),
            const SizedBox(height: 24.0),
            InteractionListCell(
              description: const Text("This is the menu button."),
              image: CircleGameButton(
                scale: 1.0,
                icon: CustomIcons.menu,
                tooltip: s.menuTooltip,
                onPressed: () {},
              ),
              shorcut: _menuShortcut,
            ),
            const SizedBox(height: 24.0),
            InteractionListCell(
              description: const Text(
                "From the menu, different game modes can be selected by visiting the settings page,",
              ),
              image: Icon(Icons.settings),
              shorcut: _settingsShortcut,
            ),
            const SizedBox(height: 24.0),
            InteractionListCell(
              description: Text("or by using \"${s.newGameWithLayoutAction}\" option."),
              image: Icon(CustomIcons.pickAndPlay),
            ),
            const SizedBox(height: 24.0),
            InteractionListCell(
              description: Text(
                "When a game ends, you will see an \"ending card\". "
                "They are not modal dialogs, and they don't block interaction with "
                "the other parts of the interface.",
              ),
              image: Image.asset("images/tropy.png", width: c.maxRealButtonSize, height: c.maxRealButtonSize),
            ),
            const SizedBox(height: 24.0),
            InteractionListCell(
              description: Text("The game supports both portrait and landscape orientations."),
              image: Icon(Icons.screen_rotation),
            ),
            SizedBox(height: 16.0),
            Divider(),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 8),
              child: Text(
                "Other Shorcuts",
                style: textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.outline),
              ),
            ),
            ShorcutListCell(title: s.infoPageTitle, shorcut: _infoShortcut),
            ShorcutListCell(title: "Back", shorcut: _backShortcut),
            ShorcutListCell(title: "Back (alternative)", shorcut: _backShortcutAlt),
            ShorcutListCell(title: s.exitAction, shorcut: _exitShortcut),
          ],
        ),
      ),
    );
  }

  static final _drawShortcut = <LogicalKeyboardKey>[LogicalKeyboardKey.keyD];
  static final _undoShortcut = <LogicalKeyboardKey>[LogicalKeyboardKey.control, LogicalKeyboardKey.keyZ];
  static final _menuShortcut = <LogicalKeyboardKey>[LogicalKeyboardKey.keyM];
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            spacing: 6,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [description, if (shorcut != null) ShortcutHint(shorcut: shorcut!)],
          ),
        ),
        SizedBox(width: c.buttonSize * 0.7, child: Align(alignment: Alignment.topRight, child: image)),
      ],
    );
  }
}

class ShorcutListCell extends StatelessWidget {
  const ShorcutListCell({super.key, required this.title, required this.shorcut});

  final String title;
  final List<LogicalKeyboardKey> shorcut;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), ShortcutHint(shorcut: shorcut, showLabel: false)],
      ),
    );
  }
}
