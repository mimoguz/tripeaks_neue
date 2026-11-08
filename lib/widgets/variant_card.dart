import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

final class const VariantCard<T>({
  super.key,
  final Color? selectedBackground,
  final Color? selectedForeground,
  final Color? background,
  final Color? foreground,
  final double frameWidth = 80,
  final double frameHeight = 80,
  required final T variant,
  required final bool isSelected,
  required final String label,
  required final VoidCallback onTap,
  required final Widget child,
}) extends StatefulWidget {
  @override
  State<VariantCard> createState() => _VariantCardState();
}

class _VariantCardState extends State<VariantCard> {
  late final FocusNode _focus;
  var _focused = false;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colours = theme.colorScheme;
    final colourExt = theme.extension<MyColourThemeExt>()!;
    final (cardBackground, frameForeground, labelColour, borderColour) = widget.isSelected
        ? (
            widget.selectedBackground ?? widget.background ?? colours.primaryContainer,
            widget.selectedForeground ?? widget.foreground ?? colours.onPrimaryContainer,
            widget.selectedForeground ?? colours.onPrimaryContainer,
            widget.selectedBackground ?? colours.primary,
          )
        : (
            widget.background ?? colours.surfaceContainer,
            widget.foreground ?? colours.onSurfaceVariant,
            colours.onSurface,
            Colors.transparent,
          );
    return TapRegion(
      onTapInside: (_) => widget.onTap(),
      child: Material(
        type: .transparency,
        child: Column(
          mainAxisSize: .min,
          spacing: 3,
          children: [
            InkWell(
              onTap: widget.onTap,
              focusNode: _focus,
              borderRadius: _focusRadius,
              child: Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: borderColour, width: _borderWidth),
                  borderRadius: _selectionRadius,
                ),
                child: Padding(
                  padding: _borderPadding,
                  child: SizedBox(
                    width: widget.frameWidth,
                    height: widget.frameHeight,
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: _raidus,
                        color: cardBackground,
                        border: Border.all(
                          color: colourExt.faintBorder,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: _raidus,
                        clipBehavior: .antiAlias,
                        child: Center(
                          child: IconTheme(
                            data: IconThemeData(color: frameForeground),
                            child: widget.child,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(widget.label, style: theme.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }

  void _onFocusChange() {
    setState(() {
      _focused = _focus.hasFocus;
    });
  }

  static const _borderWidth = 2.0;
  static const _borderPaddingVal = 4.0;
  static const _radiusVal = 12.0;
  static const _borderPadding = EdgeInsets.all(_borderPaddingVal);
  static const _raidus = BorderRadius.all(Radius.circular(_radiusVal));
  static const _selectionRadius = BorderRadius.all(Radius.circular(_radiusVal + _borderPaddingVal));
  static const _focusRadius = BorderRadius.all(Radius.circular(_radiusVal + _borderPaddingVal));
}
