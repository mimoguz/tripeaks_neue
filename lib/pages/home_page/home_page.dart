import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/actions/actions.dart';
import 'package:tripeaks_neue/actions/intents.dart';
import 'package:tripeaks_neue/pages/home_page/landscape_home_page.dart';
import 'package:tripeaks_neue/pages/home_page/portrait_home_page.dart';
import 'package:tripeaks_neue/pages/home_page/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/stores/settings.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Shortcuts(
        shortcuts: <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.keyD): const DrawIntent(),
          SingleActivator(LogicalKeyboardKey.keyZ, control: true): const RollbackIntent(),
          SingleActivator(LogicalKeyboardKey.keyQ, control: true): const ExitIntent(),
          SingleActivator(LogicalKeyboardKey.keyM): const ShowNavigationDrawerIntent(),
          SingleActivator(LogicalKeyboardKey.escape): const GoBackIntent(),
          SingleActivator(LogicalKeyboardKey.backspace): const GoBackIntent(),
          SingleActivator(LogicalKeyboardKey.period, control: true): const NavigateToSettingsIntent(),
          SingleActivator(LogicalKeyboardKey.f1): const NavigateToInfoIntent(),
        },
        child: Actions(
          actions: <Type, Action<Intent>>{
            NewGameIntent: NewGameAction(),
            NavigateToSettingsIntent: NavigateToSettingsAction(),
            NavigateToStatisticsIntent: NavigateToStatisticsAction(),
            NavigateToInfoIntent: NavigateToInfoAction(),
            NewGameWithLayoutIntent: NewGameWithLayoutAction(),
            RestartIntent: RestartAction(),
            ExitIntent: ExitAction(),
            ShowNavigationDrawerIntent: ShowNavigationDrawerAction(),
            GoBackIntent: GoBackAction(),
          },
          child: Builder(
            builder: (context) {
              return PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) async {
                  _onPopInvokedWithResult(context, didPop, result);
                },
                child: Scaffold(
                  drawerScrimColor: Colors.transparent,
                  drawer: HomePageDrawer(),
                  body: Builder(
                    builder: (context) {
                      return size.width > size.height ? const LandscapeHomePage() : const PortraitHomePage();
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _onPopInvokedWithResult(BuildContext context, bool didPop, dynamic result) async {
    if (kIsWeb || kIsWasm) {
      return;
    }
    if (didPop) {
      return;
    }
    if (context.mounted) {
      final session = Provider.of<Session>(context, listen: false);
      await session.write();
      await session.writeStatistics();
    }
    if (context.mounted) {
      final settings = Provider.of<Settings>(context, listen: false);
      await settings.write();
    }
    if (Platform.isIOS || Platform.isWindows) {
      exit(0);
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }
}
