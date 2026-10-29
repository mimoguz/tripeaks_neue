import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

final class const H(final Widget child, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) =>
      SliverPersistentHeader(delegate: HDelegate(child), pinned: true, floating: false);
}

final class const HDelegate(final Widget child) extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final elevated = overlapsContent || shrinkOffset > 0;
    final theme = context.theme;
    return SizedBox(
      height: _maxHeight,
      child: Material(
        color: theme.colorScheme.pageBackground,
        shadowColor: theme.shadowColor,
        elevation: elevated ? 2 : 0,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: c.maxParagraphWidth),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: c.cardPaddingHorizontal),
              child: Row(
                children: [
                  DefaultTextStyle(
                    style: theme.textTheme.titleLarge!.copyWith(color: theme.colorScheme.primary),
                    child: child,
                  ),
                ],
              ),
            ),
          ),
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

  static const _maxHeight = 58.0;
  static const _minHeight = 58.0;
}

final class const P(final Widget child, {super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        clipBehavior: .none,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: c.maxParagraphWidth),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                c.cardPaddingHorizontal,
                0,
                c.cardPaddingHorizontal,
                c.itemSpacing,
              ),
              child: Row(children: [Flexible(child: child)]),
            ),
          ),
        ),
      ),
    );
  }
}

final class const Li({super.key, final Widget? title, required final List<Widget> items})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        clipBehavior: .none,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: c.maxParagraphWidth),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                c.cardPaddingHorizontal,
                0,
                c.cardPaddingHorizontal,
                c.itemSpacing,
              ),
              child: Column(
                children: [
                  if (title != null) Row(children: [Flexible(child: title!)]),
                  for (final it in items)
                    Row(
                      spacing: c.cardPaddingHorizontal,
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
            ),
          ),
        ),
      ),
    );
  }
}

class const Line({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        clipBehavior: .none,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: c.maxParagraphWidth),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: c.cardPaddingHorizontal,
                vertical: c.DialogMetrics.sectionSpacing,
              ),
              child: Container(color: context.colours.dialogDivider, height: 1),
            ),
          ),
        ),
      ),
    );
  }
}
