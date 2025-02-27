import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/item_container.dart';

class ExpandableBox extends StatelessWidget {
  const ExpandableBox({super.key, required this.expanded, required this.title, this.onTap, this.child});

  final bool expanded;
  final Widget? child;
  final Widget title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return expanded
        ? Expanded(
          child: ListItemContainer(
            child: Card(
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: onTap,
                          radius: 20.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                            child: title,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (child != null) child!,
                ],
              ),
            ),
          ),
        )
        : ListItemContainer(
          child: Card(
            color: Theme.of(context).colorScheme.surface,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: onTap,
                        radius: 20.0,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 16.0),
                          child: title,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
