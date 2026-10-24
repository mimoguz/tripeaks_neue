import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/stores/data/decor.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/common_popover.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/setting_tile.dart';
import 'package:tripeaks_neue/widgets/wrapping_popover.dart';

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
          onTap: (context) => _showSelection(context, settings),
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
    final result = await showCommonPopover<Decor>(
      context,
      semanticsLabel: context.strings.decorControl,
      width: 352,
      (context) => WrappingPopover(
        width: 352,
        values: Decor.values,
        selected: settings.decor,
        itemBuilder: (v, s) => DecorItem(
          decor: v,
          isSelected: v == settings.decor,
          selectedDecorColour: settings.decorColour,
          onTap: () => Navigator.pop(context, v),
        ),
      ),
    );
    if (result != null) {
      settings.decor = result;
    }
  }

  static const _boxWidth = 32.0;
  static const _boxHeight = 32.0;
  static const _iconOffset = Offset((c.cardSize - _boxWidth) / -2.0, (c.cardSize - _boxHeight) / -2.0);
}

class DecorItem extends StatefulWidget {
  const DecorItem({
    super.key,
    required this.decor,
    this.onTap,
    required this.isSelected,
    required this.selectedDecorColour,
  });

  final Decor decor;
  final bool isSelected;
  final VoidCallback? onTap;
  final DecorColour selectedDecorColour;

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
    _borderColour = _focus.hasFocus ? colours.primary : colours.surfaceBright;
    final s = context.strings;
    return Tooltip(
      message: widget.decor.label(s),
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
                border: Border.all(width: 2.0, color: _borderColour!),
                borderRadius: c.commonBorderRadius,
                color: widget.isSelected
                    ? widget.selectedDecorColour.background
                    : colours.surfaceContainerHighest,
              ),

              child: ClipRRect(
                borderRadius: c.commonBorderRadius.subtract(BorderRadiusGeometry.circular(2.0)),
                child: Icon(
                  widget.decor.icon,
                  size: _sideLength - 4,
                  color: widget.isSelected ? Colors.white70 : colours.onSurfaceVariant,
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
