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
  required final Widget image,
  required final Widget message,
  required final SingleGameStatistics stats,
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
                spacing: 12.0,
                children: [
                  Row(children: [image]),
                  message,
                  HighlightsLine(stats: stats),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: FilledButtonTheme(
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

final class const HighlightsLine({super.key, required final SingleGameStatistics stats})
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final s = context.strings;
    final theme = context.theme;
    final labelStyle = theme.textTheme.labelSmall?.copyWith(color: theme.hintColor);
    final numberStyle = theme.textTheme.bodyLarge?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
      fontWeight: .w500,
      fontFeatures: c.fontFeatures,
    );
    return Row(
      spacing: 40.0,
      mainAxisSize: .min,
      children: [
        Column(
          spacing: 1.0,
          crossAxisAlignment: .start,
          children: [
            Text(s.scoreLabel, style: labelStyle),
            Text(stats.score.toString(), semanticsLabel: s.scoreTooltip, style: numberStyle),
          ],
        ),
        Column(
          spacing: 1.0,
          crossAxisAlignment: .start,
          children: [
            Text(s.chainLabel, style: labelStyle),
            Text(stats.longestChain.toString(), semanticsLabel: s.chainTooltip, style: numberStyle),
          ],
        ),
      ],
    );
  }
}
