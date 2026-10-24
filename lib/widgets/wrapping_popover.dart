import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class const WrappingPopover<T>({
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
        child: SingleChildScrollView(
          child: Padding(
            padding: _padding,
            child: Wrap(
              spacing: c.itemSpacing,
              runSpacing: c.itemSpacing,
              alignment: .center,
              runAlignment: .center,
              children: [for (final v in values) itemBuilder(v, s)],
            ),
          ),
        ),
      ),
    );
  }

  static const _padding = EdgeInsets.all(c.dialogPadding);
}
