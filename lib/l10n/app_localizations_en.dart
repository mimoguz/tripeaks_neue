// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get drawTooltip => 'Draw';

  @override
  String get undoTooltip => 'Undo';

  @override
  String get menuTooltip => 'Menu';

  @override
  String get clearedCardMessage => 'Cleared!';

  @override
  String get clearedCardNewGameAction => 'New game';

  @override
  String stalledCardMessage(Object SCORE) {
    return 'Unfortunately, you ran out of moves.\nYour score so far: $SCORE.\nHow do you want to proceed?';
  }

  @override
  String get stalledCardNewGameAction => 'New game';

  @override
  String get stalledCardRollbackAction => 'Undo last move';

  @override
  String get soundOnToolTip => 'Sound is on';

  @override
  String get soundOffToolTip => 'Sound is off';

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
  String get settingsTooltip => 'Settings';

  @override
  String get infoTooltip => 'How to & About';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get interfaceSettingGroupTitle => 'Interface';

  @override
  String get nextGameSettingGroupTitle => 'Next Game';

  @override
  String get showAllControl => 'Values of closed cards';

  @override
  String get showAllOffLabel => 'Hidden';

  @override
  String get showAllOnLabel => 'Visible';

  @override
  String get startEmptyControl => 'Discard pile at start';

  @override
  String get startEmptyOffLabel => 'Has one card';

  @override
  String get startEmptyOnLabel => 'Empty';

  @override
  String get themeModeControl => 'Theme mode';

  @override
  String get systemThemeModeLabel => 'System';

  @override
  String get lightThemeModeLabel => 'Light';

  @override
  String get darkThemeModeLabel => 'Dark';

  @override
  String get layoutControl => 'Board layout';

  @override
  String get threePeaksLayoutLabel => 'Three peaks';

  @override
  String get diamondsLayoutLabel => 'Diamonds';

  @override
  String get valleyLayoutLabel => 'Valley';

  @override
  String get upDownLayoutLabel => 'Opposing directions';

  @override
  String get theatreLayoutLabel => 'Theatre';

  @override
  String get soundControl => 'Sound';

  @override
  String get soundOnLabel => 'On';

  @override
  String get soundMutedLabel => 'Off';

  @override
  String get decorControl => 'Card back decoration';

  @override
  String get checkeredDecorLabel => 'Checkered';

  @override
  String get ennuiDecorLabel => 'Ennui';

  @override
  String get dotMatrixDecorLabel => 'Dot Matrix';

  @override
  String get itsKnotDecorLabel => 'Hanky';

  @override
  String get neueDecorLabel => 'NEUE';

  @override
  String get solarDecorLabel => 'Solar';

  @override
  String get selectLayoutDialogTitle => 'Select Layout';

  @override
  String get additionalOptionsGroupTitle => 'Additional Options';

  @override
  String get startsEmptyOptionLabel => 'Start with an empty discard pile';

  @override
  String get showAllOptionLabel => 'Show values of closed cards';

  @override
  String get selectDialogCancelAction => 'Cancel';

  @override
  String get selectLayoutDialogNewGameAction => 'New game';

  @override
  String get welcomeDialogTitle => 'Welcome to TriPeaks NEUE';

  @override
  String get welcomeDialogMessage => 'Would you like to...';

  @override
  String get welcomeDialogToInfoPageAction => 'Learn how to play this game';

  @override
  String get welcomeDialogToSettingsPageAction => 'Check avalible customizations';

  @override
  String get welcomeDialogCloseAction => 'Just play';

  @override
  String get statisticsPageTitle => 'Player Statistics';

  @override
  String get overallStatisticsTitle => 'Overall';

  @override
  String get lastGameStatistics => 'Last Game';

  @override
  String get bestGamesStatistics => 'Highest-Scoring Games';

  @override
  String get gameClearedLabel => 'Cleared';

  @override
  String get gameNotClearedLabel => 'Not cleared';

  @override
  String get statisticsSummary => 'Summary';

  @override
  String get totalPlayedLabel => 'Total played';

  @override
  String get totalClearedLabel => 'Total cleared';

  @override
  String get bestScoreLabel => 'Highest score';

  @override
  String get longestChainLabel => 'Longest chain';

  @override
  String get infoPageTitle => 'How to & About';

  @override
  String get howToPlayTabTitle => 'How to Play';

  @override
  String get aboutTabTitle => 'About the Game';

  @override
  String get showLicenseAction => 'Show License';

  @override
  String get directDependencyLabel => 'Direct';

  @override
  String get indirectDependencyLabel => 'Indirect';

  @override
  String get licenseDialogCloseAction => 'Close';
}
