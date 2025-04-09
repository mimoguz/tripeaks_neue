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
  String get itsKnotDecorLabel => 'It\'s Knot';

  @override
  String get neueDecorLabel => 'NEUE';

  @override
  String get solarDecorLabel => 'Solar';

  @override
  String get decorColourControl => 'Card back colour';

  @override
  String get redColourLabel => 'Red';

  @override
  String get orangeColourLabel => 'Orange';

  @override
  String get amberColourLabel => 'Amber';

  @override
  String get greenColourLabel => 'Green';

  @override
  String get cyanColourLabel => 'Cyan';

  @override
  String get blueColourLabel => 'Blue';

  @override
  String get violetColourLabel => 'Violet';

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

  @override
  String get wikiLinkAlt => 'Tri Peaks on Wikipedia';

  @override
  String get wikiLinkText => 'Wikipedia article';

  @override
  String get howToP01 => 'In a standard Tri Peaks patience (solitaire) game, 28 cards are arranged on the board in the shape of three peaks: 18 cards face-down and 10 cards face-up. The remaining  cards form the stock. At the start, the topmost card from the stock is placed on the discard pile.';

  @override
  String get howToRichP02 => 'The objective is to clear all the peaks by removing cards one by one and placing them on the discard pile. _A card may be removed from the board only if it is face-up and adjacent to the top card of the discard pile, irrespective of its suit._';

  @override
  String get howToRichP03 => 'The player can move in any direction, forming sequences such as _Ace → 2 → 3 → 2 → Ace → King → Queen → King_. As demonstrated in the example, sequences can loop, so movement from Ace to King or from King to Ace is possible.';

  @override
  String get howToP04 => 'When a face-down card is no longer blocked by other cards, it is flipped face-up.';

  @override
  String get howToP05 => 'If there are no cards on the board that are adjacent to the card on top of the discard pile (or at any time), the player can draw a card from the stock.';

  @override
  String get howToP06 => 'The game ends when the board is cleared or no more moves are possible.';

  @override
  String get howToP07 => 'In addition to the standard game, this app offers:';

  @override
  String get howToP08 => 'Three additional board layouts,';

  @override
  String get howToP09 => 'An option to show the values of face-down cards,';

  @override
  String get howToP10 => 'An option to start with an empty discard pile, allowing the player to choose any starting card.';

  @override
  String get interactionP01 => 'To remove a card from the board, just tap on it. If it is a valid move, the card will be moved on top of the discard pile; otherwise, it will wobble momentarily.';

  @override
  String get interactionRichP02 => 'This is the draw button. Pressing this, _or swiping up on an otherwise non-actionable part (except the very edges) of the game screen_  will draw a card from the stock and place it on top of the discard pile.';

  @override
  String get interactionP03 => 'This is the undo button. Pressing this will roll back the last move. This can go back to the very beginning of the game.';

  @override
  String get interactionP04 => 'Between the board and the stock, you will see the card counter. Thick lines on the bottom or left show the remaining cards. The circles show the current chain.';

  @override
  String get interactionP05 => 'This is the menu button.';

  @override
  String get interactionP06 => 'From the menu, different game modes can be selected by visiting the settings page,';

  @override
  String get interactionP07 => 'or by using \"New Game with Layout...\" option.';

  @override
  String get interactionP08 => 'When a game ends, you will see an \"ending card\". They are not modal dialogs, and they don\'t block interaction with the other parts of the interface.';

  @override
  String get interactionP09 => 'The game supports both portrait and landscape orientations.';

  @override
  String get interactionP10 => 'Other Shorcuts';

  @override
  String get interactionP12 => 'Back';

  @override
  String get interactionP13 => 'Back (alternative)';

  @override
  String get shortcutTitle => 'Shortcut: ';

  @override
  String get scoringRichP01 => 'Removing cards from the board one after the other creates a _chain_.';

  @override
  String get scoringP02 => 'A chain ends when the player draws a card from the stock, or when the game ends. Using undo will only decrease the current chain\'s length, it will not end it. ';

  @override
  String get scoringRichP03 => 'When a chain ends, the player gains a score equal to the _square_ of that chain\'s length: 1 point for one card, 4 points for two cards, 9 points for three cards, and so on.';

  @override
  String get scoringRichP04 => 'When the board is cleared, the player gains a bonus score equal to the _number of cards on the board at the start of the game_. ';

  @override
  String get scoringP05 => 'While clearing the board is the goal, you can easily get a higher score by creating long chains, even if you can\'t clear it. Play any way you want.';
}
