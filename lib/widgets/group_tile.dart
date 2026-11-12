import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/constrained.dart';
import 'package:tripeaks_neue/widgets/my_card.dart';

final class const GroupTile({
  super.key,
  required final List<Widget> children,
  final String? title,
  final EdgeInsets? padding,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedItem(
      child: MyCard(
        padding: padding ?? c.cardPadding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
      ),
    );
  }
}
