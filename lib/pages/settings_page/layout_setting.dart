import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/selection_dialog.dart';
import 'package:tripeaks_neue/widgets/setting_tile.dart';

class LayoutSetting extends StatelessWidget {
  const LayoutSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<Session>(context);
    final s = context.strings;
    return Observer(
      builder: (context) {
        return SettingTile(
          title: s.layoutControl,
          location: Location.first,
          onTap: () => _showSelection(context, session),
          subtitle: session.layout.label(s),
          showArrow: true,
        );
      },
    );
  }

  Future<void> _showSelection(BuildContext context, Session session) async {
    final s = context.strings;
    final result = await showDialog<int>(
      context: context,
      barrierColor: Colors.transparent,
      barrierDismissible: true,
      builder: (context) => SelectionDialog(
        title: s.layoutControl,
        selected: session.layout.index,
        options: Peaks.values.map((e) => e.label(s)).toList(),
      ),
    );
    if (result != null && result >= 0) {
      session.layout = Peaks.values[result];
    }
  }
}
