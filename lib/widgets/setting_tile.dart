import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/item_container.dart';

final class const SettingTile({
  super.key,
  final String? titleText,
  final Widget? title,
  final String? subtitle,
  required final Location location,
  final Widget? trailing,
  final bool showArrow = false,
  final VoidCallback? onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final padding = showArrow ? _correctedPadding : c.cardPadding;
    return ListItemContainer(
      minHeight: 68.0,
      child: Material(
        type: .transparency,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      title ??
                          Text(
                            titleText ??
                                (throw ArgumentError.value(
                                  "titleText",
                                  "Either 'title' or 'titleText' must not be null",
                                )),
                            style: theme.textTheme.titleMedium,
                          ),
                      if (subtitle != null)
                        Text(
                          subtitle!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
                ?trailing,
                if (showArrow) Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const _correctedPadding = EdgeInsets.only(
    left: c.cardPaddingHorizontal,
    right: c.cardPaddingHorizontal - 4.0,
    top: c.cardPaddingVertical,
    bottom: c.cardPaddingVertical,
  );
}

enum Location { first, centre, last, only }
