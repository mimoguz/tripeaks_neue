import 'package:flutter/material.dart';
import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/widgets/list_tile.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/scroll_indicator.dart';

// TODO: Strings, remember state
class ImportTab extends StatefulWidget {
  const ImportTab({super.key});

  @override
  State<ImportTab> createState() => _ImportTabState();
}

class _ImportTabState extends State<ImportTab> with AutomaticKeepAliveClientMixin<ImportTab> {
  bool _includeStatistics = true;
  bool _includeSettings = true;
  bool _includeGame = true;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final colours = Theme.of(context).colorScheme;
    return Actions(
      actions: <Type, Action<Intent>>{ImportDataIntent: ImportDataAction()},
      child: Builder(
        builder: (context) {
          return Container(
            color: colours.surfaceContainerLow,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: .min,
              children: [
                Flexible(
                  child: ScrollIndicator(
                    child: ListView(
                      padding: c.utilPageInsets,
                      children: <Widget>[
                        MyListTile(
                          title: Text(
                            "Caution: this will replace the original data.",
                            style: TextStyle(fontStyle: .italic, color: colours.tertiary),
                          ),
                        ),
                        MyListTile(
                          title: Text("Include statistics"),
                          padding: _listItemPadding,
                          onTap: () => setState(() => _includeStatistics = !_includeStatistics),
                          trailing: Checkbox(
                            value: _includeStatistics,
                            onChanged: (v) => setState(() => _includeStatistics = v ?? _includeStatistics),
                          ),
                        ),
                        MyListTile(
                          title: Text("Include settings"),
                          padding: _listItemPadding,
                          onTap: () => setState(() => _includeSettings = !_includeSettings),
                          trailing: Checkbox(
                            value: _includeSettings,
                            onChanged: (v) => setState(() => _includeSettings = v ?? _includeSettings),
                          ),
                        ),
                        MyListTile(
                          title: Text("Include the current game"),
                          padding: _listItemPadding,
                          onTap: () => setState(() => _includeGame = !_includeGame),
                          trailing: Checkbox(
                            value: _includeGame,
                            onChanged: (v) => setState(() => _includeGame = v ?? _includeGame),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: .center,
                          mainAxisSize: .min,
                          children: [
                            ConstrainedBox(
                              constraints: BoxConstraints(minWidth: 200),
                              child: TextButton(
                                onPressed: Actions.handler(
                                  context,
                                  ImportDataIntent(
                                    includeStats: _includeStatistics,
                                    includeSettings: _includeSettings,
                                    includeCurrentGame: _includeGame,
                                  ),
                                ),
                                child: Text("Select file to import..."),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  static const _listItemPadding = EdgeInsets.fromLTRB(10, c.cellPadding, 0, c.cellPadding);
}
