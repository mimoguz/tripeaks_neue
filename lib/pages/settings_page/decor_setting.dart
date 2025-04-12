import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/setting_tile.dart';
import 'package:tripeaks_neue/widgets/translucent_dialog.dart';

class DecorSetting extends StatelessWidget {
  const DecorSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = AppLocalizations.of(context)!;
    final colours = Theme.of(context).colorScheme;
    return Observer(
      builder: (context) {
        return SettingTile(
          title: s.decorControl,
          location: Location.last,
          onTap: () => _showSelection(context, settings),
          subtitle: settings.decor.name(s),
          showArrow: true,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: c.commonBorderRadius,
              child: Container(
                width: _boxWidth,
                height: _boxHeight,
                color: colours.surfaceContainerHighest,
                child: Transform.translate(
                  offset: _iconOffset,
                  child: Icon(settings.decor.icon, size: 116, color: colours.onSurfaceVariant),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSelection(BuildContext context, Settings settings) async {
    final s = AppLocalizations.of(context)!;
    final result = await showDialog(
      context: context,
      barrierColor: Colors.transparent,
      builder:
          (context) => TranslucentDialog(
            title: Text(s.decorControl),
            content: Wrap(
              spacing: 16.0,
              runSpacing: 16.0,
              children: [
                for (final (index, decor) in Decor.values.indexed)
                  DecorItem(
                    decor: decor,
                    isSelected: settings.decor == decor,
                    onTap: () => Navigator.pop(context, index),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, -1),
                style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                child: Text(s.cancelAction),
              ),
            ],
          ),
    );
    if (result >= 0) {
      settings.decor = Decor.values[result];
    }
  }

  static const _boxWidth = 64.0;
  static const _boxHeight = 24.0;
  static const _iconOffset = Offset((c.cardSize - _boxWidth) / -2.0, (c.cardSize - _boxHeight) / -2.0);
}

class DecorItem extends StatefulWidget {
  const DecorItem({super.key, required this.decor, this.onTap, required this.isSelected});

  final Decor decor;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  State<DecorItem> createState() => _DecorItemState();
}

class _DecorItemState extends State<DecorItem> {
  final FocusNode _focus = FocusNode();
  Color? _borderColour;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    _borderColour = _focus.hasFocus ? colours.onSurface : colours.surfaceContainer;
    return SizedBox(
      width: _sideLength,
      height: _sideLength,
      child: Material(
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.onTap,
          focusNode: _focus,
          child: Ink(
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: _borderColour!),
              color: widget.isSelected ? colours.primary : colours.surfaceContainer,
            ),
            child: Icon(
              widget.decor.icon,
              size: _sideLength - 4,
              color: widget.isSelected ? colours.inversePrimary : colours.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }

  void _onFocusChange() {
    setState(() {
      _borderColour =
          _focus.hasFocus
              ? Theme.of(context).colorScheme.onSurface
              : Theme.of(context).colorScheme.surfaceContainer;
    });
  }

  static const _scale = 0.75;
  static const _borderRadius = BorderRadius.all(Radius.circular(c.commonRadius * _scale));
  static const _sideLength = c.cardSize * _scale;
}
