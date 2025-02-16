import 'package:flutter/material.dart';
import 'package:tripeaks_neue/pages/shared/item_container.dart';

class HorizontalSettingTile extends StatelessWidget {
  const HorizontalSettingTile({super.key, required this.title, required this.control});

  final Widget title;
  final Widget control;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListItemContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 8.0,
        children: [DefaultTextStyle(style: textTheme.bodyMedium!, child: Flexible(child: title)), control],
      ),
    );
  }
}

class VerticalSettingTile extends StatelessWidget {
  const VerticalSettingTile({super.key, required this.title, required this.control});

  final Widget title;
  final Widget control;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ListItemContainer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.0,
        children: [
          Row(children: [DefaultTextStyle(style: textTheme.bodyMedium!, child: title)]),
          Row(children: [Flexible(child: control)]),
        ],
      ),
    );
  }
}
