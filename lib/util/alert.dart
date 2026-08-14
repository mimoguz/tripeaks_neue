import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

Future<void> alert(BuildContext context, {required String title, required String message}) =>
    showAdaptiveDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.transparent,
      builder: (context) => CommonDialog(
        title: Text(title),
        content: Padding(
          padding: const EdgeInsets.fromLTRB(c.dialogPadding, 4, c.dialogPadding, 8),
          child: Text(message),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.closeAction),
          ),
        ],
      ),
    );
