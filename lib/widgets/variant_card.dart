import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';

final class const VariantCard<T>({
  super.key,
  final Color? selectedBackground,
  final Color? selectedForeground,
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
    final (cardBackground, frameForeground, labelColour) = widget.isSelected
        ? (
            widget.selectedBackground ?? colours.primary,
            widget.selectedForeground ?? colours.onPrimary,
            widget.selectedForeground ?? colours.onPrimary,
          )
        : (colourExt.cardBackground, colours.onSurfaceVariant, colours.onSurface);
    return Material(
      color: _focused ? colours.primary : Colors.transparent,
      borderRadius: _outerRadius,
      child: Padding(
        padding: const EdgeInsets.all(_borderWidth),
        child: Ink(
          decoration: BoxDecoration(color: cardBackground, borderRadius: _raidus),
          child: InkWell(
            focusNode: _focus,
            onTap: widget.onTap,
            borderRadius: _raidus,
            mouseCursor: SystemMouseCursors.click,
            child: Padding(
              padding: const EdgeInsets.all(_padding),
              child: Column(
                spacing: 5,
                mainAxisSize: .min,
                children: [
                  Flexible(
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: _innerRadius,
                        color: colourExt.translucentHighlight,
                      ),
                      child: ClipRRect(
                        borderRadius: _innerRadius,
                        child: IconTheme(
                          data: IconThemeData(color: frameForeground),
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),

                  Text(widget.label, style: theme.textTheme.labelMedium?.copyWith(color: labelColour)),
                ],
              ),
            ),
          ),
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
  static const _padding = 5.0;
  static const _radiusVal = 12.0;
  static const _raidus = BorderRadius.all(Radius.circular(_radiusVal));
  static const _outerRadius = BorderRadius.all(Radius.circular(_radiusVal + _borderWidth));
  static const _innerRadius = BorderRadius.all(Radius.circular(_radiusVal - _padding));
}
