import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:tripeaks_neue/pages/home_page/home_page.dart';
import 'package:tripeaks_neue/pages/info_page/info_page.dart';
import 'package:tripeaks_neue/pages/settings_page/settings_page.dart';
import 'package:tripeaks_neue/pages/statistics_page/statistics_page.dart';
import 'package:tripeaks_neue/stores/data/player_statistics.dart';
import 'package:tripeaks_neue/stores/game.dart';
import 'package:tripeaks_neue/stores/session.dart';
import 'package:tripeaks_neue/stores/settings.dart';
import 'package:tripeaks_neue/stores/sound_effects.dart';
import 'package:tripeaks_neue/util/export_result.dart';
import 'package:tripeaks_neue/util/import_result.dart';
import 'package:tripeaks_neue/widgets/common_dialog.dart';
import 'package:tripeaks_neue/widgets/select_layout_dialog.dart';
import 'package:tripeaks_neue/util/get_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'package:tripeaks_neue/util/local_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.js_util) 'package:tripeaks_neue/util/web_io.dart';

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
    if (kIsWeb || kIsWasm) {
      return;
    }
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

final class SetDecorColourAction extends ContextAction<SetDecorColourIntent> {
  @override
  void invoke(SetDecorColourIntent intent, [BuildContext? context]) {
    if (context == null) {
      return;
    }
    final settings = Provider.of<Settings>(context, listen: false);
    settings.decorColour = intent.value;
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
      navigator.pop();
      if (intent.saveSettings) {
        final settings = Provider.of<Settings>(context, listen: false);
        settings.write();
      }
    }
  }
}

final class ImportStatsAction extends ContextAction<ImportStatsIntent> {
  @override
  void invoke(ImportStatsIntent intent, [BuildContext? context]) async {
    if (context == null) {
      return;
    }
    final result = await getIO().import<PlayerStatistics>(_reader);
    switch (result) {
      case ImportCancelled<PlayerStatistics?> _:
        _logger.d("Import cancelled");
        break;
      // TODO: Error dialog
      case ImportIoFailed<PlayerStatistics> ioFailed:
        _logger.e("Import I/O failed: ${ioFailed.reason}");
        break;
      // TODO: Error dialog
      case ImportReaderFailed<PlayerStatistics> readerFailed:
        _logger.e("Import reader failed: ${readerFailed.reason}");
        break;
      case ImportSucceeded<PlayerStatistics> succeded:
        if (context.mounted) {
          final dialogResult = await showAdaptiveDialog<bool>(
            context: context,
            barrierColor: Colors.transparent,
            barrierDismissible: true,
            builder: (context) => CommonDialog(
              title: Text("Caution"),
              content: Text("This action will overwrite the current statistics.\nDo you want to continue?"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop<bool>(context, false),
                  style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
                  child: Text("Cancel"),
                ),
                TextButton(onPressed: () => Navigator.pop<bool>(context, true), child: Text("Continue")),
              ],
            ),
          );
          if (!(dialogResult ?? false)) {
            break;
          }
        } else {
          _logger.e("Import: Can't use context");
        }
        if (context.mounted) {
          await Provider.of<Session>(context, listen: false).setStatistics(succeded.result);
        } else {
          _logger.e("Import: Can't use context");
        }
        break;
    }
  }

  PlayerStatistics _reader(Map<String, dynamic> jsonObject) => PlayerStatistics.fromJsonObject(jsonObject);

  final Logger _logger = Logger();
}

final class ExportStatsAction extends ContextAction<ExportStatsIntent> {
  @override
  void invoke(ExportStatsIntent intent, [BuildContext? context]) async {
    if (context == null) {
      return;
    }
    final session = Provider.of<Session>(context, listen: false);
    final jsonObject = session.statistics.toJsonObject();
    final result = await getIO().export(
      context: context,
      jsonObject: jsonObject,
      suggestedName: _suggestedFileName,
    );
    switch (result) {
      case ExportCancelled _:
        _logger.d("Export cancelled");
        break;
      case ExportFailed failed:
        // TODO: Error dialog
        _logger.e("Export failed: ${failed.reason}");
        break;
      case ExportSucceeded succeeded:
        _logger.d("Export succeded: ${succeeded.path}");
        break;
    }
  }

  final Logger _logger = Logger();
  static const _suggestedFileName = 'tripeaksneue-data.json';
}

// TODO: strings
final class ClearStatsAction extends ContextAction<ClearStatsIntent> {
  @override
  void invoke(ClearStatsIntent intent, [BuildContext? context]) async {
    if (context == null) {
      return;
    }
    if (context.mounted) {
      final dialogResult = await showAdaptiveDialog<bool>(
        context: context,
        barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (context) => CommonDialog(
          title: Text("Caution"),
          content: Text("This action will clear the current statistics.\nDo you want to continue?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop<bool>(context, false),
              style: TextButton.styleFrom(foregroundColor: Theme.of(context).colorScheme.error),
              child: Text("Cancel"),
            ),
            TextButton(onPressed: () => Navigator.pop<bool>(context, true), child: Text("Continue")),
          ],
        ),
      );
      if (!(dialogResult ?? false)) {
        return;
      }
    } else {
      _logger.e("Import: Can't use context");
    }

    if (context.mounted) {
      await Provider.of<Session>(context, listen: false).setStatistics(PlayerStatistics.empty());
    } else {
      _logger.e("Import: Can't use context");
    }
  }

  final Logger _logger = Logger();
}
