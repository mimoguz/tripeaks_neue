import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/external_link.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollIndicator(
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(height: 1.8),
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          children: [
            // TODO: Move to arb
            Text(
              "This game is open source and free software. First-party distrubutions "
              "of it are compiled unchanged from the source codes available at the "
              "repository linked below. It does not collect any user data.",
            ),
            const SizedBox(height: 12.0),
            ExternalLink(
              uri: Uri.https("github.com", "mimoguz/tripeaks_neue"),
              alt: "Repository link",
              label: "TriPeaks NEUE on GitHub",
            ),
          ],
        ),
      ),
    );
  }
}
