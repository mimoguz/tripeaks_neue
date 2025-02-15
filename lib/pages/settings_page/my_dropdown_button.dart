import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class DropdownItemText extends StatelessWidget {
  const DropdownItemText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 4.0),
      child: SizedBox(
        width: c.dropdownItemWidth,
        child: Row(spacing: 12.0, children: [Text(text, style: Theme.of(context).textTheme.bodyMedium)]),
      ),
    );
  }
}

class MyDropdownButton<T> extends StatelessWidget {
  const MyDropdownButton({super.key, required this.items, required this.value, required this.onChanged});

  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final T value;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      elevation: 0,
      dropdownColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      icon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Icon(Icons.expand_more, color: Theme.of(context).colorScheme.outline),
      ),
      borderRadius: c.commonBorderRadius,
      underline: SizedBox(),
      items: items,
      onChanged: onChanged,
    );
  }
}
