import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/platform_utils.dart' show isDesktopOrWeb;
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_dialog.dart';
import 'package:tripeaks_neue/widgets/my_selection_tiles.dart';

class const SelectLayoutDialog({super.key}) extends StatefulWidget {
  @override
  State<SelectLayoutDialog> createState() => _SelectLayoutDialogState();
}

class _SelectLayoutDialogState extends State<SelectLayoutDialog> {
  bool? _showAll = false;
  bool? _startEmpty = false;
  bool? _ensureSolvable = false;
  Peaks? _layout = Peaks.threePeaks;

  @override
  void initState() {
    super.initState();
    _showAll = null;
    _startEmpty = null;
    _ensureSolvable = null;
    _layout = null;
  }

  @override
  void activate() {
    super.activate();
    _showAll = null;
    _startEmpty = null;
    _ensureSolvable = null;
    _layout = null;
  }

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final settings = Provider.of<Settings>(context);
    final s = context.strings;
    final theme = context.theme;

    _showAll ??= session.showAll;
    _startEmpty ??= session.startEmpty;
    _ensureSolvable ??= session.ensureSolvable;
    _layout ??= session.layout;

    return MyDialog(
      title: Text(s.selectLayoutDialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final layout in Peaks.values)
            MyRadioListTile<Peaks>(
              value: layout,
              label: Text(layout.label(s)),
              isChecked: layout == _layout,
              onTap: (v) => setState(() {
                _layout = v;
              }),
            ),

          Padding(
            padding: c.DialogMetrics.subtitlePadding,
            child: Column(
              spacing: c.DialogMetrics.sectionSpacing,
              crossAxisAlignment: .start,
              children: [
                DialogDivider(),
                Text(s.additionalOptionsGroupTitle, style: theme.textTheme.titleMedium),
              ],
            ),
          ),

          MyCheckBoxListTile(
            isChecked: _showAll ?? false,
            label: Text(s.showAllOptionLabel),
            onTap: () => setState(() => _showAll = !(_showAll ?? false)),
          ),

          MyCheckBoxListTile(
            isChecked: _startEmpty ?? false,
            label: Text(s.startsEmptyOptionLabel, softWrap: false),
            onTap: () => setState(() => _startEmpty = !(_startEmpty ?? false)),
          ),

          MyCheckBoxListTile(
            isChecked: _ensureSolvable ?? false,
            label: Text(s.ensureSolvableOnLabel),
            onTap: () => setState(() => _ensureSolvable = !(_ensureSolvable ?? false)),
          ),
        ],
      ),
      actions: <Widget>[
        FilledButton(
          style: FilledButton.styleFrom(shadowColor: Colors.transparent),
          onPressed: () {
            session.showAll = _showAll!;
            session.startEmpty = _startEmpty!;
            session.ensureSolvable = _ensureSolvable!;
            session.layout = _layout!;
            if (kIsWeb || kIsWasm) {
              session.write();
            }
            session.newGame(settings.sounds.playStart);
            Navigator.pop(context);
          },
          child: Text(s.selectLayoutDialogNewGameAction),
        ),
      ],
    );
  }
}
