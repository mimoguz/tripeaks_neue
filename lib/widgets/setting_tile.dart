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
    final borderRadius = _borderRadius;
    final padding = showArrow ? _correctedPadding : c.cardPadding;
    final margin = location == Location.first || location == Location.only ? EdgeInsets.zero : _spacing;
    return Padding(
      padding: margin,
      child: ListItemContainer(
        child: Material(
          color: theme.colorScheme.surfaceContainerHigh,
          elevation: 1.0,
          shadowColor: theme.shadowColor,
          borderRadius: borderRadius,
          child: InkWell(
            borderRadius: borderRadius,
            onTap: onTap,
            child: Padding(
              padding: padding,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: theme.textTheme.titleMedium),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: theme.textTheme.labelMedium!.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
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

  static const _correctedPadding = EdgeInsets.only(
    left: c.cardPaddingHorizontal,
    right: c.cardPaddingHorizontal - 4.0,
    top: c.cardPaddingVertical,
    bottom: c.cardPaddingVertical,
  );

  static const _spacing = EdgeInsets.only(top: 3.0);

  static const _firstBorder = BorderRadius.only(
    topLeft: Radius.circular(c.commonRadius),
    topRight: Radius.circular(c.commonRadius),
    bottomLeft: Radius.circular(_smallRadius),
    bottomRight: Radius.circular(_smallRadius),
  );

  static const _centreBorder = BorderRadius.all(Radius.circular(_smallRadius));

  static const _lastBorder = BorderRadius.only(
    topLeft: Radius.circular(_smallRadius),
    topRight: Radius.circular(_smallRadius),
    bottomLeft: Radius.circular(c.commonRadius),
    bottomRight: Radius.circular(c.commonRadius),
  );

  static const _onlyBorder = c.commonBorderRadius;

  static const _smallRadius = 3.0;
}

enum Location { first, centre, last, only }
