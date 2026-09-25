import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/common_dialog.dart';

class const SelectionDialog({
  super.key,
  required final List<Widget> options,
  required final int selected,
  final String? title,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final theme = context.theme;
    return CommonDialog(
      title: title != null ? Text(title!) : null,
      content: RadioGroup(
        onChanged: (value) => Navigator.pop(context, value ?? -1),
        groupValue: selected,
        child: ListTileTheme(
          data: ListTileThemeData(
            visualDensity: .compact,
            titleTextStyle: theme.textTheme.bodyMedium,
            controlAffinity: .leading,
            horizontalTitleGap: c.itemSpacing - c.radioCorrection,
            contentPadding: EdgeInsets.fromLTRB(c.itemSpacing - c.radioCorrection, 0.0, c.itemSpacing, 0.0),
          ),
          child: Column(
            children: [
              for (final (index, item) in options.indexed) RadioListTile<int>(value: index, title: item),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, -1),
          style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
          child: Text(s.cancelAction),
        ),
      ],
    );
  }
}
