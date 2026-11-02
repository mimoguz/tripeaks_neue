import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/constrained.dart';

final class const SettingDivider({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Divider(height: 1.0, color: colours.settingDivider);
  }
}

final class const CardDivider({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Divider(height: 1.0, color: colours.cardDivider);
  }
}

final class const DialogDivider({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Divider(height: 1.0, color: colours.dialogDivider);
  }
}

class const ConstrainedDivider({
  super.key,
  final double verticalPadding = c.DialogMetrics.sectionSpacing,
  final double horizontalPadding = c.utilPageMargin,
  final double maxWidth = c.maxListWidth,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedItem(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      child: Container(color: context.colours.cardDivider, height: 1),
    );
  }
}
