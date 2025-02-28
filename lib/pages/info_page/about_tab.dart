import 'package:flutter/material.dart';
import 'package:tripeaks_neue/pages/info_page/expandable_box.dart';
import 'package:tripeaks_neue/pages/info_page/privacy_policy.dart';

class AboutTab extends StatefulWidget {
  const AboutTab({super.key});

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> with AutomaticKeepAliveClientMixin<AboutTab> {
  int _expandIndex = 0;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colours = Theme.of(context).colorScheme;
    return Container(
      color: colours.surfaceContainerLow,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ExpandableBox(
              expanded: _expandIndex == 0,
              title: Text("Privacy Policy"),
              icon: Icon(Icons.privacy_tip, color: colours.outline),
              onTap: () => _onTap(0),
              child: Column(children: [Flexible(child: PrivacyPolicy())]),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) => setState(() => _expandIndex = _expandIndex == index ? -1 : index);
}
