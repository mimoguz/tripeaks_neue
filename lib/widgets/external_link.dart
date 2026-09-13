import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

class ExternalLink extends StatelessWidget {
  const ExternalLink({super.key, required this.uri, this.label, this.alt});

  final Uri uri;
  final String? label;
  final String? alt;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
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
                Icon(CustomIcons.link20, color: theme.colorScheme.primary, size: 20.0),
                Flexible(
                  child: Text(
                    label ?? uri.toString().replaceAll("data:,", ""),
                    softWrap: false,
                    overflow: .fade,
                    style: theme.textTheme.bodyMedium!.copyWith(color: theme.colorScheme.primary),
                  ),
                ),
                Icon(CustomIcons.copy16, color: theme.colorScheme.outline, size: 16.0),
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
