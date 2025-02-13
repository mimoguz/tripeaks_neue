import 'package:tripeaks_neue/pages/shared/item_container.dart';
import 'package:flutter/material.dart';

final class ListButton extends StatelessWidget {
  const ListButton({super.key, this.onPressed, required this.icon, required this.text});

  final VoidCallback? onPressed;
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ListItemContainer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListTile(
          iconColor: Theme.of(context).colorScheme.outline,
          leading: Icon(icon),
          title: Text(text),
          onTap: onPressed,
          style: ListTileStyle.drawer,
        ),
      ),
    );
  }
}
