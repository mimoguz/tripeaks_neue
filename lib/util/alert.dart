import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_dialog.dart';

Future<void> alert(BuildContext context, {required String title, required String message}) =>
    showCommonDialog(
      context,
      (context) => MyDialog(
        title: Text(title),
        content: Padding(padding: c.DialogMetrics.contentPaddingTight, child: Text(message)),
      ),
    );
