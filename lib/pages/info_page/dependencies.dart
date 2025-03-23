import 'package:flutter/material.dart';
import 'package:tripeaks_neue/oss_licenses.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/external_link.dart';
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
              const DependenciesListDivider(),
            ],
            for (final (index, dep) in devDependencies.indexed) ...[
              DependencyEntry(package: dep),
              if (index < devDependencies.length - 1) const DependenciesListDivider(),
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
    final textTheme = Theme.of(context).textTheme;
    final link = package.homepage ?? package.repository;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(package.name, style: textTheme.titleMedium),
        if (link != null) ExternalLink(uri: Uri.dataFromString(link)),
      ],
    );
  }
}

class DependenciesListDivider extends StatelessWidget {
  const DependenciesListDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: Theme.of(context).colorScheme.outlineVariant);
  }
}
