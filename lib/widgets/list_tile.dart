import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

final class MyListTile extends StatelessWidget {
  const MyListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.leftSpacing = 8.0,
    this.rightSpacing = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 6.0),
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final double leftSpacing;
  final double rightSpacing;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) leading!,
            if (leading != null && leftSpacing > 0.0) SizedBox(width: leftSpacing),
            Column(
              spacing: 4.0,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(style: theme.textTheme.bodyMedium!, child: title),
                if (subtitle != null)
                  DefaultTextStyle(
                    style: theme.textTheme.bodySmall!.copyWith(color: theme.colorScheme.secondary),
                    child: subtitle!,
                  ),
              ],
            ),
            Spacer(),
            if (trailing != null && rightSpacing > 0.0) SizedBox(width: rightSpacing),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class ConstrainedListItem extends StatelessWidget {
  const ConstrainedListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: c.maxListWidth),
        child: MyListTile(
          title: title,
          subtitle: subtitle,
          leading: leading,
          trailing: trailing,
          onTap: onTap,
        ),
      ),
    );
  }
}
