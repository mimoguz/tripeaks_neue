import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

class ExternalLink extends StatelessWidget {
  const ExternalLink({super.key, required this.uri, this.label, this.alt});

  final Uri uri;
  final String? label;
  final String? alt;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final style = theme.extension<MyTextThemeExt>()!.link;
    return Semantics(
      label: alt ?? label ?? uri.toString(),
      child: Tooltip(
        message: uri.toString(),
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          onTap: () => _copy(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 8.0,
              children: [
                Flexible(
                  child: Text(
                    label ?? uri.toString().replaceAll("data:,", ""),
                    softWrap: false,
                    overflow: .fade,
                    style: style,
                  ),
                ),
                Icon(CustomIcons.copy16, color: theme.colorScheme.onSurfaceVariant, size: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // TODO: Snackbar looks weird on desktop
  Future<void> _copy(BuildContext context) async {
    await Clipboard.setData(ClipboardData(text: uri.toString()));
    if (context.mounted) {
      // TODO: String to arb
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Link copied to clipboard")));
    }
  }
}
