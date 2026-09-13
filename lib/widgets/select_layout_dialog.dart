import 'package:material_ui/material_ui.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

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

    return CommonDialog(
      title: Text(s.selectLayoutDialogTitle),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTileTheme(
            data: ListTileThemeData(
              visualDensity: .compact,
              titleTextStyle: theme.textTheme.bodyMedium,
              controlAffinity: .leading,
              horizontalTitleGap: c.itemSpacing,
              contentPadding: EdgeInsets.fromLTRB(c.itemSpacing - c.radioCorrection, 0.0, c.itemSpacing, 0.0),
            ),
            child: RadioGroup(
              groupValue: _layout,
              onChanged: (value) => setState(() {
                _layout = value;
              }),
              child: Column(
                children: [
                  for (final layout in Peaks.values)
                    RadioListTile<Peaks>(value: layout, title: Text(layout.label(s))),
                ],
              ),
            ),
          ),
          const Divider(),
          ListTileTheme(
            data: ListTileThemeData(
              visualDensity: .compact,
              titleTextStyle: theme.textTheme.bodyMedium,
              controlAffinity: .leading,
              horizontalTitleGap: c.itemSpacing - c.checkBoxCorrection,
              contentPadding: EdgeInsets.fromLTRB(
                c.itemSpacing - c.checkBoxCorrection,
                0.0,
                c.itemSpacing,
                0.0,
              ),
            ),
            child: Column(
              children: [
                ListTile(
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Transform.translate(
                      offset: const Offset(c.checkBoxCorrection - c.radioCorrection, 0.0),
                      child: Text(s.additionalOptionsGroupTitle, style: theme.textTheme.titleSmall),
                    ),
                  ),
                ),
                CheckboxListTile(
                  value: _showAll,
                  onChanged: (value) => setState(() => _showAll = value!),
                  title: Text(s.showAllOptionLabel),
                ),
                CheckboxListTile(
                  value: _startEmpty,
                  onChanged: (value) => setState(() => _startEmpty = value!),
                  title: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(s.startsEmptyOptionLabel, softWrap: false),
                  ),
                ),
                CheckboxListTile(
                  value: _ensureSolvable,
                  onChanged: (value) => setState(() => _ensureSolvable = value!),
                  title: Text(s.ensureSolvableOnLabel),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: theme.colorScheme.error),
          child: Text(s.selectDialogCancelAction),
        ),
        TextButton(
          onPressed: () {
            session.showAll = _showAll!;
            session.startEmpty = _startEmpty!;
            session.ensureSolvable = _ensureSolvable!;
            session.layout = _layout!;
            session.newGame(settings.sounds.playStart);
            Navigator.pop(context);
          },
          child: Text(s.selectLayoutDialogNewGameAction),
        ),
      ],
    );
  }
}
