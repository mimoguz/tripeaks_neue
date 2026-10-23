import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class const RadioPopover<T>({
  super.key,
  required final List<T> values,
  required final T selected,
  required final Widget Function(T, AppLocalizations) itemBuilder,
  final double width = 220,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return Material(
      type: .transparency,
      child: ConstrainedBox(
        constraints: BoxConstraints.loose(Size.fromWidth(width)),
        child: RadioGroup<T>(
          onChanged: (newValue) {
            Navigator.pop(context, newValue);
          },
          groupValue: selected,
          child: ListTileTheme(
            data: ListTileThemeData(titleTextStyle: context.theme.textTheme.bodyMedium),
            child: ListView.builder(
              padding: _padding,
              shrinkWrap: true,
              itemCount: values.length,
              itemBuilder: (context, index) =>
                  RadioListTile(value: values[index], title: itemBuilder(values[index], s)),
            ),
          ),
        ),
      ),
    );
  }

  static const _padding = EdgeInsets.symmetric(vertical: c.dialogPadding);
}
