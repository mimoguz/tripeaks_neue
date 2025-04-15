import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/l10n/app_localizations.dart';
import 'package:tripeaks_neue/pages/info_page/about_tab.dart';
import 'package:tripeaks_neue/pages/info_page/howto_tab.dart';
import 'package:tripeaks_neue/src/version.dart';
import 'package:tripeaks_neue/widgets/constants.dart' as c;
import 'package:tripeaks_neue/widgets/my_vertical_tab_view.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
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
    final s = AppLocalizations.of(context)!;
    final useVertical = MediaQuery.sizeOf(context).height < c.verticalTabsThreshold;
    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        SingleActivator(LogicalKeyboardKey.keyQ, control: true): const ExitIntent(),
        SingleActivator(LogicalKeyboardKey.escape): const GoBackIntent(),
        SingleActivator(LogicalKeyboardKey.backspace): const GoBackIntent(),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{ExitIntent: ExitAction(), GoBackIntent: GoBackAction()},
        child: SafeArea(
          child: DefaultTabController(
            initialIndex: 0,
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                title: Text(s.infoPageTitle),
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerLow,
                bottom:
                    useVertical
                        ? null
                        : TabBar(
                          tabAlignment: TabAlignment.center,
                          dividerColor: Colors.transparent,
                          tabs: <Widget>[Tab(text: s.howToPlayTabTitle), Tab(text: s.aboutTabTitle)],
                        ),
              ),
              body: Focus(
                focusNode: _focusNode,
                autofocus: true,
                skipTraversal: true,
                descendantsAreFocusable: true,
                descendantsAreTraversable: true,
                child:
                    useVertical
                        ? MyVerticalTabView(
                          width: 180,
                          tabs: <Tab>[Tab(text: s.howToPlayTabTitle), Tab(text: s.aboutTabTitle)],
                          contents: <Widget>[HowtoTab(), AboutTab()],
                        )
                        : TabBarView(children: <Widget>[HowtoTab(), AboutTab()]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
