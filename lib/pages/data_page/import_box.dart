import 'package:flutter/material.dart';
import 'package:tripeaks_neue/widgets/list_tile.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;

// TODO: Strings, remember state
class ImportBox extends StatefulWidget {
  const ImportBox({super.key});

  @override
  State<ImportBox> createState() => _ImportBoxState();
}

class _ImportBoxState extends State<ImportBox> with AutomaticKeepAliveClientMixin<ImportBox> {
  bool _includeStatistics = true;
  bool _includeSettings = true;
  bool _includeGame = true;

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: c.cardPaddingHorizontal,
        vertical: c.cardPaddingVertical,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: .start,
            children: [
              Text(
                "Caution: this will replace the original data.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontStyle: .italic),
              ),
            ],
          ),
          SizedBox(height: 16),
          MyListTile(
            title: Text("Include statistics"),
            onTap: () => setState(() => _includeStatistics = !_includeStatistics),
            leading: Checkbox(
              value: _includeStatistics,
              onChanged: (v) => setState(() => _includeStatistics = v ?? _includeStatistics),
            ),
          ),
          MyListTile(
            title: Text("Include settings"),
            onTap: () => setState(() => _includeSettings = !_includeSettings),
            leading: Checkbox(
              value: _includeSettings,
              onChanged: (v) => setState(() => _includeSettings = v ?? _includeSettings),
            ),
          ),
          MyListTile(
            title: Text("Include the current game"),
            onTap: () => setState(() => _includeGame = !_includeGame),
            leading: Checkbox(
              value: _includeGame,
              onChanged: (v) => setState(() => _includeGame = v ?? _includeGame),
            ),
          ),
          Spacer(),
          Row(
            mainAxisAlignment: .end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: 200),
                child: TextButton(onPressed: () {}, child: Text("Select file to import...")),
              ),
            ],
          ),
          SizedBox(height: c.utilPageMargin),

          SizedBox(height: c.cardPaddingVertical),
        ],
      ),
    );
  }
}
