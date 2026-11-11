import 'package:material_ui/material_ui.dart';
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
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final colours = theme.colorScheme;
    final colourExt = theme.extension<MyColourThemeExt>()!;
    final (cardBackground, frameForeground, labelColour, borderColour) = isSelected
        ? (
            selectedBackground ?? background ?? colours.primaryContainer,
            selectedForeground ?? foreground ?? colours.onPrimaryContainer,
            selectedForeground ?? colours.onPrimaryContainer,
            selectedBackground ?? colours.primary,
          )
        : (
            background ?? colours.surfaceContainer,
            foreground ?? colours.onSurfaceVariant,
            colours.onSurface,
            Colors.transparent,
          );
    return TapRegion(
      onTapInside: (_) => onTap(),
      child: Material(
        type: .transparency,
        child: Column(
          mainAxisSize: .min,
          spacing: 2,
          children: [
            InkWell(
              onTap: onTap,
              borderRadius: _selectionRadius,
              child: Ink(
                decoration: BoxDecoration(
                  border: Border.all(color: borderColour, width: _borderWidth),
                  borderRadius: _selectionRadius,
                ),
                child: Padding(
                  padding: _borderPadding,
                  child: SizedBox(
                    width: frameWidth,
                    height: frameHeight,
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
                            child: child,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Text(label, style: theme.textTheme.labelMedium),
          ],
        ),
      ),
    );
  }

  static const _borderWidth = 2.0;
  static const _borderPaddingVal = 3.0;
  static const _radiusVal = 12.0;
  static const _borderPadding = EdgeInsets.all(_borderPaddingVal);
  static const _raidus = BorderRadius.all(Radius.circular(_radiusVal));
  static const _selectionRadius = BorderRadius.all(
    Radius.circular(_radiusVal + _borderPaddingVal + _borderWidth),
  );
}
