import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/oss_licenses.dart';
import 'package:tripeaks_neue/widgets/translucent_dialog.dart';

class LicenseDialog extends StatelessWidget {
  const LicenseDialog({super.key, required this.package});

  final Package package;

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return TranslucentDialog(
      title: Text(package.name),
      content: Text(package.license ?? "License not found"),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(s.licenseDialogCloseAction))],
    );
  }
}
