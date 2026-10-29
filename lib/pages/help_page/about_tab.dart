import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/generated/oss_licenses.dart';
import 'package:tripeaks_neue/src/version.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/external_link.dart';
import 'package:tripeaks_neue/widgets/my_dialog.dart';
import 'package:tripeaks_neue/widgets/sliver_text.dart';

class AboutTab extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final s = context.strings;
    final normal = theme.textTheme.bodyMedium!.copyWith(height: 2);
    return Container(
      color: theme.colorScheme.pageBackground,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverMainAxisGroup(
            slivers: [
              H(Text(s.aboutTabTitle)),
              P(
                Text(
                  "Tripeaks NEUE version $version.\n"
                  "Developed by Oguz Tas, 2026.\n"
                  "Solvable game algorithm was developed by Lykae.",
                  style: normal,
                ),
                spaceAfter: false,
              ),
              P(
                ExternalLink(
                  uri: Uri.https("github.com", "mimoguz/tripeaks_neue"),
                  alt: "Source repository",
                  label: "Source repository",
                ),
              ),
            ],
          ),
          SliverMainAxisGroup(
            slivers: [
              H(Text("License")),
              P(
                Text(
                  "Available under GNU Affero General Public License (AGPL) Version\u00A03.",
                  style: normal,
                ),
                spaceAfter: false,
              ),
              P(ExternalLink(uri: Uri.https("www.gnu.org", "/licenses/agpl-3.0.txt"))),
              P(
                Text(
                  "Except "
                  "fonts/actions.ttf: This file includes symbols derived from "
                  "Material Icons, and therefore available under Apache License "
                  "Version\u00A02.0 (same as Material Icons).",
                  style: normal,
                ),
                spaceAfter: false,
              ),
              P(ExternalLink(uri: Uri.https("www.apache.org", "/licenses/LICENSE-2.0.txt"))),
            ],
          ),
          SliverMainAxisGroup(
            slivers: [
              H(Text("Privacy Policiy")),
              P(
                Text(
                  "This game is open source and free software. First-party distrubutions "
                  "of it are compiled unchanged from the source codes available at the "
                  "repository linked above. It does not collect any user data.",
                  style: normal,
                ),
              ),
            ],
          ),
          SliverMainAxisGroup(
            slivers: [
              H(Text("Dependencies")),
              SliverList.separated(
                itemCount: _extendedDependencies.length,
                separatorBuilder: (_, _) => Line(),
                itemBuilder: (_, index) {
                  final package = _extendedDependencies[index];
                  return Dependency(
                    package: package,
                    isDirectDependency: _directDependencies.contains(package.name),
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

  static final version = packageVersion.split("+")[0];
  static final _extendedDependencies = allDependencies
      .where((it) => !it.isSdk || it.name == "flutter")
      .toList();
  static final _directDependencies = (dependencies + devDependencies).map((it) => it.name).toSet();
}

final class const Dependency({
  super.key,
  required final Package package,
  required final bool isDirectDependency,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labelStyle = context.styles.labelSmall;
    return Material(
      elevation: 0,
      color: Colors.transparent,
      clipBehavior: .none,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: c.maxParagraphWidth),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: c.cardPaddingHorizontal),
            child: Row(
              children: [
                Text(isDirectDependency ? "Direct:" : "Indirect:", textAlign: .end, style: labelStyle),
                Expanded(child: Text(package.name, maxLines: 1, softWrap: false, overflow: .fade)),
                if (package.homepage != null)
                  TextButton(onPressed: () => _copy(context, package.homepage!), child: Text("Link")),
                if (package.license != null)
                  TextButton(
                    onPressed: () => showCommonDialog(context, (_) => LicenseDialog(package: package)),
                    child: Text("License"),
                  ),
              ],
            ),
          ),
        ),
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
