import 'package:tripeaks_neue/pages/home_page/home_page.dart';
import 'package:tripeaks_neue/pages/menu_page/menu_page.dart';
import 'package:tripeaks_neue/pages/settings_page/settings_page.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/util/navigation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'intents.dart';

final class TakeAction extends Action<TakeIntent> {
  TakeAction(this.game);

  final Game game;

  @override
  void invoke(TakeIntent intent) {
    game.take(intent.pin);
  }
}

final class DrawAction extends Action<DrawIntent> {
  DrawAction(this.game);

  final Game game;

  @override
  bool get isActionEnabled => game.stock.isNotEmpty && !game.isEnded;

  @override
  void invoke(DrawIntent intent) {
    game.draw();
  }
}

final class RollbackAction extends Action<RollbackIntent> {
  RollbackAction(this.game);

  final Game game;

  @override
  bool get isActionEnabled => game.history.isNotEmpty && !game.isCleared;

  @override
  void invoke(RollbackIntent intent) {
    game.rollback();
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
    session.newGame();
  }
}

final class NavigateToMenuAction extends ContextAction<NavigateToMenuIntent> {
  @override
  void invoke(NavigateToMenuIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final navigator = Navigator.of(context);
    if (intent.replace) {
      navigator.pushReplacement(createRoute(() => MenuPage()));
    } else {
      _closeDrawer(context);
      navigator.push(createRoute(() => MenuPage()));
    }
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
      navigator.pushReplacement(createRoute(() => HomePage()));
    } else {
      _closeDrawer(context);
      navigator.push(createRoute(() => HomePage()));
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
      navigator.pushReplacement(createRoute(() => SettingsPage()));
    } else {
      _closeDrawer(context);
      navigator.push(createRoute(() => SettingsPage()));
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

void _closeDrawer(BuildContext context) {
  final scaffold = Scaffold.of(context);
  if (scaffold.isDrawerOpen) {
    scaffold.closeDrawer();
  }
}
