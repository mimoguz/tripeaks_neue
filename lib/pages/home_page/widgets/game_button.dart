import 'dart:math';

import 'package:provider/provider.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:material_ui/material_ui.dart';

class const CircleGameButton({
  super.key,
  required final double scale,
  required final IconData icon,
  required final String tooltip,
  final IconData? smallIcon,
  final VoidCallback? onPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final decorColour = Provider.of<Settings>(context).decorColour;
    final colours = context.colours;
    final useSmall = scale < c.iconScaleThreshold;
    final size = min(c.buttonSize * scale, c.maxRealButtonSize);
    return SizedBox(
      width: size,
      height: size,
      child: Tooltip(
        message: tooltip,
        verticalOffset: size / 2.0 + 4.0,
        child: Stack(
          children: [
            Material(
              shape: CircleBorder(),
              type: MaterialType.transparency,
              // color: colours.surfaceContainerLow,
              child: Ink(
                decoration: BoxDecoration(
                  shape: .circle,
                  border: Border.all(
                    color: onPressed == null ? colours.outlineVariant : colours.outline,
                    width: 2.0,
                  ),
                ),
                child: InkWell(
                  onTap: onPressed,
                  borderRadius: const BorderRadius.all(Radius.circular(100.0)),
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: SizedBox(width: c.buttonSize, height: c.buttonSize),
                  ),
                ),
              ),
            ),
            IgnorePointer(
              child: Center(
                child: Icon(
                  useSmall && smallIcon != null ? smallIcon : icon,
                  size: useSmall ? 16.0 : 24.0,
                  color: onPressed == null ? colours.outlineVariant : decorColour.onSurface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameButton extends StatelessWidget {
  const GameButton.narrow({
    super.key,
    required this.scale,
    required this.icon,
    required this.tooltip,
    this.smallIcon,
    this.onPressed,
  }) : width = c.buttonSize,
       height = c.cardSize;

  const GameButton.wide({
    super.key,
    required this.scale,
    required this.icon,
    required this.tooltip,
    this.smallIcon,
    this.onPressed,
  }) : width = c.cardSize,
       height = c.buttonSize;

  final double width;
  final double height;
  final double scale;
  final IconData icon;
  final IconData? smallIcon;
  final VoidCallback? onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final colours = context.colours;
    final decorColour = Provider.of<Settings>(context).decorColour;
    final useSmall = scale < c.iconScaleThreshold;
    return SizedBox(
      width: width * scale,
      height: height * scale,
      child: Tooltip(
        message: tooltip,
        verticalOffset: height * scale / 2.0 + 4.0,
        child: Stack(
          children: [
            Material(
              type: MaterialType.button,
              borderRadius: BorderRadius.circular(c.commonRadiusValue * scale),
              color: onPressed != null ? decorColour.background : colours.outlineVariant,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(c.commonRadiusValue * scale),
                focusColor: colours.outlineVariant,
                hoverColor: decorColour.foreground,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(width: width, height: height),
                ),
              ),
            ),
            IgnorePointer(
              child: Center(
                child: Icon(
                  useSmall && smallIcon != null ? smallIcon : icon,
                  size: useSmall ? 16.0 : 24.0,
                  color: onPressed != null ? decorColour.controlForeground : colours.surface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
