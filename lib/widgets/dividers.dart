import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/constrained.dart';

final class const SettingDivider({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colourExt = context.theme.extension<MyColourThemeExt>()!;
    return Divider(height: 1.0, color: colourExt.settingItemDivider);
  }
}

final class const CardDivider({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colourExt = context.theme.extension<MyColourThemeExt>()!;
    return Divider(height: 1.0, color: colourExt.cardDivider);
  }
}

final class const DialogHeaderDivider({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colourExt = context.theme.extension<MyColourThemeExt>()!;
    return Divider(height: 1.0, color: colourExt.dialogHeaderDivider);
  }
}

final class const DialogDivider({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colourExt = context.theme.extension<MyColourThemeExt>()!;
    return Divider(height: 1.0, color: colourExt.dialogDivider);
  }
}

final class const SheetHeaderDivider({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colourExt = context.theme.extension<MyColourThemeExt>()!;
    return Divider(height: 1.0, color: colourExt.sheetHeaderDivider);
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
    final colourExt = context.theme.extension<MyColourThemeExt>()!;
    return ConstrainedItem(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
      child: Container(color: colourExt.cardDivider, height: 1),
    );
  }
}
