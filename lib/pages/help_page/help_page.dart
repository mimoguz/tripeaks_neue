import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/pages/help_page/tripeaks_tab.dart';
import 'package:tripeaks_neue/pages/help_page/ui_tab.dart';
import 'package:tripeaks_neue/pages/help_page/about_tab.dart';
import 'package:tripeaks_neue/util/overlay_style.dart';
import 'package:tripeaks_neue/util/theme_ext.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_vertical_tab_view.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  late final FocusNode _focusNode;

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
    final s = context.strings;
    final useVertical = MediaQuery.sizeOf(context).height < c.verticalTabsThreshold;
    final background = context.colours.pageBackground;
    setOverlayStyleOf(context);
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.keyQ, control: true): const ExitIntent(),
        SingleActivator(LogicalKeyboardKey.escape): const GoBackIntent(),
        SingleActivator(LogicalKeyboardKey.backspace): const GoBackIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{ExitIntent: ExitAction(), GoBackIntent: GoBackAction()},
        child: SafeArea(
          top: false,
          bottom: false,
          child: DefaultTabController(
            initialIndex: 0,
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text(s.infoPageTitle),
                backgroundColor: background,
                surfaceTintColor: background,
                bottom: useVertical
                    ? null
                    : TabBar(
                        tabAlignment: TabAlignment.center,
                        dividerColor: Colors.transparent,
                        // TODO: Strings
                        tabs: <Widget>[
                          Tab(text: "Tri Peaks"),
                          Tab(text: "Interaction"),
                          Tab(text: "About"),
                        ],
                      ),
              ),
              body: Focus(
                focusNode: _focusNode,
                autofocus: true,
                skipTraversal: true,
                descendantsAreFocusable: true,
                descendantsAreTraversable: true,
                child: useVertical
                    ? MyVerticalTabView(
                        width: 180,
                        tabs: <Tab>[
                          Tab(text: "Tri Peaks"),
                          Tab(text: "Interaction"),
                          Tab(text: "About"),
                        ],
                        contents: <Widget>[TriPeaksTab(), UiTab(), AboutTab()],
                      )
                    : TabBarView(children: <Widget>[TriPeaksTab(), UiTab(), AboutTab()]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
