import 'package:flutter/material.dart';
import 'package:tripeaks_neue/pages/shared/item_container.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      primary: false,
      centerTitle: true,
      title: ListItemContainer(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [Expanded(child: Text(title))]),
        ),
      ),
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
    );
  }
}
