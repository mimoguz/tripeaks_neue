import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/generated/oss_licenses.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_dialog.dart';

final class const LicenseDialog({super.key, required final Package package}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyDialog(
      title: Text(package.name),
      content: Padding(
        padding: c.DialogMetrics.contentPadding,
        child: Text(package.license ?? "License not found"),
      ),
    );
  }
}
