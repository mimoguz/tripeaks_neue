import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

final class MyListTile extends StatelessWidget {
  const MyListTile({super.key, required this.title, this.subtitle, this.leading, this.trailing, this.onTap});

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leading != null) leading!,
            if (leading != null) const SizedBox(width: 16.0),
            Column(
              spacing: 4.0,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(style: Theme.of(context).textTheme.bodyMedium!, child: title),
                if (subtitle != null)
                  DefaultTextStyle(style: Theme.of(context).textTheme.bodySmall!, child: subtitle!),
              ],
            ),
            Spacer(),
            if (trailing != null) const SizedBox(width: 8.0),
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
