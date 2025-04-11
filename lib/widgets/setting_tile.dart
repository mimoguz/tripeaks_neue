import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/item_container.dart';

final class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.location,
    this.trailing,
    this.showArrow = false,
    this.onTap,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final bool showArrow;
  final Location location;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final br = _borderRadius;
    return ListItemContainer(
      child: Padding(
        padding: EdgeInsets.only(
          left: c.utilPageMargin,
          right: c.utilPageMargin,
          top: location == Location.first || location == Location.only ? 0 : 3,
        ),
        child: Material(
          color: theme.colorScheme.surfaceContainerHigh,
          elevation: 1.0,
          shadowColor: theme.shadowColor,
          borderRadius: br,
          child: InkWell(
            borderRadius: br,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(c.cardPadding),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: theme.textTheme.titleSmall),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: theme.textTheme.labelMedium!.copyWith(color: theme.colorScheme.outline),
                          ),
                      ],
                    ),
                  ),
                  if (trailing != null) trailing!,
                  if (showArrow) Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius get _borderRadius => switch (location) {
    Location.first => _firstBorder,
    Location.centre => _centreBorder,
    Location.last => _lastBorder,
    Location.only => _onlyBorder,
  };

  static const _firstBorder = BorderRadius.only(
    topLeft: Radius.circular(c.commonRadius),
    topRight: Radius.circular(c.commonRadius),
    bottomLeft: Radius.circular(2.0),
    bottomRight: Radius.circular(2.0),
  );

  static const _centreBorder = BorderRadius.all(Radius.circular(2.0));

  static const _lastBorder = BorderRadius.only(
    topLeft: Radius.circular(2.0),
    topRight: Radius.circular(2.0),
    bottomLeft: Radius.circular(c.commonRadius),
    bottomRight: Radius.circular(c.commonRadius),
  );

  static const _onlyBorder = c.commonBorderRadius;
}

enum Location { first, centre, last, only }
