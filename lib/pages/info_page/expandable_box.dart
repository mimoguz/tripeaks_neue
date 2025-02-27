import 'package:flutter/material.dart';

class ExpandableBox extends StatelessWidget {
  const ExpandableBox({super.key, required this.expanded, required this.title, this.onTap, this.child});

  final bool expanded;
  final Widget? child;
  final Widget title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: Durations.short3,
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onTap,
                    radius: 20.0,
                    child: Padding(padding: const EdgeInsets.all(16.0), child: title),
                  ),
                ),
              ],
            ),
            if (expanded && child != null) child!,
          ],
        ),
      ),
    );
  }
}
