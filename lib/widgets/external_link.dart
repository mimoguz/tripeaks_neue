import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';

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
      child: Tooltip(
        message: uri.toString(),
        child: InkWell(
          onTap: () => _copy(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8.0,
              children: [
                Icon(CustomIcons.link20, color: colours.primary, size: 20.0),
                Flexible(
                  child: Text(
                    label ?? uri.toString().replaceAll("data:,", ""),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: colours.primary),
                  ),
                ),
                Icon(CustomIcons.copy16, color: colours.outline, size: 16.0),
              ],
            ),
          ),
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
