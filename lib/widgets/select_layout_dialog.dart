import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/list_tile.dart';

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
    final settings = Provider.of<Settings>(context);
    final s = AppLocalizations.of(context)!;
    final colours = Theme.of(context).colorScheme;

    _showAll ??= session.showAll;
    _startEmpty ??= session.startEmpty;
    _layout ??= session.layout;

    return AlertDialog.adaptive(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      content: ClipRRect(
        borderRadius: c.commonBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
          child: Material(
            color: colours.surfaceContainer.withAlpha(200),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.0),
                        Text(s.selectLayoutDialogTitle, style: Theme.of(context).textTheme.titleSmall),
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
                        Text(s.additionalOptionsGroupTitle, style: Theme.of(context).textTheme.titleSmall),
                        MyListTile(
                          leading: Checkbox(
                            value: _showAll,
                            visualDensity: VisualDensity.compact,
                            onChanged: (value) => setState(() => _showAll = value!),
                          ),
                          title: Text(s.showAllOptionLabel),
                          onTap: () => setState(() => _showAll = !_showAll!),
                        ),
                        MyListTile(
                          leading: Checkbox(
                            value: _startEmpty,
                            visualDensity: VisualDensity.compact,
                            onChanged: (value) => setState(() => _startEmpty = value!),
                          ),
                          title: Text(s.startsEmptyOptionLabel),
                          onTap: () => setState(() => _startEmpty = !_startEmpty!),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 12.0,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                        child: Text(s.selectDialogCancelAction),
                      ),
                      TextButton(
                        onPressed: () {
                          session.showAll = _showAll!;
                          session.startEmpty = _startEmpty!;
                          session.layout = _layout!;
                          session.newGame(settings.sounds.playStart);
                          Navigator.pop(context);
                        },
                        child: Text(s.selectLayoutDialogNewGameAction),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _valueLabel(Peaks value, AppLocalizations s) => switch (value) {
    Peaks.threePeaks => s.threePeaksLayoutLabel,
    Peaks.diamonds => s.diamondsLayoutLabel,
    Peaks.valley => s.valleyLayoutLabel,
    Peaks.upDown => s.upDownLayoutLabel,
  };
}
