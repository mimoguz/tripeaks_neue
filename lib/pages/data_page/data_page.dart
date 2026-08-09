import 'package:flutter/material.dart';
import 'package:tripeaks_neue/pages/data_page/export_box.dart';
import 'package:tripeaks_neue/pages/data_page/import_box.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/expandable_box.dart';

class DataPage extends StatefulWidget {
  const DataPage({super.key});

  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {
  late final FocusNode _focusNode;
  int _expandIndex = -1;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colours = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: Text("Export/Import"),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      body: Focus(
        focusNode: _focusNode,
        autofocus: true,
        skipTraversal: true,
        descendantsAreFocusable: true,
        descendantsAreTraversable: true,
        child: Container(
          color: colours.surfaceContainerLow,
          child: Padding(
            padding: const EdgeInsets.all(c.utilPageMargin),
            child: Column(
              spacing: c.utilPageMargin,
              children: [
                ExpandableBox(
                  expanded: _expandIndex == 0,
                  onTap: () => _expand(0),
                  title: Text("Export Data"),
                  icon: Icon(Icons.upload, color: colours.onSurfaceVariant),
                  child: Flexible(child: ExportBox()),
                ),
                ExpandableBox(
                  expanded: _expandIndex == 1,
                  onTap: () => _expand(1),
                  title: Text("Import Data"),
                  icon: Icon(Icons.download, color: colours.onSurfaceVariant),
                  child: Flexible(child: ImportBox()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _expand(int index) => setState(() => _expandIndex = _expandIndex == index ? -1 : index);
}
