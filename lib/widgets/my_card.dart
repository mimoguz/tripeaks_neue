import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

final class const MyCard({
  super.key,
  required final Widget child,
  final EdgeInsets padding = c.cardPadding,
  final BorderRadius borderRadius = c.commonBorderRadius,
  final Color? background,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colourExt = theme.extension<MyColourThemeExt>()!;
    final valueExt = theme.extension<MyValueExt>()!;
    return Material(
      borderRadius: borderRadius,
      color: background ?? colourExt.cardBackground,
      elevation: valueExt.cardElevation,
      shadowColor: Colors.black26,
      type: .card,
      clipBehavior: .antiAlias,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: colourExt.faintBorder, width: 1),
        ),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
