import 'package:fast_rich_text/fast_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class Scoring extends StatelessWidget {
  const Scoring({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final paragraphStyle = textTheme.bodyMedium!.copyWith(height: 1.8);
    final italic = TextStyle(fontStyle: FontStyle.italic, color: Theme.of(context).colorScheme.secondary);
    final s = AppLocalizations.of(context)!;
    return ScrollIndicator(
      child: DefaultTextStyle(
        style: paragraphStyle,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(c.cardPadding, 0.0, c.cardPadding, c.cardPadding),
          children: [
            FastRichText(text: s.scoringRichP01, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            Text(s.scoringP02),
            const SizedBox(height: 12.0),
            FastRichText(text: s.scoringRichP03, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            FastRichText(text: s.scoringRichP04, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            Text(s.scoringP05),
          ],
        ),
      ),
    );
  }
}
