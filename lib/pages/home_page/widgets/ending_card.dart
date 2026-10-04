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
          child: Column(
            mainAxisSize: .min,
            spacing: 12,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                child: Column(
                  mainAxisSize: .min,
                  crossAxisAlignment: .stretch,
                  spacing: 12,
                  children: [content, ...actions],
                ),
              ),
              Divider(height: 1, color: theme.colorScheme.onSurfaceVariant.withAlpha(20)),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                child: const EndingCardToolBar(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class const EndingCardToolBar({super.key}) extends StatelessWidget {
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
