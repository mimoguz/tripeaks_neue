import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';

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
      content: ListTileTheme(
        data: ListTileThemeData(
          visualDensity: .compact,
          titleTextStyle: Theme.of(context).textTheme.bodyMedium,
          controlAffinity: .leading,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioGroup(
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
            const Divider(),
            ListTile(
              title: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(s.additionalOptionsGroupTitle, style: Theme.of(context).textTheme.titleSmall),
              ),
            ),
            Column(
              children: [
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
          ],
        ),
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
}
