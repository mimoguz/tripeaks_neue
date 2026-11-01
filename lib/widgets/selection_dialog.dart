import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_dialog.dart';
import 'package:tripeaks_neue/widgets/my_selection_tiles.dart';

class const MySelectionDialog<T>({
  super.key,
  required final List<T> values,
  required final T selected,
  required final Widget title,
  required final Widget Function(T) itemBuilder,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyDialog(
      title: title,
      content: Padding(
        padding: const EdgeInsets.only(bottom: c.DialogMetrics.verticalPadding),
        child: Column(
          children: [
            for (final v in values)
              MyRadioListTile(
                value: v,
                isChecked: v == selected,
                label: itemBuilder(v),
                onTap: (v) => Navigator.pop(context, v),
              ),
          ],
        ),
      ),
    );
  }
}

class const MySelectionSheet<T>({
  super.key,
  required final List<T> values,
  required final T selected,
  required final Widget title,
  required final Widget Function(T) itemBuilder,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyBottomSheet(
      title: title,
      content: Column(
        children: [
          for (final v in values)
            MyRadioListTile(
              value: v,
              isChecked: v == selected,
              label: itemBuilder(v),
              onTap: (v) => Navigator.pop(context, v),
            ),
        ],
      ),
    );
  }
}
