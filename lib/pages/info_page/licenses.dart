import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/external_link.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class Licenses extends StatelessWidget {
  const Licenses({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ScrollIndicator(
      child: DefaultTextStyle(
        style: textTheme.bodyMedium!.copyWith(height: 1.8),
        // TODO: Move to arb
        child: ListView(
          padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          children: [
            LicenseEntry(
              link: Uri.https("github.com", "mimoguz/tripeaks_neue"),
              title: "Tripeaks NEUE",
              description: "Oguz Tas, 2025.",
              license: "GNU Affero General Public License (AGPL) Version 3",
              exceptions: [
                "fonts/actions.ttf: This file includes symbols derived from "
                    "Material Icons, and therefore available under Apache License "
                    "Version 2.0 (same as Material Icons).",
              ],
            ),
            const Divider(height: 32.0),
            LicenseEntry(
              link: Uri.https("github.com", "Outfitio/Outfit-Fonts"),
              title: "Outfit Fonts",
              description: "Created by Smartsheet Inc, Rodrigo Fuenzalida.",
              license: "SIL Open Font License (OFL) Version 1.1",
            ),
          ],
        ),
      ),
    );
  }
}

final class LicenseEntry extends StatelessWidget {
  const LicenseEntry({
    super.key,
    required this.link,
    required this.title,
    required this.license,
    this.description,
    this.exceptions = const <String>[],
  });

  final Uri link;
  final String title;
  final String? description;
  final String license;
  final List<String> exceptions;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6.0,
      children: [
        Text(title, style: textTheme.titleMedium),
        if (description != null) Text(description!),
        Text("Avaliable under $license."),
        if (exceptions.isNotEmpty)
          Text("Exceptions", style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        if (exceptions.isNotEmpty)
          for (final e in exceptions) Text(e, style: textTheme.bodySmall),
        ExternalLink(uri: link),
      ],
    );
  }
}
