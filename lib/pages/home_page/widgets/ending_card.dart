import 'dart:ui';

import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/stores/data/single_game_statistics.dart';
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
          width: width,
          child: SingleChildScrollView(
            child: Padding(
              padding: c.cardPadding,
              child: Column(
                mainAxisSize: .min,
                crossAxisAlignment: .stretch,
                spacing: 20.0,
                children: [
                  content,
                  FilledButtonTheme(
                    data: FilledButtonThemeData(
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary.withAlpha(150),
                      ),
                    ),
                    child: Column(
                      spacing: 8.0,
                      crossAxisAlignment: .stretch,
                      children: [...actions, const EndingCardToolBar()],
                    ),
                  ),
                ],
              ),
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
          tooltip: s.newGameWithLayoutAction,
          icon: Icon(CustomIcons.pickAndPlay, size: 24, color: colours.onSurfaceVariant),
        ),
        IconButton(
          onPressed: Actions.handler(context, const RestartIntent()),
          tooltip: s.restartGameAction,
          icon: Icon(Icons.restart_alt, size: 24, color: colours.onSurfaceVariant),
        ),
        if (canExit)
          IconButton(
            onPressed: Actions.handler(context, const ExitIntent()),
            tooltip: s.exitAction,
            icon: Icon(Icons.exit_to_app, size: 24, color: colours.onSurfaceVariant),
          ),
      ],
    );
  }
}

final class const HighlightsLine({
  super.key,
  required final SingleGameStatistics stats,
  final bool emphasis = false,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colour = emphasis ? context.colours.tertiary : context.colours.onSurfaceVariant;
    final s = context.strings;
    return Row(
      spacing: 24.0,
      children: [
        Tooltip(
          message: s.scoreTooltip,
          child: Row(
            spacing: 4.0,
            children: [
              Icon(CustomIcons.star16, size: 16.0, color: colour),
              Text("${stats.score}"),
            ],
          ),
        ),
        Tooltip(
          message: s.chainTooltip,
          child: Row(
            spacing: 6.0,
            children: [
              Icon(CustomIcons.chain16, size: 16.0, color: colour),
              Text("${stats.longestChain}"),
            ],
          ),
        ),
      ],
    );
  }
}
