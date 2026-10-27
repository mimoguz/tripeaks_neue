import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/item_container.dart';

class const ExpandableBox({
  super.key,
  required final bool expanded,
  required final Widget title,
  final VoidCallback? onTap,
  final Widget? icon,
  final Widget? child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Expanded(
      flex: expanded ? 1 : 0,
      child: AnimatedSize(
        duration: Durations.short3,
        child: ListItemContainer(
          child: Container(
            decoration: BoxDecoration(
              color: theme.brightness == .dark
                  ? theme.colorScheme.surfaceContainerHigh
                  : theme.colorScheme.surfaceContainerLowest,
              borderRadius: c.commonBorderRadius,
              boxShadow: <BoxShadow>[BoxShadow(color: Colors.black12, blurRadius: 2.5, offset: Offset(0, 1))],
            ),
            clipBehavior: .antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  type: .transparency,
                  child: InkWell(
                    onTap: onTap,
                    borderRadius: expanded ? _expandedRadius : c.commonBorderRadius,
                    child: Padding(
                      padding: c.cardPadding,
                      child: Row(
                        spacing: c.cardPaddingHorizontal,
                        children: [
                          ?icon,
                          Expanded(
                            child: DefaultTextStyle(style: theme.textTheme.titleMedium!, child: title),
                          ),
                          Icon(
                            expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            size: 24.0,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
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

  static final _expandedRadius = c.commonBorderRadius.copyWith(
    bottomLeft: Radius.zero,
    bottomRight: Radius.zero,
  );
}
