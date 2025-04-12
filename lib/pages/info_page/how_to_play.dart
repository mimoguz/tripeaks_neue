import 'package:fast_rich_text/fast_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/external_link.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class HowToPlay extends StatelessWidget {
  const HowToPlay({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final s = AppLocalizations.of(context)!;
    final paragraphStyle = textTheme.bodyMedium!.copyWith(height: 1.8);
    final italic = TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).colorScheme.secondary);
    return ScrollIndicator(
      child: DefaultTextStyle(
        style: paragraphStyle,
        child: ListView(
          padding: EdgeInsets.fromLTRB(c.cardPadding, 0.0, c.cardPadding, c.cardPadding),
          children: [
            ExternalLink(
              uri: Uri.https("en.wikipedia.org", "wiki/Tri_Peaks_(game)"),
              alt: s.wikiLinkAlt,
              label: s.wikiLinkText,
            ),
            const SizedBox(height: 12.0),
            Text(s.howToP01),
            const SizedBox(height: 12.0),
            FastRichText(text: s.howToRichP02, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            FastRichText(text: s.howToRichP03, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            Text(s.howToP04),
            const SizedBox(height: 12.0),
            Text(s.howToP05),
            const SizedBox(height: 12.0),
            Text(s.howToP06),
            const SizedBox(height: 12.0),
            Text(s.howToP07),
            Row(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("●"), Flexible(child: Text(s.howToP08))],
            ),
            Row(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("●"), Flexible(child: Text(s.howToP09))],
            ),
            Row(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text("●"), Flexible(child: Text(s.howToP10))],
            ),
          ],
        ),
      ),
    );
  }
}
