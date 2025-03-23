import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/item_container.dart';

final class GroupTile extends StatelessWidget {
  const GroupTile({super.key, required this.children, this.title});

  final List<Widget> children;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ListItemContainer(
      child: Card(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        child: Padding(
          padding: const EdgeInsets.all(c.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (title != null) const SizedBox(height: 8.0),
              ...children,
            ],
          ),
        ),
      ),
    );
  }
}

class GroupTileDivider extends StatelessWidget {
  const GroupTileDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: c.divPadding),
      child: Divider(color: Theme.of(context).colorScheme.outlineVariant),
    );
  }
}
