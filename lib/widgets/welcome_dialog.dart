import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/pages/help_page/help_page.dart';
import 'package:tripeaks_neue/pages/settings_page/settings_page.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_dialog.dart';

class WelcomeDialog extends StatelessWidget {
  const WelcomeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return MyDialog(
      title: Row(
        spacing: 8.0,
        children: [
          Image.asset("images/welcome72.png", width: 72, height: 72),
          Flexible(child: Text(s.welcomeDialogTitle, maxLines: 2, softWrap: false, overflow: .fade)),
        ],
      ),
      content: Padding(
        padding: c.DialogMetrics.contentPaddingSymmetrical,
        child: Column(
          crossAxisAlignment: .center,
          mainAxisAlignment: .start,
          mainAxisSize: .min,
          spacing: c.itemSpacing,
          children: [
            Text(s.welcomeDialogMessage),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => _navigateTo(context, (_) => HelpPage()),
                    child: Text(s.welcomeDialogToInfoPageAction),
                  ),
                ),
              ],
            ),
            Row(
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
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget Function(BuildContext) route) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: route), (route) => route.isFirst);
  }
}
