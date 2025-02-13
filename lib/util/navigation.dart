import 'package:flutter/widgets.dart';

Route createRoute(Widget Function() route) {
  return PageRouteBuilder(
    pageBuilder: (context, anim1, anim2) => route(),
    transitionsBuilder: (context, anim1, anim2, child) => SlideTransition(
      position: Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero).animate(anim1),
      child: child,
    ),
  );
}
