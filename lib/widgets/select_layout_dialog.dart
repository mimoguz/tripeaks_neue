import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/assets/custom_icons.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/list_tile.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

class SelectLayoutDialog extends StatefulWidget {
  const SelectLayoutDialog({super.key});

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
    final s = AppLocalizations.of(context)!;

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
          for (final layout in Peaks.values)
            MyListTile(
              trailing: Radio<Peaks>(
                value: layout,
                groupValue: _layout,
                visualDensity: VisualDensity.compact,
                onChanged: (value) => setState(() => _layout = value!),
              ),
              title: Text(layout.label(s)),
              onTap: () => setState(() => _layout = layout),
              padding: _choicePadding,
              rightSpacing: 16,
            ),
          //const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: c.cellPadding * 2),
            child: Text(s.additionalOptionsGroupTitle, style: Theme.of(context).textTheme.titleSmall),
          ),
          MyListTile(
            trailing: Checkbox(
              value: _showAll,
              visualDensity: VisualDensity.compact,
              onChanged: (value) => setState(() => _showAll = value!),
            ),
            title: Text(s.showAllOptionLabel),
            onTap: () => setState(() => _showAll = !_showAll!),
            padding: _choicePadding,
            rightSpacing: 16,
          ),
          MyListTile(
            trailing: Checkbox(
              value: _startEmpty,
              visualDensity: VisualDensity.compact,
              onChanged: (value) => setState(() => _startEmpty = value!),
            ),
            title: Text(s.startsEmptyOptionLabel),
            onTap: () => setState(() => _startEmpty = !_startEmpty!),
            padding: _choicePadding,
            rightSpacing: 16,
          ),
          MyListTile(
            trailing: Checkbox(
              value: _ensureSolvable,
              visualDensity: VisualDensity.compact,
              onChanged: (value) => setState(() => _ensureSolvable = value!),
            ),
            title: Text(s.ensureSolvableOnLabel),
            onTap: () => setState(() => _ensureSolvable = !_ensureSolvable!),
            padding: _choicePadding,
            rightSpacing: 16,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
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

  static const _choicePadding = EdgeInsets.fromLTRB(10, c.cellPadding, 0, c.cellPadding);
}
