import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/generated/oss_licenses.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class LicenseDialog extends StatelessWidget {
  const LicenseDialog({super.key, required this.package});

  final Package package;

  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    return CommonDialog(
      title: Text(package.name),
      content: Padding(
        padding: EdgeInsets.all(c.dialogPadding),
        child: Text(package.license ?? "License not found"),
      ),
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text(s.licenseDialogCloseAction))],
    );
  }
}
