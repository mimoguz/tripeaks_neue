import 'package:flutter/widgets.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class const ListItemContainer({super.key, final double minHeight = 0.0, required final Widget child})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: c.maxListWidth, minHeight: minHeight),
        child: child,
      ),
    );
  }
}
