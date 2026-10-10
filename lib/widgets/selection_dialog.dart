import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/platform_utils.dart' show isDesktopOrWeb;
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/common_dialog.dart';

class const SelectionDialog({
  super.key,
  required final List<Widget> options,
  required final int selected,
  final String? title,
}) extends StatefulWidget {
  @override
  State<SelectionDialog> createState() => _SelectionDialogState();
}

class _SelectionDialogState() extends State<SelectionDialog> {
  var selected = -1;
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    selected = widget.selected;
    _focus = FocusNode(descendantsAreFocusable: false);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final theme = context.theme;
    return CommonDialog(
      title: widget.title != null ? Text(widget.title!) : null,
      content: RadioGroup(
        onChanged: (value) {
          if (value != null) {
            setState(() {
              selected = value;
            });
          }
        },
        groupValue: selected,
        child: ListTileTheme(
          data: ListTileThemeData(
            visualDensity: .compact,
            titleTextStyle: theme.textTheme.bodyMedium,
            controlAffinity: .leading,
            horizontalTitleGap: c.itemSpacing - c.radioCorrection + (isDesktopOrWeb ? 1 : 0),
            contentPadding: EdgeInsets.fromLTRB(c.itemSpacing - c.radioCorrection, 0.0, c.itemSpacing, 0.0),
          ),
          child: Column(
            children: [
              for (final (index, item) in widget.options.indexed)
                InkWell(
                  onTap: () => Navigator.pop(context, index),
                  child: KeyboardListener(
                    focusNode: _focus,
                    onKeyEvent: (e) {
                      switch (e.logicalKey) {
                        case LogicalKeyboardKey.accept:
                        case LogicalKeyboardKey.enter:
                          setState(() {
                            selected = index;
                          });
                          Navigator.pop(context, index);
                        default:
                          return;
                      }
                    },
                    child: IgnorePointer(
                      child: RadioListTile<int>(value: index, title: item),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          autofocus: false,
          focusNode: _focus,
          onPressed: () => Navigator.pop(context, -1),
          style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
          child: Text(s.cancelAction),
        ),
      ],
    );
  }
}
