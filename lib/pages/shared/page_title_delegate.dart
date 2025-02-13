import 'package:tripeaks_neue/pages/shared/item_container.dart';
import 'package:flutter/material.dart';

final class PageTitleDelegate extends SliverPersistentHeaderDelegate {
  PageTitleDelegate({required this.title, this.actions});

  Widget title;
  List<Widget>? actions;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final colours = Theme.of(context).colorScheme;
    final t = (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);
    final navigator = Navigator.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            color: Color.lerp(colours.surface, colours.surfaceContainerHighest, t),
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: ListItemContainer(
                child: Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 12.0),
                  child: Row(
                    spacing: 4.0,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(child: title),
                      Row(
                        spacing: 6.0,
                        children: [
                          if (navigator.canPop()) BackButton(),
                          if (actions != null)
                            for (final action in actions!) action,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => 80.0;

  @override
  double get minExtent => 56.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}
