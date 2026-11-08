import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

final class const MyCard({
  super.key,
  required final Widget child,
  final EdgeInsets padding = c.cardPadding,
  final Color? background,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colourExt = theme.extension<MyColourThemeExt>()!;
    final valueExt = theme.extension<MyValueExt>()!;
    return Material(
      borderRadius: c.commonBorderRadius,
      color: background ?? colourExt.cardBackground,
      elevation: valueExt.cardElevation,
      shadowColor: Colors.black26,
      type: .card,
      clipBehavior: .antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: c.commonBorderRadius,
          border: Border.all(color: colourExt.faintBorder, width: 1),
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
