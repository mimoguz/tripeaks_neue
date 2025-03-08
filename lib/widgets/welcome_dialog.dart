import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/info_page/info_page.dart';
import 'package:tripeaks_neue/pages/settings_page/settings_page.dart';
import 'package:tripeaks_neue/widgets/translucent_dialog.dart';

class WelcomeDialog extends StatelessWidget {
  const WelcomeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AppLocalizations.of(context)!;
    return TranslucentDialog(
      title: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12.0,
          children: [
            Center(child: Image.asset("images/welcome.png", width: 90, height: 90)),
            Text(s.welcomeDialogTitle),
          ],
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16.0,
        children: [
          Text(s.welcomeDialogMessage),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => _navigateTo(context, (_) => InfoPage()),
                  child: Text(s.welcomeDialogToInfoPageAction),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => _navigateTo(context, (_) => SettingsPage()),
                  child: Text(s.welcomeDialogToSettingsPageAction),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(s.welcomeDialogCloseAction),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget Function(BuildContext) route) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: route), (route) => route.isFirst);
  }
}
