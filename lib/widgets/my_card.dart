import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

final class const MyCard({super.key, required final Widget child, final EdgeInsets padding = c.cardPadding})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return Material(
      borderRadius: c.commonBorderRadius,
      color: theme.colorScheme.panelBackground,
      shadowColor: theme.shadowColor,
      elevation: 2,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: c.commonBorderRadius,
          border: Border.all(color: theme.colorScheme.faintBorder, width: 1),
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
