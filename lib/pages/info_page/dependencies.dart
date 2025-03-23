import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/oss_licenses.dart';
import 'package:tripeaks_neue/pages/info_page/license_dialog.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/external_link.dart';
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class Dependencies extends StatelessWidget {
  const Dependencies({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ScrollIndicator(
      child: DefaultTextStyle(
        style: textTheme.bodyMedium!.copyWith(height: 1.8),
        // TODO: Move to arb
        child: ListView(
          padding: EdgeInsets.fromLTRB(c.cardPadding, 0, c.cardPadding, c.cardPadding),
          children: [
            for (final dep in dependencies) ...[
              DependencyEntry(package: dep),
              const GroupTileDivider(padding: EdgeInsets.zero),
            ],
            for (final (index, dep) in devDependencies.indexed) ...[
              DependencyEntry(package: dep),
              if (index < devDependencies.length - 1) const GroupTileDivider(padding: EdgeInsets.zero),
            ],
          ],
        ),
      ),
    );
  }
}

final class DependencyEntry extends StatelessWidget {
  const DependencyEntry({super.key, required this.package});

  final Package package;

  @override
  Widget build(BuildContext context) {
    final link = package.homepage ?? package.repository;
    final s = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          textBaseline: TextBaseline.alphabetic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            Text(package.name),
            if (package.license != null)
              FilledButton.tonal(onPressed: () => _showLicense(context), child: Text(s.showLicenseAction)),
          ],
        ),
        if (link != null) ExternalLink(uri: Uri.dataFromString(link)),
      ],
    );
  }

  void _showLicense(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => LicenseDialog(package: package),
    );
  }
}
