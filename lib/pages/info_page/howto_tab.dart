import 'package:flutter/material.dart';
import 'package:tripeaks_neue/pages/info_page/expandable_box.dart';
import 'package:tripeaks_neue/pages/info_page/playing.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ExpandableBox(
              expanded: _expandIndex == 0,
              title: Text("Playing TriPeaks"),
              icon: Icon(Icons.play_arrow, color: colours.outline),
              onTap: () => _onTap(0),
              child: Column(children: [Flexible(child: HowToPlay())]),
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
      ),
    );
  }

  void _onTap(int index) => setState(() => _expandIndex = _expandIndex == index ? -1 : index);
}
