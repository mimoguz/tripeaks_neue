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
    final theme = Theme.of(context);
    final paragraphStyle = theme.textTheme.bodyMedium!.copyWith(height: 1.8);
    final italic = paragraphStyle.copyWith(
      fontStyle: FontStyle.italic,
      color: theme.colorScheme.onSurfaceVariant,
    );
    final s = AppLocalizations.of(context)!;
    return ScrollIndicator(
      child: DefaultTextStyle(
        style: paragraphStyle,
        child: ListView(
          padding: EdgeInsets.fromLTRB(
            c.cardPaddingHorizontal,
            0.0,
            c.cardPaddingHorizontal,
            c.cardPaddingVertical,
          ),
          children: [
            ExternalLink(
              uri: Uri.https("en.wikipedia.org", "wiki/Tri_Peaks_(game)"),
              alt: s.wikiLinkAlt,
              label: s.wikiLinkText,
            ),
            const SizedBox(height: 12.0),
            FastRichText(text: s.howToP01, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            FastRichText(text: s.howToRichP02, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            FastRichText(text: s.howToRichP03, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            FastRichText(text: s.howToP04, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            FastRichText(text: s.howToP05, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            FastRichText(text: s.howToP06, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            FastRichText(text: s.howToP07, textStyle: paragraphStyle, italicTextStyle: italic),
            Row(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FastRichText(text: "●", textStyle: paragraphStyle, italicTextStyle: italic),
                Flexible(
                  child: FastRichText(text: s.howToP08, textStyle: paragraphStyle, italicTextStyle: italic),
                ),
              ],
            ),
            Row(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FastRichText(text: "●", textStyle: paragraphStyle, italicTextStyle: italic),
                Flexible(
                  child: FastRichText(text: s.howToP09, textStyle: paragraphStyle, italicTextStyle: italic),
                ),
              ],
            ),
            Row(
              spacing: 8.0,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FastRichText(text: "●", textStyle: paragraphStyle, italicTextStyle: italic),
                Flexible(
                  child: FastRichText(text: s.howToP10, textStyle: paragraphStyle, italicTextStyle: italic),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
