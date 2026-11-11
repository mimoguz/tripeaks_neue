import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/dividers.dart';
import 'package:tripeaks_neue/widgets/scroll_shadow.dart';

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
    final colours = theme.colorScheme;
    final colourExt = theme.extension<MyColourThemeExt>()!;
    final valueExt = theme.extension<MyValueExt>()!;
    return AlertDialog(
      clipBehavior: .antiAlias,
      titleTextStyle: theme.extension<MyTextThemeExt>()!.dialogTitle,
      title: Column(
        children: [
          Padding(
            padding: valueExt.dialogTitlePadding,
            child: Row(
              crossAxisAlignment: .center,
              spacing: c.DialogMetrics.horizontalPadding,
              children: [
                Expanded(child: widget.title),
                CloseButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: colourExt.faintButtonBackground,
                    foregroundColor: colourExt.faintButtonIcon,
                    padding: EdgeInsets.all(2.0),
                    minimumSize: Size.square(32.0),
                  ),
                ),
              ],
            ),
          ),
          // DialogHeaderDivider(),
        ],
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: c.DialogMetrics.actionsPadding,
      backgroundColor: colourExt.dialogBackground,
      shadowColor: colours.shadow,
      actionsAlignment: widget.actionsAlignment ?? .center,
      elevation: 4.0,
      content: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        children: [
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
    final colourExt = theme.extension<MyColourThemeExt>()!;
    final valueExt = theme.extension<MyValueExt>()!;
    final height = MediaQuery.heightOf(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: (height * 0.33).floorToDouble(),
        maxHeight: (height * 0.80).floorToDouble(),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: colourExt.sheetBackground,
          borderRadius: c.DialogMetrics.bottomSheetBorderRadius,
          border: Border.all(color: colourExt.faintBorder),
          boxShadow: <BoxShadow>[BoxShadow(color: Colors.black12, blurRadius: 3, offset: Offset(0.0, 1.0))],
        ),
        clipBehavior: .antiAlias,
        child: Column(
          mainAxisSize: .min,
          children: [
            Padding(
              // color: theme.colorScheme.sheetHeader,
              padding: valueExt.dialogTitlePadding,
              child: Row(
                mainAxisAlignment: .spaceBetween,
                crossAxisAlignment: .center,
                spacing: 4.0,
                children: [
                  Flexible(
                    child: DefaultTextStyle(
                      style: theme.extension<MyTextThemeExt>()!.dialogTitle,
                      child: widget.title,
                    ),
                  ),
                  CloseButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: colourExt.faintButtonBackground,
                      foregroundColor: colourExt.faintButtonIcon,
                      padding: EdgeInsets.all(2.0),
                      minimumSize: Size.square(32.0),
                    ),
                  ),
                ],
              ),
            ),
            SheetHeaderDivider(),
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
