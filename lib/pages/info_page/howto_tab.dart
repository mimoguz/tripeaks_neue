import 'package:flutter/material.dart';
import 'package:tripeaks_neue/pages/info_page/expandable_box.dart';

class HowtoTab extends StatefulWidget {
  const HowtoTab({super.key});

  @override
  State<HowtoTab> createState() => _HowtoTabState();
}

class _HowtoTabState extends State<HowtoTab> {
  int _expandIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        children: [
          ExpandableBox(
            expanded: _expandIndex == 0,
            title: Text("Playing TriPeaks"),
            onTap: () => _onTap(0),
            child: Placeholder(),
          ),
          ExpandableBox(
            expanded: _expandIndex == 1,
            title: Text("Interaction"),
            onTap: () => _onTap(1),
            child: Placeholder(),
          ),
          ExpandableBox(
            expanded: _expandIndex == 2,
            title: Text("Scoring"),
            onTap: () => _onTap(2),
            child: Placeholder(),
          ),
        ],
      ),
    );
  }

  void _onTap(int index) => setState(() => _expandIndex = _expandIndex == index ? -1 : index);
}
