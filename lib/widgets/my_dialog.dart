import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

class const MyDialog({
  super.key,
  required final Widget title,
  required final Widget content,
  final List<Widget>? actions,
  final MainAxisAlignment? actionsAlignment,
}) extends StatefulWidget {
  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      clipBehavior: .antiAlias,
      titleTextStyle: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant),
      title: Container(
        color: theme.colorScheme.dialogHeader,
        padding: c.DialogMetrics.titlePadding,
        child: Row(
          crossAxisAlignment: .center,
          spacing: c.DialogMetrics.horizontalPadding,
          children: [
            Expanded(child: widget.title),
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
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: c.DialogMetrics.actionsPadding,
      surfaceTintColor: theme.colorScheme.dialogBackground,
      backgroundColor: theme.colorScheme.dialogBackground,
      shadowColor: theme.shadowColor,
      actionsAlignment: widget.actionsAlignment ?? .center,
      elevation: 4.0,
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
          // const DialogDivider(),
          Flexible(
            child: ScrollShadow(
              controller: _controller,
              child: SingleChildScrollView(controller: _controller, primary: false, child: widget.content),
            ),
          ),
          // if (actions != null && actions!.isNotEmpty) const DialogDivider(),
          if (widget.actions == null || widget.actions!.isEmpty)
            const SizedBox(height: c.DialogMetrics.verticalPadding),
        ],
      ),
      shape: c.DialogMetrics.shape,
      actions: widget.actions,
    );
  }
}

final class const MyBottomSheet({
  super.key,
  required final Widget title,
  required final Widget content,
  final List<Widget>? actions,
}) extends StatefulWidget {
  @override
  State<MyBottomSheet> createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
        clipBehavior: .antiAlias,
        child: Column(
          mainAxisSize: .min,
          children: [
            Container(
              color: theme.colorScheme.sheetHeader,
              padding: c.DialogMetrics.titlePadding,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                spacing: 4.0,
                children: [
                  Flexible(
                    child: DefaultTextStyle(
                      style: theme.textTheme.titleLarge!.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      child: widget.title,
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
            // DialogDivider(),
            Flexible(
              child: ScrollShadow(
                controller: _controller,
                child: SingleChildScrollView(
                  controller: _controller,
                  primary: false,
                  child: Material(type: .transparency, child: widget.content),
                ),
              ),
            ),
            if (widget.actions != null && widget.actions!.isNotEmpty) ...[
              DialogDivider(),
              Padding(
                padding: c.DialogMetrics.safeActionsPadding,
                child: Row(mainAxisAlignment: .end, spacing: 16.0, children: widget.actions!),
              ),
            ],
            if (widget.actions == null || widget.actions!.isEmpty)
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
