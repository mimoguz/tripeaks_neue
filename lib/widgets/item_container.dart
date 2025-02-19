import 'package:flutter/widgets.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class ListItemContainer extends StatelessWidget {
  const ListItemContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: c.maxListWidth), child: child),
    );
  }
}
