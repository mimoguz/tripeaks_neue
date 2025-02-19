import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/widgets/list_item.dart';

class SelectLayoutDialog extends StatefulWidget {
  const SelectLayoutDialog({super.key});

  @override
  State<SelectLayoutDialog> createState() => _SelectLayoutDialogState();
}

class _SelectLayoutDialogState extends State<SelectLayoutDialog> {
  bool? _showAll = false;
  bool? _startEmpty = false;
  Peaks? _layout = Peaks.threePeaks;

  @override
  initState() {
    super.initState();
    _showAll = null;
    _startEmpty = null;
    _layout = null;
  }

  @override
  void activate() {
    super.activate();
    _showAll = null;
    _startEmpty = null;
    _layout = null;
  }

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = AppLocalizations.of(context)!;

    _showAll ??= session.showAll;
    _startEmpty ??= session.startEmpty;
    _layout ??= session.layout;

    return AlertDialog.adaptive(
      title: Text(s.selectLayoutDialogTitle),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final layout in Peaks.values)
              MyListTile(
                leading: Radio<Peaks>(
                  value: layout,
                  groupValue: _layout,
                  visualDensity: VisualDensity.compact,
                  onChanged: (value) => setState(() => _layout = value!),
                ),
                title: Text(_valueLabel(layout, s)),
                onTap: () => setState(() => _layout = layout),
              ),
            const Divider(),
            const SizedBox(height: 8.0),
            Text(s.additionalOptions, style: Theme.of(context).textTheme.titleSmall),
            MyListTile(
              leading: Checkbox(
                value: _showAll,
                visualDensity: VisualDensity.compact,
                onChanged: (value) => setState(() => _showAll = value!),
              ),
              title: Text(s.showAllCheckboxLabel),
              onTap: () => setState(() => _showAll = !_showAll!),
            ),
            MyListTile(
              leading: Checkbox(
                value: _startEmpty,
                visualDensity: VisualDensity.compact,
                onChanged: (value) => setState(() => _startEmpty = value!),
              ),
              title: Text(s.startsEmptyCheckboxLabel),
              onTap: () => setState(() => _startEmpty = !_startEmpty!),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
          child: Text(s.cancelButtonLabel),
        ),
        TextButton(
          onPressed: () {
            session.showAll = _showAll!;
            session.startEmpty = _startEmpty!;
            session.layout = _layout!;
            session.newGame();
            Navigator.pop(context);
          },
          child: Text(s.newGameButtonLabel),
        ),
      ],
    );
  }

  String _valueLabel(Peaks value, AppLocalizations s) => switch (value) {
    Peaks.threePeaks => s.threePeaksLayoutLabel,
    Peaks.diamonds => s.diamondsLayoutLabel,
    Peaks.valley => s.valleyLayoutLabel,
    Peaks.upDown => s.upDownLayoutLabel,
  };
}
