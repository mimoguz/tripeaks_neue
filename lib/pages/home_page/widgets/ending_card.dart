import 'dart:ui';

import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
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
          width: width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: .min,
              spacing: 10.0,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    c.cardPaddingHorizontal,
                    c.cardPaddingVertical,
                    c.cardPaddingHorizontal,
                    0,
                  ),
                  child: Column(
                    mainAxisSize: .min,
                    crossAxisAlignment: .stretch,
                    spacing: 4.0,
                    children: [content, SizedBox(height: 0.0), ...actions],
                  ),
                ),
                Divider(height: 1, color: theme.colorScheme.onSurfaceVariant.withAlpha(20)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    c.cardPaddingHorizontal,
                    0,
                    c.cardPaddingHorizontal,
                    c.cardPaddingVertical,
                  ),
                  child: const EndingCardToolBar(),
                ),
              ],
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
      mainAxisAlignment: .spaceAround,
      children: [
        IconButton(
          onPressed: Actions.handler(context, const NewGameWithLayoutIntent()),
          tooltip: s.newGameWithLayoutAction,
          icon: Icon(CustomIcons.pickAndPlay, color: colours.onSurfaceVariant),
        ),
        IconButton(
          onPressed: Actions.handler(context, const RestartIntent()),
          tooltip: s.restartGameAction,
          icon: Icon(Icons.restart_alt, color: colours.onSurfaceVariant),
        ),
        IconButton(
          onPressed: Actions.handler(context, const ExitIntent()),
          tooltip: s.exitAction,
          icon: Icon(Icons.exit_to_app, color: colours.tertiary),
        ),
      ],
    );
  }
}
