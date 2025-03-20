import 'package:flutter/material.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/game_button.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

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
            ),
            const SizedBox(height: 24.0),
            InteractionListCell(
              description: const Text(
                "From the menu, different game modes can be selected by visiting the settings page,",
              ),
              image: Icon(Icons.settings),
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
          ],
        ),
      ),
    );
  }
}

class InteractionListCell extends StatelessWidget {
  const InteractionListCell({super.key, required this.description, this.image});

  final Widget description;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 12.0,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(child: description),
        SizedBox(width: c.buttonSize * 0.7, child: Align(alignment: Alignment.topCenter, child: image)),
      ],
    );
  }
}
