import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class const MyDialog({
  super.key,
  required final Widget title,
  required final Widget content,
  final List<Widget>? actions,
  final MainAxisAlignment? actionsAlignment,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      titleTextStyle: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
      title: Row(
        crossAxisAlignment: .center,
        spacing: c.DialogMetrics.horizontalPadding,
        children: [
          Expanded(child: title),
          CloseButton(
            style: FilledButton.styleFrom(
              backgroundColor: theme.colorScheme.faintButtonBackground,
              foregroundColor: theme.colorScheme.faintButttonIcon,
              padding: EdgeInsets.all(2.0),
              minimumSize: Size.square(32.0),
            ),
          ),
        ],
      ),
      titlePadding: c.DialogMetrics.titlePadding,
      contentPadding: EdgeInsets.zero,
      actionsPadding: c.DialogMetrics.actionsPadding,
      surfaceTintColor: theme.colorScheme.dialogBackground,
      backgroundColor: theme.colorScheme.dialogBackground,
      shadowColor: theme.shadowColor,
      actionsAlignment: actionsAlignment ?? .center,
      elevation: 4.0,
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          const DialogDivider(),
          Flexible(child: SingleChildScrollView(primary: false, child: content)),
          if (actions != null && actions!.isNotEmpty) const DialogDivider(),
          if (actions == null || actions!.isEmpty) const SizedBox(height: c.DialogMetrics.verticalPadding),
        ],
      ),
      shape: c.DialogMetrics.shape,
      actions: actions,
    );
  }
}

final class const MyBottomSheet({
  super.key,
  required final Widget title,
  required final Widget content,
  final List<Widget>? actions,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = MediaQuery.heightOf(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: (height * 0.33).floorToDouble(),
        maxHeight: (height * 0.80).floorToDouble(),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.sheetBackground,
          borderRadius: c.DialogMetrics.bottomSheetBorderRadius,
          border: Border.all(color: c.faintBorderColour),
          boxShadow: <BoxShadow>[BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0.0, 1.0))],
        ),
        child: Column(
          mainAxisSize: .min,
          children: [
            Padding(
              padding: c.DialogMetrics.titlePadding,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                spacing: 4.0,
                children: [
                  Flexible(
                    child: DefaultTextStyle(
                      style: theme.textTheme.titleLarge!.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      child: title,
                    ),
                  ),
                  CloseButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: theme.colorScheme.faintButtonBackground,
                      foregroundColor: theme.colorScheme.faintButttonIcon,
                      padding: EdgeInsets.all(2.0),
                      minimumSize: Size.square(32.0),
                    ),
                  ),
                ],
              ),
            ),
            DialogDivider(),
            Flexible(
              child: SingleChildScrollView(
                child: Material(type: .transparency, child: content),
              ),
            ),
            if (actions != null && actions!.isNotEmpty) ...[
              DialogDivider(),
              Padding(
                padding: c.DialogMetrics.safeActionsPadding,
                child: Row(mainAxisAlignment: .end, spacing: 16.0, children: actions!),
              ),
            ],
            if (actions == null || actions!.isEmpty)
              SizedBox(height: c.DialogMetrics.safeActionsPadding.bottom),
          ],
        ),
      ),
    );
  }
}

final class DialogDivider extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Divider(height: 1.0, color: colours.dialogDivider);
  }
}
