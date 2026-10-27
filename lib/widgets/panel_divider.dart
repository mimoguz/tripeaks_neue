import 'package:flutter/widgets.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

class const PanelDivider({super.key, final EdgeInsets? padding}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Container(height: 1, color: context.colours.panelDivider),
    );
  }
}
