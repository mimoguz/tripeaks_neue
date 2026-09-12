import 'package:flutter/material.dart';
import 'package:tripeaks_neue/src/version.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/external_link.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ScrollIndicator(
      child: DefaultTextStyle(
        style: textTheme.bodyMedium!.copyWith(height: 1.8),
        // TODO: Move to arb
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
            c.cardPaddingHorizontal,
            0,
            c.cardPaddingHorizontal,
            c.cardPaddingVertical,
          ),
          child: LicenseEntry(
            link: Uri.https("github.com", "mimoguz/tripeaks_neue"),
            title: "Tripeaks NEUE v$version",
            description: "Oguz Tas, 2026.\nSolvable game algorithm was developed by Lykae.",
            license: "GNU Affero General Public License (AGPL) Version 3",
            licenseLink: Uri.https("www.gnu.org", "/licenses/agpl-3.0.txt"),
            exceptions: [
              "fonts/actions.ttf: This file includes symbols derived from "
                  "Material Icons, and therefore available under Apache License "
                  "Version 2.0 (same as Material Icons).",
            ],
          ),
        ),
      ),
    );
  }

  static final version = packageVersion.split("+")[0];
}

final class LicenseEntry extends StatelessWidget {
  const LicenseEntry({
    super.key,
    required this.title,
    required this.license,
    this.licenseLink,
    this.link,
    this.description,
    this.exceptions = const <String>[],
  });

  final Uri? link;
  final String title;
  final String? description;
  final String license;
  final List<String> exceptions;
  final Uri? licenseLink;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return DefaultTextStyle(
      style: TextStyle(height: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.0,
        children: [
          Text(title, style: textTheme.titleMedium),
          if (description != null) Text(description!),
          if (link != null) ExternalLink(uri: link!),
          Divider(height: c.itemSpacing * 2.0),
          Text("License", style: textTheme.titleMedium),
          Text("Available under $license."),
          if (licenseLink != null) ExternalLink(uri: licenseLink!),
          if (exceptions.isNotEmpty)
            Padding(
              padding: EdgeInsetsGeometry.only(top: 8),
              child: Text("Exceptions", style: textTheme.titleSmall),
            ),
          if (exceptions.isNotEmpty)
            for (final e in exceptions) Text(e, style: textTheme.bodySmall),
        ],
      ),
    );
  }
}
