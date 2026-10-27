import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_dialog.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';

class const DecorSetting({super.key}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<Settings>(context);
    final s = context.strings;
    final colours = context.colours;
    return Observer(
      builder: (context) {
        return SettingTile(
          titleText: s.decorControl,
          location: Location.last,
          onTap: () => _showSelection(context, settings),
          subtitle: settings.decor.label(s),
          showArrow: true,
          trailing: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: ClipOval(
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
    final s = context.strings;
    final result = await showCommonBottomSheet<int>(
      context,
      (context) => MyBottomSheet(
        title: Text(s.decorTitle, overflow: .fade, softWrap: false, maxLines: 1),
        content: Padding(
          padding: c.DialogMetrics.contentPadding,
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              for (final (index, decor) in Decor.values.indexed)
                DecorItem(
                  decor: decor,
                  isSelected: settings.decor == decor,
                  selectedDecorColour: settings.decorColour,
                  strings: s,
                  onTap: () => Navigator.pop(context, index),
                ),
            ],
          ),
        ),
      ),
    );
    if (result != null && result >= 0) {
      settings.decor = Decor.values[result];
    }
  }

  static const _boxWidth = 32.0;
  static const _boxHeight = 32.0;
  static const _iconOffset = Offset((c.cardSize - _boxWidth) / -2.0, (c.cardSize - _boxHeight) / -2.0);
}

class const DecorItem({
  super.key,
  required final Decor decor,
  required final bool isSelected,
  required final DecorColour selectedDecorColour,
  required final AppLocalizations strings,
  final VoidCallback? onTap,
}) extends StatefulWidget {
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
    final colours = context.colours;
    _borderColour = _focus.hasFocus ? colours.primary : Colors.transparent;
    return Tooltip(
      message: widget.decor.label(widget.strings),
      child: SizedBox(
        width: _sideLength,
        height: _sideLength,
        child: Material(
          color: Colors.transparent,
          borderRadius: c.commonBorderRadius,
          clipBehavior: .antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            focusNode: _focus,
            child: Ink(
              decoration: BoxDecoration(
                border: Border.all(width: 4.0, color: _borderColour!),
                borderRadius: c.commonBorderRadius,
                color: widget.isSelected ? widget.selectedDecorColour.background : colours.secondaryContainer,
              ),

              child: ClipRRect(
                borderRadius: c.commonBorderRadius.subtract(BorderRadiusGeometry.circular(4.0)),
                child: Icon(
                  widget.decor.icon,
                  size: _sideLength - 8,
                  color: widget.isSelected
                      ? widget.selectedDecorColour.controlForeground
                      : colours.onSecondaryContainer,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onFocusChange() {
    setState(() {
      _borderColour = _focus.hasFocus ? context.colours.onSurface : context.colours.surfaceContainer;
    });
  }
}

const _scale = 0.8;
const _sideLength = c.cardSize * _scale;
