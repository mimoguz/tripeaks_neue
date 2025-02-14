import 'package:flutter/material.dart';
import 'package:tripeaks_neue/pages/shared/item_container.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({super.key, required this.title, required this.control, this.value});

  final Widget title;
  final Widget control;
  final Widget? value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListItemContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8.0,
          children: [
            DefaultTextStyle(style: textTheme.titleSmall!, child: title),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8.0,
              children: [
                control,
                if (value != null)
                  DefaultTextStyle(
                    style: textTheme.labelSmall!.copyWith(color: Theme.of(context).colorScheme.primary),
                    child: value!,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
