import 'package:flutter/material.dart';

class WidgetGroup extends StatelessWidget {
  const WidgetGroup({super.key, required this.title, this.subtitle, required this.child});

  final Widget title;
  final Widget? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [
        Row(children: [DefaultTextStyle(style: textTheme.bodyMedium!, child: title)]),
        if (subtitle != null)
          Row(children: [DefaultTextStyle(style: textTheme.bodySmall!, child: subtitle!)]),
        Row(children: [Flexible(child: child)]),
      ],
    );
  }
}
