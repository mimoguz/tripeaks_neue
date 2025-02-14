import 'package:flutter/widgets.dart';

class ListItemContainer extends StatelessWidget {
  const ListItemContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 550.0), child: child));
  }
}
