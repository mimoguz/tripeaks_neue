import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/generated/oss_licenses.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/src/version.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/dividers.dart';
import 'package:tripeaks_neue/widgets/show_dialog.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/constrained.dart';
import 'package:tripeaks_neue/widgets/external_link.dart';
import 'package:tripeaks_neue/widgets/my_dialog.dart';
import 'package:tripeaks_neue/widgets/sliver_text.dart';

class AboutTab extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final s = context.strings;
    final normal = theme.extension<MyTextThemeExt>()!.paragraphText;
    return Container(
      color: theme.colorScheme.surface,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverMainAxisGroup(
            slivers: [
              H(Text(s.aboutTheGameTitle)),
              P(Text(s.aboutText(_version), style: normal), spaceAfter: false),
              P(
                ExternalLink(
                  uri: Uri.https("github.com", "mimoguz/tripeaks_neue"),
                  alt: s.repoLink,
                  label: s.repoLink,
                ),
                spaceAfter: true,
              ),
            ],
          ),
          SliverMainAxisGroup(
            slivers: [
              H(Text(s.licenseTitle)),
              P(Text(s.licenseText, style: normal), spaceAfter: false),
              P(ExternalLink(uri: Uri.https("www.gnu.org", "/licenses/agpl-3.0.txt")), spaceAfter: true),
              P(Text(s.licenseExceptionText, style: normal), spaceAfter: false),
              P(ExternalLink(uri: Uri.https("www.apache.org", "/licenses/LICENSE-2.0.txt"))),
            ],
          ),
          SliverMainAxisGroup(
            slivers: [
              H(Text(s.privacyPolicyTitle)),
              P(Text(s.privacyPolicyText, style: normal)),
            ],
          ),
          SliverMainAxisGroup(
            slivers: [
              H(Text("Dependencies")),
              SliverList.separated(
                itemCount: _extendedDependencies.length,
                separatorBuilder: (_, _) => ConstrainedDivider(verticalPadding: 4),
                itemBuilder: (_, index) {
                  final package = _extendedDependencies[index];
                  return Dependency(
                    package: package,
                    isDirectDependency: _directDependencies.contains(package.name),
                    strings: s,
                  );
                },
              ),
            ],
          ),
          SliverPadding(padding: const EdgeInsets.only(bottom: 8.0)),
        ],
      ),
    );
  }

  static final _version = packageVersion.split("+")[0];
  static final _extendedDependencies = allDependencies
      //.where((it) => !(it.isSdk || it.name == "flutter"))
      .toList();
  static final _directDependencies = (dependencies + devDependencies).map((it) => it.name).toSet();
}

final class const Dependency({
  super.key,
  required final Package package,
  required final bool isDirectDependency,
  required final AppLocalizations strings,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labelStyle = context.styles.labelSmall;
    return ConstrainedItem(
      child: Row(
        children: [
          Text(
            isDirectDependency ? strings.directDependency : strings.indirectDependency,
            textAlign: .end,
            style: labelStyle,
          ),
          Expanded(child: Text(package.name, maxLines: 1, softWrap: false, overflow: .fade)),
          if (package.homepage != null)
            TextButton(
              onPressed: () => _copy(context, package.homepage!),
              child: Text(strings.copyLinkAction),
            ),
          if (package.license != null)
            TextButton(
              onPressed: () => showCommonDialog(context, (_) => LicenseDialog(package: package)),
              child: Text(strings.showLicenseAction),
            ),
        ],
      ),
    );
  }

  Future<void> _copy(BuildContext context, String uri) async {
    await Clipboard.setData(ClipboardData(text: uri));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Link copied to clipboard")));
    }
  }
}

final class const LicenseDialog({super.key, required final Package package}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyDialog(
      title: Text(package.name),
      content: Padding(
        padding: c.DialogMetrics.contentPadding,
        child: Text(package.license ?? "License not found"),
      ),
    );
  }
}
