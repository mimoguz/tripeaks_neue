import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class Scoring extends StatelessWidget {
  const Scoring({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ScrollIndicator(
      child: DefaultTextStyle(
        style: textTheme.bodyMedium!.copyWith(height: 1.8),
        // TODO: Move to arb
        child: ListView(
          padding: const EdgeInsets.fromLTRB(c.cardPadding, 0.0, c.cardPadding, c.cardPadding),
          children: [
            RichText(
              text: TextSpan(
                text: "Removing cards from the board one after the other creates a ",
                style: textTheme.bodyMedium!.copyWith(height: 1.8),
                children: <TextSpan>[
                  TextSpan(text: "chain.", style: const TextStyle(fontStyle: FontStyle.italic)),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              "A chain ends when the player draws a card from the stock, or when the "
              "game ends. Using undo will only decrease the current chain's length, "
              "it will not end it. ",
            ),
            const SizedBox(height: 12.0),
            RichText(
              text: TextSpan(
                text: "When a chain ends, the player gains a score equal to the ",
                style: textTheme.bodyMedium!.copyWith(height: 1.8),
                children: <TextSpan>[
                  TextSpan(text: "square", style: const TextStyle(fontStyle: FontStyle.italic)),
                  TextSpan(
                    text:
                        " of that chain's length: 1 point for one card, "
                        "4 points for two cards, 9 points for three cards, and so on.",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              "When the board is cleared, the player gains a bonus score equal "
              "to the number of cards on the board at the start of the game. ",
            ),
            const SizedBox(height: 12.0),
            Text(
              "While clearing the board is the goal, you can easily get a higher "
              "score by creating long chains, even if you can't clear it. "
              "Play any way you want.",
            ),
          ],
        ),
      ),
    );
  }
}
