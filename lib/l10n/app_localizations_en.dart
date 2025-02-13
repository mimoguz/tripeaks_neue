// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get newGameAction => 'New Game';

  @override
  String get newGameWithLayoutAction => 'New Game with Layout...';

  @override
  String get restartGameAction => 'Restart Current Game';

  @override
  String get statisticsAction => 'Statistics';

  @override
  String get exitAction => 'Exit';

  @override
  String get returnAction => 'Return to Game';

  @override
  String get drawTooltip => 'Draw';

  @override
  String get undoTooltip => 'Undo';

  @override
  String get menuTooltip => 'Menu';

  @override
  String get settingsTooltip => 'Settings';

  @override
  String get infoTooltip => 'Help & About';

  @override
  String get homeTooltip => 'Return to Game';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get multiStateSwitchDefaultLabel => 'Multi-state switch';

  @override
  String get themeModeControl => 'Theme Mode';
}
