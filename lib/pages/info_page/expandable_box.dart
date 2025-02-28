import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/item_container.dart';

class ExpandableBox extends StatelessWidget {
  const ExpandableBox({
    super.key,
    required this.expanded,
    required this.title,
    this.onTap,
    this.icon,
    this.child,
  });

  final bool expanded;
  final Widget? child;
  final Widget title;
  final Widget? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: expanded ? 1 : 0,
      child: AnimatedSize(
        duration: Durations.short3,
        child: ListItemContainer(
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: onTap,
                  borderRadius: c.commonBorderRadius,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      spacing: 12.0,
                      children: [
                        if (icon != null) icon!,
                        Expanded(
                          child: DefaultTextStyle(
                            style: Theme.of(context).textTheme.titleMedium!,
                            child: title,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (child != null && expanded) Flexible(child: child!),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
