import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/pages/home_page/home_page.dart';
import 'package:tripeaks_neue/pages/info_page/info_page.dart';
import 'package:tripeaks_neue/pages/settings_page/settings_page.dart';
import 'package:tripeaks_neue/pages/statistics_page/statistics_page.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/stores/sound_effects.dart';
import 'package:tripeaks_neue/widgets/select_layout_dialog.dart';

import 'intents.dart';

final class TakeAction extends Action<TakeIntent> {
  TakeAction(this.game, this.sounds);

  final Game game;
  final SoundEffects sounds;

  @override
  void invoke(TakeIntent intent) {
    final took = game.take(intent.pin);
    if (took) {
      if (game.isCleared) {
        sounds.playWin();
      } else if (game.isStalled) {
        sounds.playGameOver();
      } else {
        sounds.playTake(game.chain);
      }
    } else {
      sounds.playError();
    }
  }
}

final class DrawAction extends Action<DrawIntent> {
  DrawAction(this.game, this.sounds);

  final Game game;
  final SoundEffects sounds;

  @override
  bool get isActionEnabled => game.stock.isNotEmpty && !game.isEnded;

  @override
  void invoke(DrawIntent intent) {
    game.draw();
    if (game.isStalled) {
      sounds.playGameOver();
    } else {
      sounds.playDraw();
    }
  }
}

final class RollbackAction extends Action<RollbackIntent> {
  RollbackAction(this.game, this.sounds);

  final Game game;
  final SoundEffects sounds;

  @override
  bool get isActionEnabled => game.history.isNotEmpty && !game.isCleared;

  @override
  void invoke(RollbackIntent intent) {
    game.rollback();
    sounds.playRollback();
  }
}

final class NewGameAction extends ContextAction<NewGameIntent> {
  NewGameAction();

  @override
  void invoke(NewGameIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    _closeDrawer(context);
    final session = Provider.of<Session>(context, listen: false);
    final settings = Provider.of<Settings>(context, listen: false);
    session.newGame(settings.sounds.playStart);
  }
}

final class RestartAction extends ContextAction<RestartIntent> {
  RestartAction();

  @override
  void invoke(RestartIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    _closeDrawer(context);
    final session = Provider.of<Session>(context, listen: false);
    final settings = Provider.of<Settings>(context, listen: false);
    session.restart(settings.sounds.playStart);
  }
}

final class NavigateToHomeAction extends ContextAction<NavigateToHomeIntent> {
  @override
  void invoke(NavigateToHomeIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final navigator = Navigator.of(context);
    if (intent.replace) {
      navigator.pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    } else {
      _closeDrawer(context);
      navigator.push(MaterialPageRoute(builder: (_) => HomePage()));
    }
  }
}

final class NavigateToSettingsAction extends ContextAction<NavigateToSettingsIntent> {
  @override
  void invoke(NavigateToSettingsIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final navigator = Navigator.of(context);
    if (intent.replace) {
      navigator.pushReplacement(MaterialPageRoute(builder: (_) => SettingsPage()));
    } else {
      _closeDrawer(context);
      navigator.push(MaterialPageRoute(builder: (_) => SettingsPage()));
    }
  }
}

final class NavigateToStatisticsAction extends ContextAction<NavigateToStatisticsIntent> {
  @override
  void invoke(NavigateToStatisticsIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final navigator = Navigator.of(context);
    if (intent.replace) {
      navigator.pushReplacement(MaterialPageRoute(builder: (_) => StatisticsPage()));
    } else {
      _closeDrawer(context);
      navigator.push(MaterialPageRoute(builder: (_) => StatisticsPage()));
    }
  }
}

final class NavigateToInfoAction extends ContextAction<NavigateToInfoIntent> {
  @override
  void invoke(NavigateToInfoIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final navigator = Navigator.of(context);
    if (intent.replace) {
      navigator.pushReplacement(MaterialPageRoute(builder: (_) => InfoPage()));
    } else {
      _closeDrawer(context);
      navigator.push(MaterialPageRoute(builder: (_) => InfoPage()));
    }
  }
}

final class NewGameWithLayoutAction extends ContextAction<NewGameWithLayoutIntent> {
  @override
  void invoke(NewGameWithLayoutIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    _closeDrawer(context);
    showAdaptiveDialog(
      context: context,
      builder: (_) => SelectLayoutDialog(),
      barrierDismissible: true,
      barrierColor: Colors.transparent,
    );
  }
}

final class ExitAction extends ContextAction<ExitIntent> {
  @override
  Future<void> invoke(ExitIntent intent, [BuildContext? context]) async {
    final session = Provider.of<Session>(context!, listen: false);
    final settings = Provider.of<Settings>(context, listen: false);
    await session.write();
    await settings.write();
    if (Platform.isIOS || Platform.isWindows) {
      exit(0);
    } else {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    }
  }
}

final class SetThemeModeAction extends ContextAction<SetThemeModeIntent> {
  @override
  void invoke(SetThemeModeIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final settings = Provider.of<Settings>(context, listen: false);
    settings.themeMode = intent.mode;
  }
}

final class SetShowAllAction extends ContextAction<SetShowAllIntent> {
  @override
  void invoke(SetShowAllIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final session = Provider.of<Session>(context, listen: false);
    session.showAll = intent.value;
  }
}

final class SetStartEmptyAction extends ContextAction<SetStartEmptyIntent> {
  @override
  void invoke(SetStartEmptyIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final session = Provider.of<Session>(context, listen: false);
    session.startEmpty = intent.value;
  }
}

final class SetDecorAction extends ContextAction<SetDecorIntent> {
  @override
  void invoke(SetDecorIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final settings = Provider.of<Settings>(context, listen: false);
    settings.decor = intent.value;
  }
}

final class SetSoundModeAction extends ContextAction<SetSoundModeIntent> {
  @override
  void invoke(SetSoundModeIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final settings = Provider.of<Settings>(context, listen: false);
    settings.setSoundOn(intent.value);
  }
}

final class SetLayoutAction extends ContextAction<SetLayoutIntent> {
  @override
  void invoke(SetLayoutIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final session = Provider.of<Session>(context, listen: false);
    session.layout = intent.value;
  }
}

void _closeDrawer(BuildContext context) {
  final scaffold = Scaffold.of(context);
  if (scaffold.isDrawerOpen) {
    scaffold.closeDrawer();
  }
}

final class ShowNavigationDrawerAction extends ContextAction<ShowNavigationDrawerIntent> {
  @override
  void invoke(ShowNavigationDrawerIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final scaffold = Scaffold.of(context);
    if (scaffold.isDrawerOpen) {
      scaffold.closeDrawer();
    } else {
      scaffold.openDrawer();
    }
  }
}

final class GoBackAction extends ContextAction<GoBackIntent> {
  @override
  void invoke(GoBackIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      Navigator.of(context).pop();
    }
  }
}
