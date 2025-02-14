import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';

class MultiStateSwitch extends StatelessWidget {
  const MultiStateSwitch({
    super.key,
    required this.selected,
    required this.onChange,
    required this.optionIcons,
    this.sectionHeight = 28.0,
    this.sectionWidth = 48.0,
    this.spacing = 4.0,
    this.semanticLabel,
  });

  final int selected;
  final void Function(int) onChange;
  final List<Widget> optionIcons;
  final double sectionHeight;
  final double sectionWidth;
  final double spacing;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    final s = AppLocalizations.of(context)!;

    return Semantics(
      label: semanticLabel ?? s.multiStateSwitchDefaultLabel,
      child: SizedBox(
        width: sectionWidth * optionIcons.length + spacing * max(0, optionIcons.length - 1) + _padding * 2,
        height: sectionHeight + _padding * 2,
        child: Material(
          borderRadius: _roundedBorder,
          color: colours.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.all(_padding),
            child: Stack(
              children: [
                AnimatedPositioned(
                  left: selected * (sectionWidth + spacing),
                  duration: Durations.short3,
                  child: SizedBox(
                    width: sectionWidth,
                    height: sectionHeight,
                    child: Ink(
                      decoration: BoxDecoration(color: colours.primary, borderRadius: _roundedBorder),
                    ),
                  ),
                ),
                Row(
                  spacing: spacing,
                  children: [
                    for (final (index, icon) in optionIcons.indexed)
                      SizedBox(
                        width: sectionWidth,
                        height: sectionHeight,
                        child: InkWell(
                          borderRadius: _roundedBorder,
                          onTap: index != selected ? () => onChange(index) : null,
                          child: IconTheme(
                            data: IconThemeData(
                              color: selected == index ? colours.onPrimary : colours.onSurfaceVariant,
                            ),
                            child: Center(child: icon),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const _roundedBorder = BorderRadius.all(Radius.circular(100.0));

  static const _padding = 2.0;
}
