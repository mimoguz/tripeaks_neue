import 'dart:math';

import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:flutter/material.dart';

class CircleGameButton extends StatelessWidget {
  const CircleGameButton({
    super.key,
    required this.scale,
    required this.icon,
    required this.tooltip,
    this.smallIcon,
    this.onPressed,
  });
  final double scale;
  final IconData icon;
  final String tooltip;
  final IconData? smallIcon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
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
                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
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
                  color: onPressed == null ? colours.outlineVariant : colours.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameButton extends StatefulWidget {
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
  State<GameButton> createState() => _GameButtonState();
}

class _GameButtonState extends State<GameButton> {
  final _focusNode = FocusNode();
  Color? _buttonColour;
  Color? _iconColor;
  Color? _primary;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_setColours);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_setColours);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colours = theme.colorScheme;
    _buttonColour ??= colours.primaryContainer;
    _iconColor ??= colours.onPrimaryContainer;
    _primary ??= colours.primary;
    if (colours.primary != _primary) {
      _setColours();
      _primary = colours.primary;
    }
    final useSmall = widget.scale < c.iconScaleThreshold;
    return SizedBox(
      width: widget.width * widget.scale,
      height: widget.height * widget.scale,
      child: Tooltip(
        message: widget.tooltip,
        verticalOffset: widget.height * widget.scale / 2.0 + 4.0,
        child: Stack(
          children: [
            Material(
              type: MaterialType.button,
              borderRadius: BorderRadius.circular(c.commonRadius * widget.scale),
              color: widget.onPressed != null ? _buttonColour : colours.outlineVariant,
              child: InkWell(
                focusNode: _focusNode,
                onTap: widget.onPressed,
                borderRadius: BorderRadius.circular(c.commonRadius * widget.scale),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(width: widget.width, height: widget.height),
                ),
              ),
            ),
            IgnorePointer(
              child: Center(
                child: Icon(
                  useSmall && widget.smallIcon != null ? widget.smallIcon : widget.icon,
                  size: useSmall ? 16.0 : 24.0,
                  color: widget.onPressed != null ? _iconColor : colours.surface,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setColours() => setState(() {
    if (_focusNode.hasFocus) {
      setState(() {
        _buttonColour = Theme.of(context).colorScheme.primary;
        _iconColor = Theme.of(context).colorScheme.onPrimary;
      });
    } else {
      setState(() {
        _buttonColour = Theme.of(context).colorScheme.primaryContainer;
        _iconColor = Theme.of(context).colorScheme.onPrimaryContainer;
      });
    }
  });
}
