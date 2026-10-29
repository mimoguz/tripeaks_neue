import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/item_container.dart';

final class const GroupTile({
  super.key,
  required final List<Widget> children,
  final String? title,
  final EdgeInsets? padding,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ListItemContainer(
      child: Material(
        color: theme.colorScheme.panelBackground,
        borderRadius: c.commonBorderRadius,
        shadowColor: theme.shadowColor,
        clipBehavior: .antiAlias,
        type: .card,
        elevation: 1.5,
        child: Ink(
          decoration: c.faintPanelBorder,
          child: Padding(
            padding: padding ?? c.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null)
                  Text(
                    title!,
                    style: theme.textTheme.titleSmall!.copyWith(
                      color: theme.colorScheme.outline,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (title != null) const SizedBox(height: 8.0),
                ...children,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GroupTileDivider extends StatelessWidget {
  const GroupTileDivider({super.key, this.padding});

  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(bottom: c.divPadding),
      child: Divider(),
    );
  }
}
