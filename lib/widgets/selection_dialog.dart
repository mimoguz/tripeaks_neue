import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/common_dialog.dart';

class SelectionDialog extends StatelessWidget {
  const SelectionDialog({super.key, required this.options, required this.selected, this.title});

  final List<String> options;
  final int selected;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return CommonDialog(
      title: title != null ? Text(title!) : null,
      content: RadioGroup(
        onChanged: (value) => Navigator.pop(context, value ?? -1),
        groupValue: selected,
        child: ListTileTheme(
          data: ListTileThemeData(
            visualDensity: .compact,
            titleTextStyle: Theme.of(context).textTheme.bodyMedium,
            controlAffinity: .leading,
            horizontalTitleGap: c.itemSpacing - c.radioCorrection,
            contentPadding: EdgeInsets.fromLTRB(c.itemSpacing - c.radioCorrection, 0.0, c.itemSpacing, 0.0),
          ),
          child: Column(
            children: [
              for (final (index, item) in options.indexed)
                RadioListTile<int>(value: index, title: Text(item)),
            ],
          ),
        ),
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
}
