import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/item_container.dart';

final class const GroupTitle(final String title, {super.key, final bool isFirst = false})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
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
            Text(title, style: theme.textTheme.titleMedium?.copyWith(color: theme.colorScheme.primary)),
          ],
        ),
      ),
    );
  }
}
