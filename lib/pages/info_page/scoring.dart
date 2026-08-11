import 'package:fast_rich_text/fast_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class Scoring extends StatelessWidget {
  const Scoring({super.key});

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
          padding: const EdgeInsets.fromLTRB(
            c.cardPaddingHorizontal,
            0.0,
            c.cardPaddingHorizontal,
            c.cardPaddingVertical,
          ),
          children: [
            FastRichText(text: s.scoringRichP01, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            FastRichText(text: s.scoringP02, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            FastRichText(text: s.scoringRichP03, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            FastRichText(text: s.scoringRichP04, textStyle: paragraphStyle, italicTextStyle: italic),
            const SizedBox(height: 12.0),
            FastRichText(text: s.scoringP05, textStyle: paragraphStyle, italicTextStyle: italic),
          ],
        ),
      ),
    );
  }
}
