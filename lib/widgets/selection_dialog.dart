import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/widgets/list_tile.dart';
import 'package:tripeaks_neue/widgets/translucent_dialog.dart';

class SelectionDialog extends StatelessWidget {
  const SelectionDialog({super.key, required this.options, required this.selected, this.title});

  final List<String> options;
  final int selected;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return TranslucentDialog(
      title: title != null ? Text(title!) : null,
      content: Column(
        children: [
          for (final (index, item) in options.indexed)
            MyListTile(
              leading: Radio<int>(
                value: index,
                groupValue: selected,
                visualDensity: VisualDensity.compact,
                onChanged: (value) => Navigator.pop(context, value ?? -1),
              ),
              title: Text(item),
              onTap: () => Navigator.pop(context, index),
              padding: _padding,
            ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, -1),
          style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
          child: Text(s.cancelAction),
        ),
      ],
    );
  }

  static const _padding = EdgeInsets.only(left: 0, right: 10, top: 6, bottom: 6);
}
