import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/generated/oss_licenses.dart';
import 'package:tripeaks_neue/pages/info_page/license_dialog.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/external_link.dart';
import 'package:tripeaks_neue/widgets/group_tile.dart';
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class const Dependencies({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScrollIndicator(
      child: DefaultTextStyle(
        style: context.styles.bodyMedium!.copyWith(height: 1.8),
        child: ListView.separated(
          padding: EdgeInsets.fromLTRB(
            c.cardPaddingHorizontal,
            0,
            c.cardPaddingHorizontal,
            c.cardPaddingVertical,
          ),
          itemCount: _extendedDependencies.length,
          itemBuilder: (context, index) => DependencyEntry(
            package: _extendedDependencies[index],
            isDirectDependency: _directDependencies.contains(_extendedDependencies[index].name),
          ),
          separatorBuilder: (context, index) => const GroupTileDivider(padding: EdgeInsets.zero),
        ),
      ),
    );
  }

  static final _extendedDependencies = allDependencies
      .where((it) => !it.isSdk || it.name == "flutter")
      .toList();

  static final _directDependencies = (dependencies + devDependencies).map((it) => it.name).toSet();
}

final class const DependencyEntry({
  super.key,
  required final Package package,
  required final bool isDirectDependency,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final link = package.homepage ?? package.repository;
    final s = context.strings;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Flexible(child: Text(package.name, softWrap: false, overflow: .fade)),
            Row(
              spacing: 8,
              children: [
                DependencyStatusChip(isDirectDependency),
                if (package.license != null)
                  FilledButton.tonal(
                    onPressed: () => _showLicense(context),
                    child: Text(s.showLicenseAction),
                  ),
              ],
            ),
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

class const DependencyStatusChip(final bool isDirectDependency, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final text = isDirectDependency ? s.directDependencyLabel : s.indirectDependencyLabel;
    return Text(text, style: TextStyle(fontSize: 12, color: context.colours.secondary));
  }
}
