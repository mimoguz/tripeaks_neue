import 'package:flutter/material.dart';
import 'package:tripeaks_neue/pages/info_page/expandable_box.dart';
import 'package:tripeaks_neue/pages/info_page/how_to_play.dart';
import 'package:tripeaks_neue/pages/info_page/interaction.dart';
import 'package:tripeaks_neue/pages/info_page/scoring.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class HowtoTab extends StatefulWidget {
  const HowtoTab({super.key});

  @override
  State<HowtoTab> createState() => _HowtoTabState();
}

class _HowtoTabState extends State<HowtoTab> with AutomaticKeepAliveClientMixin<HowtoTab> {
  int _expandIndex = -1;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colours = Theme.of(context).colorScheme;
    return Container(
      color: colours.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(c.utilPageMargin),
        child: Column(
          spacing: c.utilPageMargin,
          children: [
            ExpandableBox(
              expanded: _expandIndex == 0,
              title: Text("Playing Tri Peaks"),
              icon: Icon(Icons.play_arrow, color: colours.outline),
              onTap: () => _onTap(0),
              child: Column(children: [Flexible(child: HowToPlay())]),
            ),
            ExpandableBox(
              expanded: _expandIndex == 1,
              title: Text("User Interface & Interaction"),
              icon: Icon(Icons.touch_app, color: colours.outline),
              onTap: () => _onTap(1),
              child: Interaction(),
            ),
            ExpandableBox(
              expanded: _expandIndex == 2,
              title: Text("Scoring"),
              icon: Icon(Icons.star_border, color: colours.outline),
              onTap: () => _onTap(2),
              child: Scoring(),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) => setState(() => _expandIndex = _expandIndex == index ? -1 : index);
}
