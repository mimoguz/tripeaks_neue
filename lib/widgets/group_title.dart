import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/item_container.dart';

final class GroupTitle extends StatelessWidget {
  const GroupTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListItemContainer(
      child: Padding(
        padding: const EdgeInsets.only(
          left: c.utilPageMargin + c.cardPadding,
          right: c.utilPageMargin,
          top: 32,
          bottom: 8,
        ),
        child: Row(
          children: [
            Text(
              title,
              style: theme.textTheme.titleSmall!.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
