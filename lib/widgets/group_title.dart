import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/constrained.dart';

final class const GroupTitle(final String title, {super.key, final bool isFirst = false})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ConstrainedItem(
      padding: EdgeInsets.only(
        left: c.utilPageMargin,
        right: c.utilPageMargin,
        top: isFirst ? c.utilPageMargin : c.itemSpacing * 2,
        bottom: c.DialogMetrics.sectionSpacing,
      ),
      child: Row(
        children: [
          Text(title, style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.primary)),
        ],
      ),
    );
  }
}
