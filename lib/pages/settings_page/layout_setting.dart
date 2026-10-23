import 'package:material_ui/material_ui.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/stores/data/layout.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/util/common_popover.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/radio_popover.dart';
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
          titleText: s.layoutControl,
          location: Location.first,
          onTap: () => _showSelection(context, session),
          subtitle: session.layout.label(s),
          showArrow: true,
        );
      },
    );
  }

  Future<void> _showSelection(BuildContext context, Session session) async {
    final result = await showCommonPopover<Peaks>(
      context,
      (context) => RadioPopover<Peaks>(
        values: Peaks.values,
        selected: session.layout,
        itemBuilder: (v, s) => Text(v.label(s)),
      ),
    );
    if (result != null) {
      session.layout = result;
    }
  }
}
