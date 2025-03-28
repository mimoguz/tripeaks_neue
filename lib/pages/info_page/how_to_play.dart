import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/external_link.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ScrollIndicator(
      child: DefaultTextStyle(
        style: textTheme.bodyMedium!.copyWith(height: 1.8),
        // TODO: Move to arb
        child: ListView(
          padding: EdgeInsets.fromLTRB(c.cardPadding, 0.0, c.cardPadding, c.cardPadding),
          children: [
            ExternalLink(
              uri: Uri.https("en.wikipedia.org", "wiki/Tri_Peaks_(game)"),
              alt: "TriPeaks on Wikipedia",
              label: "Wikipedia article",
            ),
            const SizedBox(height: 12.0),
            Text(
              "In a standard TriPeaks patience (solitaire) game, 28 cards are arranged on the "
              "board in the shape of three peaks: 18 cards face-down and 10 cards face-up. "
              "The remaining  cards form the stock. At the start, the topmost card from "
              "the stock is placed on the discard pile.",
            ),
            const SizedBox(height: 12.0),
            RichText(
              text: TextSpan(
                text:
                    "The objective is to clear all the peaks by removing cards one by one and placing "
                    "them on the discard pile. ",
                style: textTheme.bodyMedium!.copyWith(height: 1.8),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        "A card may be removed from the board only if it is face-up and adjacent to "
                        "the top card of the discard pile, irrespective of its suit.",
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              " The player can move in any direction, "
              "forming sequences such as \"Ace → 2 → 3 → 2 → Ace → King → Queen → King\". "
              "As demonstrated in the example, sequences can loop, so movement from Ace to King "
              "or from King to Ace is possible.",
            ),
            const SizedBox(height: 12.0),
            Text("When a face-down card is no longer blocked by other cards, it is flipped face-up."),
            const SizedBox(height: 12.0),
            Text(
              "If there are no cards on the board that are adjacent to the card on top of the "
              "discard pile (or at any time), the player can draw a card from the stock.",
            ),
            const SizedBox(height: 12.0),
            Text("The game ends when the board is cleared or no more moves are possible."),
            const SizedBox(height: 12.0),
            Text("In addition to the standard game, this app offers:"),
            Row(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("●"), Flexible(child: Text("Three additional board layouts,"))],
            ),
            Row(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("●"),

                Flexible(child: Text("An option to show the values of face-down cards,")),
              ],
            ),
            Row(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("●"),
                Flexible(
                  child: Text(
                    "An option to start with an empty discard pile, allowing the player to choose any starting card.",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
