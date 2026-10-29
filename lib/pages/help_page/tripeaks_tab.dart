import 'package:fast_rich_text/fast_rich_text.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/external_link.dart';
import 'package:tripeaks_neue/widgets/sliver_text.dart';

class TriPeaksTab extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final s = context.strings;
    final normal = theme.textTheme.bodyMedium!.copyWith(height: 2);
    final italic = normal.copyWith(fontStyle: .italic, color: theme.colorScheme.primary);
    return Container(
      color: theme.colorScheme.pageBackground,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverMainAxisGroup(
            slivers: [
              H(Text("How to Play Tri Peaks")),
              P(
                ExternalLink(
                  uri: Uri.https("en.wikipedia.org", "wiki/Tri_Peaks_(game)"),
                  alt: s.wikiLinkAlt,
                  label: s.wikiLinkText,
                ),
              ),
              P(FastRichText(text: s.howToP01, textStyle: normal, italicTextStyle: italic)),
              P(FastRichText(text: s.howToRichP02, textStyle: normal, italicTextStyle: italic)),
              P(FastRichText(text: s.howToRichP03, textStyle: normal, italicTextStyle: italic)),
              P(FastRichText(text: s.howToP04, textStyle: normal, italicTextStyle: italic)),
              P(FastRichText(text: s.howToP05, textStyle: normal, italicTextStyle: italic)),
              P(FastRichText(text: s.howToP06, textStyle: normal, italicTextStyle: italic)),
              Li(
                title: FastRichText(text: s.howToP07, textStyle: normal, italicTextStyle: italic),
                items: [
                  FastRichText(text: s.howToP08, textStyle: normal, italicTextStyle: italic),
                  FastRichText(text: s.howToP09, textStyle: normal, italicTextStyle: italic),
                  FastRichText(text: s.howToP10, textStyle: normal, italicTextStyle: italic),
                ],
              ),
            ],
          ),
          SliverMainAxisGroup(
            slivers: [
              H(Text("Scoring")),
              P(FastRichText(text: s.scoringRichP01, textStyle: normal, italicTextStyle: italic)),
              P(FastRichText(text: s.scoringP02, textStyle: normal, italicTextStyle: italic)),
              P(FastRichText(text: s.scoringRichP03, textStyle: normal, italicTextStyle: italic)),
              P(FastRichText(text: s.scoringRichP04, textStyle: normal, italicTextStyle: italic)),
              P(FastRichText(text: s.scoringP05, textStyle: normal, italicTextStyle: italic)),
            ],
          ),
        ],
      ),
    );
  }
}
