import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/constrained.dart';

final class const H(
  final Widget child, {
  super.key,
  final double maxWidth = c.maxListWidth,
  final double horizontalPadding = c.utilPageMargin,
  final bool pinned = true,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SliverPersistentHeader(
    delegate: HDelegate(child, maxWidth: maxWidth, horizontalPadding: horizontalPadding),
    pinned: pinned,
    floating: false,
  );
}

final class const HDelegate(
  final Widget child, {
  required final double maxWidth,
  required final double horizontalPadding,
}) extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final elevated = overlapsContent || shrinkOffset > 0;
    final theme = context.theme;
    final colourExt = theme.extension<MyColourThemeExt>()!;
    final textExt = theme.extension<MyTextThemeExt>()!;
    return Material(
      color: theme.colorScheme.surface,
      shadowColor: colourExt.headerShadow,
      elevation: elevated ? 2 : 0,
      child: ConstrainedItem(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        maxHeight: _maxHeight,
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Row(
              children: [DefaultTextStyle(style: textExt.sectionTitle, child: child)],
            ),
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => _maxHeight;

  @override
  double get minExtent => _minHeight;

  @override
  bool shouldRebuild(HDelegate oldDelegate) => true;

  static const _maxHeight = 36.0;
  static const _minHeight = 24.0;
}

final class const P(final Widget child, {super.key, final bool spaceAfter = true}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedSliver(
      padding: EdgeInsets.fromLTRB(c.utilPageMargin, 0, c.utilPageMargin, spaceAfter ? c.itemSpacing : 0),
      child: Row(children: [Flexible(child: child)]),
    );
  }
}

final class const Li({super.key, final Widget? title, required final List<Widget> items})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedSliver(
      padding: const EdgeInsets.fromLTRB(c.utilPageMargin, 0, c.utilPageMargin, c.itemSpacing),
      child: Column(
        children: [
          if (title != null) Row(children: [Flexible(child: title!)]),
          for (final it in items)
            Row(
              spacing: c.utilPageMargin,
              textBaseline: .alphabetic,
              crossAxisAlignment: .baseline,
              children: [
                SizedBox(),
                Icon(Icons.circle, size: 8),
                Flexible(child: it),
              ],
            ),
        ],
      ),
    );
  }
}

class const SliverDivider({
  super.key,
  final double verticalPadding = c.DialogMetrics.sectionSpacing,
  final double horizontalPadding = c.utilPageMargin,
  final double maxWidth = c.maxListWidth,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedSliver(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      child: Container(color: context.theme.extension<MyColourThemeExt>()!.cardDivider, height: 1),
    );
  }
}
