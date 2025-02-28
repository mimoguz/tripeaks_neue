import 'package:flutter/material.dart';
import 'package:tripeaks_neue/pages/info_page/expandable_box.dart';
import 'package:tripeaks_neue/widgets/external_link.dart';

class HowtoTab extends StatefulWidget {
  const HowtoTab({super.key});

  @override
  State<HowtoTab> createState() => _HowtoTabState();
}

class _HowtoTabState extends State<HowtoTab> {
  int _expandIndex = -1;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Container(
      color: colours.surfaceContainerLow,
      child: Column(
        children: [
          ExpandableBox(
            expanded: _expandIndex == 0,
            title: Text("Playing TriPeaks"),
            icon: Icon(Icons.play_arrow, color: colours.outline),
            onTap: () => _onTap(0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 12.0),
              child: Column(
                children: [
                  Flexible(
                    child: SingleChildScrollView(
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 12.0,
                          children: [
                            ExternalLink(
                              uri: Uri.https("en.wikipedia.org", "/wiki/Tri_Peaks_(game)"),
                              alt: "TriPeaks on Wikipedia",
                              label: "Wikipedia article",
                            ),
                            // TODO: Rich text, move to arb
                            Text(
                              "In a standard TriPeaks solitaire game, 28 cards are arranged on the board in the "
                              "shape of three peaks: 18 cards face-down and 10 cards face-up. The remaining "
                              "cards form the stock. At the start, the topmost card from the stock is placed on "
                              "the discard pile.",
                            ),
                            Text(
                              "The objective is to clear all the peaks by removing cards one by one and placing "
                              "them on the discard pile. A card can be removed if it is face-up and adjacent to "
                              "the card on top of the discard pile. The player can move in any direction, "
                              "forming sequences such as 'Ace-Two-Three-Two-Ace-King'. "
                              "As demonstrated in the example, sequences can loop, so movement from Ace to King "
                              "or from King to Ace is possible.",
                            ),
                            Text(
                              "When a face-down card is no longer blocked by other cards, it is flipped face-up.",
                            ),
                            Text(
                              "If there are no cards on the board that are adjacent to the card on top of the "
                              "discard pile (or at any time), the player can draw a card from the stock.",
                            ),
                            Text("The game ends when the board is empty or no more moves are possible."),
                            Text("In addition to the standard game, this app offers:"),
                            Row(
                              spacing: 8.0,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                                  child: Icon(Icons.circle, size: 6),
                                ),
                                Flexible(child: Text("Three additional board layouts,")),
                              ],
                            ),
                            Row(
                              spacing: 8.0,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                                  child: Icon(Icons.circle, size: 6),
                                ),
                                Flexible(child: Text("An option to show the values of face-down cards,")),
                              ],
                            ),
                            Row(
                              spacing: 8.0,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, left: 16.0),
                                  child: Icon(Icons.circle, size: 6),
                                ),
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          ExpandableBox(
            expanded: _expandIndex == 1,
            title: Text("Interaction"),
            icon: Icon(Icons.touch_app, color: colours.outline),
            onTap: () => _onTap(1),
            child: Placeholder(),
          ),
          ExpandableBox(
            expanded: _expandIndex == 2,
            title: Text("Scoring"),
            icon: Icon(Icons.star_border, color: colours.outline),
            onTap: () => _onTap(2),
            child: Placeholder(),
          ),
        ],
      ),
    );
  }

  void _onTap(int index) => setState(() => _expandIndex = _expandIndex == index ? -1 : index);
}
