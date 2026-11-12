import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

final class const ConstrainedItem({
  super.key,
  required final Widget child,
  final EdgeInsets padding = c.utilPageInsetsHorizontal,
  final double maxHeight = double.infinity,
  final double minHeight = 0,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: ConstrainedBox(
      constraints: BoxConstraints(maxWidth: c.maxListWidth, maxHeight: maxHeight, minHeight: minHeight),
      child: Padding(padding: padding, child: child),
    ),
  );
}

final class const ConstrainedSliverMaterial({
  super.key,
  required final Widget child,
  final EdgeInsets padding = c.utilPageInsetsHorizontal,
  final double maxHeight = double.infinity,
  final double minHeight = 0,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: ConstrainedItem(padding: padding, maxHeight: maxHeight, minHeight: minHeight, child: child),
  );
}

final class const ConstrainedSliver({
  super.key,
  required final Widget child,
  final EdgeInsets padding = c.utilPageInsetsHorizontal,
  final double maxHeight = double.infinity,
  final double minHeight = 0,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Material(
      type: .transparency,
      child: ConstrainedItem(padding: padding, maxHeight: maxHeight, minHeight: minHeight, child: child),
    ),
  );
}
