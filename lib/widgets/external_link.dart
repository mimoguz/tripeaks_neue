import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExternalLink extends StatelessWidget {
  const ExternalLink({super.key, required this.uri, this.label, this.alt});

  final Uri uri;
  final String? label;
  final String? alt;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Semantics(
      label: alt ?? label ?? uri.toString(),
      child: InkWell(
        onTap: () => _copy(context),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8.0,
          children: [
            // TODO: Rotated icon
            Icon(Icons.link, color: colours.primary),
            Flexible(
              child: Text(
                label ?? uri.toString(),
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: colours.primary),
              ),
            ),
            // TODO: 16px icon
            Icon(Icons.copy, color: colours.outline, size: 16.0),
          ],
        ),
      ),
    );
  }

  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: uri.toString()));
    if (context.mounted) {
      // TODO: String to arb
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Link copied to clipboard")));
    }
  }
}
