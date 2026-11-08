import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
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
    final (cardBackground, frameForeground, labelColour, dividerColour, elevation) = widget.isSelected
        ? (
            widget.selectedBackground ?? colourExt.cardBackground,
            widget.selectedForeground ?? colours.onSurfaceVariant,
            widget.selectedForeground ?? colours.onSurface,
            widget.selectedForeground ?? colourExt.cardDivider,
            2.0,
          )
        : (
            colourExt.cardBackground,
            colours.onSurfaceVariant,
            colours.onSurfaceVariant,
            colourExt.cardDivider,
            0.1,
          );
    return Stack(
      alignment: .center,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: Material(
            color: _focused ? colours.primary : Colors.transparent,
            borderRadius: _outerRadius,
            child: Padding(
              padding: const EdgeInsets.all(_borderWidth),
              child: Material(
                borderRadius: _raidus,
                elevation: elevation,
                color: cardBackground,
                shadowColor: Colors.black38,
                type: .card,
                child: InkWell(
                  focusNode: _focus,
                  onTap: widget.onTap,
                  borderRadius: _raidus,
                  mouseCursor: SystemMouseCursors.click,
                  child: Padding(
                    padding: const EdgeInsets.all(_padding),
                    child: Row(
                      mainAxisSize: .min,
                      children: [
                        Column(
                          spacing: 3,
                          mainAxisSize: .min,
                          children: [
                            Flexible(
                              child: Ink(
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: dividerColour)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 5.0),
                                  child: ClipRRect(
                                    borderRadius: _innerRadius,
                                    child: IconTheme(
                                      data: IconThemeData(color: frameForeground),
                                      child: widget.child,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              widget.label,
                              style: theme.textTheme.labelMedium?.copyWith(color: labelColour),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: AnimatedSwitcher(
            duration: Durations.medium3,
            child: Material(
              key: ValueKey(widget.isSelected),
              color: colours.primary,
              elevation: 3,
              type: .circle,
              child: widget.isSelected
                  ? Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(CustomIcons.check12, color: colours.onPrimary, size: 12),
                    )
                  : SizedBox(key: ValueKey(widget.isSelected)),
            ),
          ),
        ),
      ],
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
