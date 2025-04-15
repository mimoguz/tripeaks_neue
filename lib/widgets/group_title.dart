import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/item_container.dart';

final class GroupTitle extends StatelessWidget {
  const GroupTitle(this.title, {super.key, this.isFirst = false});

  final String title;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListItemContainer(
      child: Padding(
        padding: EdgeInsets.only(
          left: c.cardPaddingHorizontal,
          right: c.utilPageMargin,
          top: isFirst ? 4.0 : 24.0,
          bottom: 8.0,
        ),
        child: Row(
          children: [
            Text(title, style: theme.textTheme.titleMedium!.copyWith(color: theme.colorScheme.primary)),
          ],
        ),
      ),
    );
  }
}
