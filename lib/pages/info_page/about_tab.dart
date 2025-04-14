import 'package:flutter/material.dart';
import 'package:tripeaks_neue/pages/info_page/dependencies.dart';
import 'package:tripeaks_neue/pages/info_page/expandable_box.dart';
import 'package:tripeaks_neue/pages/info_page/licenses.dart';
import 'package:tripeaks_neue/pages/info_page/privacy_policy.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class AboutTab extends StatefulWidget {
  const AboutTab({super.key});

  @override
  State<AboutTab> createState() => _AboutTabState();
}

class _AboutTabState extends State<AboutTab> with AutomaticKeepAliveClientMixin<AboutTab> {
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
              title: Text("Privacy Policy"),
              icon: Icon(Icons.privacy_tip, color: colours.outline),
              onTap: () => _onTap(0),
              child: Column(children: [Flexible(child: PrivacyPolicy())]),
            ),
            ExpandableBox(
              expanded: _expandIndex == 1,
              title: Text("Licenses"),
              icon: Icon(Icons.copyright, color: colours.outline),
              onTap: () => _onTap(1),
              child: Column(children: [Flexible(child: Licenses())]),
            ),
            ExpandableBox(
              expanded: _expandIndex == 2,
              title: Text("Dependencies"),
              icon: Icon(Icons.code, color: colours.outline),
              onTap: () => _onTap(2),
              child: Column(children: [Flexible(child: Dependencies())]),
            ),
          ],
        ),
      ),
    );
  }

  void _onTap(int index) => setState(() => _expandIndex = _expandIndex == index ? -1 : index);
}
