import 'dart:ui';

import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/util/platform_utils.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

final class const EndingCard({
  super.key,
  required final double width,
  required final Widget content,
  required final List<Widget> actions,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return ClipRRect(
      borderRadius: c.commonBorderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: theme.colorScheme.surfaceContainerHigh.withAlpha(200),
          padding: c.cardPadding,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: .min,
              crossAxisAlignment: .stretch,
              spacing: 10.0,
              children: [content, SizedBox(height: 0), ...actions, const EndingCardToolBar()],
            ),
          ),
        ),
      ),
    );
  }
}

final class const EndingCardToolBar({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final colours = context.colours;
    return Row(
      mainAxisAlignment: .center,
      spacing: c.itemSpacing,
      children: [
        IconButton(
          onPressed: Actions.handler(context, const NewGameWithLayoutIntent()),
          icon: Icon(CustomIcons.pickAndPlay, size: 24, color: colours.onSurfaceVariant),
        ),
        IconButton(
          onPressed: Actions.handler(context, const RestartIntent()),
          icon: Icon(Icons.restart_alt, size: 24, color: colours.onSurfaceVariant),
        ),
        if (canExit)
          IconButton(
            onPressed: Actions.handler(context, const ExitIntent()),
            icon: Icon(Icons.exit_to_app, size: 24, color: colours.onSurfaceVariant),
          ),
      ],
    );
  }
}
