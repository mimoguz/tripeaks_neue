import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class DropDownItemContainer extends StatelessWidget {
  const DropDownItemContainer({super.key, required this.text});

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
