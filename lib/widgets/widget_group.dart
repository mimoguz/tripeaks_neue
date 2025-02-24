import 'package:flutter/material.dart';

class WidgetGroup extends StatelessWidget {
  const WidgetGroup({super.key, required this.title, required this.control});

  final Widget title;
  final Widget control;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4.0,
      children: [
        Row(children: [DefaultTextStyle(style: textTheme.bodyMedium!, child: title)]),
        Row(children: [Flexible(child: control)]),
      ],
    );
  }
}
