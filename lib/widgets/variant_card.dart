import 'package:material_ui/material_ui.dart';
import 'package:tripeaks_neue/my_theme.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

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
    final background = widget.isSelected
        ? (widget.selectedBackground ?? colours.primaryContainer)
        : colourExt.cardBackground;
    final foreground = widget.isSelected
        ? (widget.selectedForeground ?? colours.onPrimaryContainer)
        : colourExt.faintButtonIcon;
    final labelForeground = widget.isSelected
        ? (widget.selectedForeground ?? colours.onPrimaryContainer)
        : colours.primary;
    return Material(
      color: _focused ? colours.primary : Colors.transparent,
      borderRadius: _outerRadius,
      child: Padding(
        padding: const EdgeInsets.all(_borderWidth),
        child: Card(
          margin: EdgeInsets.zero,
          elevation: 0.03,
          color: background,
          shape: RoundedRectangleBorder(borderRadius: _raidus),
          shadowColor: colours.brightness == .light ? colours.shadow : Colors.transparent,
          clipBehavior: .antiAlias,
          child: InkWell(
            focusNode: _focus,
            onTap: widget.onTap,
            borderRadius: _raidus,
            child: Padding(
              padding: const EdgeInsets.all(_padding),
              child: Column(
                mainAxisSize: .min,
                spacing: 4,
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
                          data: IconThemeData(color: foreground),
                          child: widget.child,
                        ),
                      ),
                    ),
                  ),
                  Text(widget.label, style: theme.textTheme.labelMedium?.copyWith(color: labelForeground)),
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
  static const _radiusVal = 10.0;
  static const _raidus = BorderRadius.all(Radius.circular(_radiusVal));
  static const _outerRadius = BorderRadius.all(Radius.circular(_radiusVal + _borderWidth));
  static const _innerRadius = BorderRadius.all(Radius.circular(_radiusVal - _padding));
}
