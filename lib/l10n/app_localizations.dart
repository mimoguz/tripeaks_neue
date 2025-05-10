import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en')
  ];

  /// Label of a control that cancels the current action.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelAction;

  /// Tooltip of a control that draws a card from the stock.
  ///
  /// In en, this message translates to:
  /// **'Draw'**
  String get drawTooltip;

  /// Tooltip of a control that undoes the last action.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undoTooltip;

  /// Tooltip of a control that opens the game drawer.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menuTooltip;

  /// Card message
  ///
  /// In en, this message translates to:
  /// **'Cleared!'**
  String get clearedCardMessage;

  /// Label of a control that starts a new game.
  ///
  /// In en, this message translates to:
  /// **'New game'**
  String get clearedCardNewGameAction;

  /// Card message
  ///
  /// In en, this message translates to:
  /// **'Unfortunately, you ran out of moves.\nYour score so far: {SCORE}.\nHow do you want to proceed?'**
  String stalledCardMessage(Object SCORE);

  /// Label of a control that starts a new game.
  ///
  /// In en, this message translates to:
  /// **'New game'**
  String get stalledCardNewGameAction;

  /// Label of a control that undoes the last action.
  ///
  /// In en, this message translates to:
  /// **'Undo last move'**
  String get stalledCardRollbackAction;

  /// Tool tip for sound toggle when sound is on.
  ///
  /// In en, this message translates to:
  /// **'Sound is on'**
  String get soundOnToolTip;

  /// Tool tip for sound toggle when sound is off.
  ///
  /// In en, this message translates to:
  /// **'Sound is off'**
  String get soundOffToolTip;

  /// Label of a control that starts a new game.
  ///
  /// In en, this message translates to:
  /// **'New Game'**
  String get newGameAction;

  /// Label of a control that shows layout options then starts a new game.
  ///
  /// In en, this message translates to:
  /// **'New Game with Layout...'**
  String get newGameWithLayoutAction;

  /// Label of a control that restarts the current game.
  ///
  /// In en, this message translates to:
  /// **'Restart Current Game'**
  String get restartGameAction;

  /// Label of a control that navigates to the 'Statistics' page.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statisticsAction;

  /// Label of a control that exits the application.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exitAction;

  /// Tooltip of a control that navigates to the 'Settings' page.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// Tooltip of a control that navigates to the info page.
  ///
  /// In en, this message translates to:
  /// **'How to & About'**
  String get infoTooltip;

  /// Title of the 'Settings' page.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Title of the settings group that contains ui related settings.
  ///
  /// In en, this message translates to:
  /// **'Interface'**
  String get interfaceSettingGroupTitle;

  /// Title of the settings group that contains settings which will be used starting from next new game.
  ///
  /// In en, this message translates to:
  /// **'Next Game'**
  String get nextGameSettingGroupTitle;

  /// Label of a control that sets if the values of closed cards should be shown.
  ///
  /// In en, this message translates to:
  /// **'Show values of closed cards'**
  String get showAllControl;

  /// Value label of showAll control when it is off.
  ///
  /// In en, this message translates to:
  /// **'Hidden'**
  String get showAllOffLabel;

  /// Value label of showAll control when it is on.
  ///
  /// In en, this message translates to:
  /// **'Visible'**
  String get showAllOnLabel;

  /// Label of a control that sets if the discard pile should be empty at the beginning of the game.
  ///
  /// In en, this message translates to:
  /// **'Start with an empty discard pile'**
  String get startEmptyControl;

  /// Value label of startEmpty control when it is off.
  ///
  /// In en, this message translates to:
  /// **'Start with one card'**
  String get startEmptyOffLabel;

  /// Value label of startEmpty control when it is on.
  ///
  /// In en, this message translates to:
  /// **'Start empty'**
  String get startEmptyOnLabel;

  /// Label of a control that sets if the discard pile should be empty at the beginning of the game.
  ///
  /// In en, this message translates to:
  /// **'Use solvable game algorithm'**
  String get ensureSolvableControl;

  /// Value label of ensureSolvable control when it is off.
  ///
  /// In en, this message translates to:
  /// **'Create a random game'**
  String get ensureSolvableOffLabel;

  /// Value label of ensureSolvable control when it is on.
  ///
  /// In en, this message translates to:
  /// **'Ensure the game is solvable'**
  String get ensureSolvableOnLabel;

  /// Label of a control that sets application theme mode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get themeModeControl;

  /// Value label of themeMode control when it is set to system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemThemeModeLabel;

  /// Value label of themeMode control when it is set to light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightThemeModeLabel;

  /// Value label of themeMode control when it is set to dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkThemeModeLabel;

  /// Label of a control that sets game layout theme mode.
  ///
  /// In en, this message translates to:
  /// **'Board layout'**
  String get layoutControl;

  /// Value label of layout selection control when it is set to 'threePeaks'.
  ///
  /// In en, this message translates to:
  /// **'Three Peaks'**
  String get threePeaksLayoutLabel;

  /// Value label of layout selection control when it is set to 'diamonds'.
  ///
  /// In en, this message translates to:
  /// **'Diamonds'**
  String get diamondsLayoutLabel;

  /// Value label of layout selection control when it is set to 'valley'.
  ///
  /// In en, this message translates to:
  /// **'Valley'**
  String get valleyLayoutLabel;

  /// Value label of layout selection control when it is set to 'upDown'.
  ///
  /// In en, this message translates to:
  /// **'Opposing directions'**
  String get upDownLayoutLabel;

  /// Value label of layout selection control when it is set to 'theatre'.
  ///
  /// In en, this message translates to:
  /// **'Theatre'**
  String get theatreLayoutLabel;

  /// Label of a control that sets sound mode.
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get soundControl;

  /// Value label of sound control when it is set to on.
  ///
  /// In en, this message translates to:
  /// **'On'**
  String get soundOnLabel;

  /// Value label of sound control when it is set to off.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get soundMutedLabel;

  /// Label of a control that sets the decoration that is used on the back of the cards.
  ///
  /// In en, this message translates to:
  /// **'Card back decoration'**
  String get decorControl;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'Checkered'**
  String get checkeredDecorLabel;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'.love'**
  String get dotLoveDecorLabel;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'Ennui'**
  String get ennuiDecorLabel;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'Dot Matrix'**
  String get dotMatrixDecorLabel;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'It\'s Knot'**
  String get itsKnotDecorLabel;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'NEUE'**
  String get neueDecorLabel;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'Solar'**
  String get solarDecorLabel;

  /// Label of a control that sets the colour that is used on the back of the cards.
  ///
  /// In en, this message translates to:
  /// **'Card back colour'**
  String get decorColourControl;

  /// Label of a decoration colour variant.
  ///
  /// In en, this message translates to:
  /// **'Red'**
  String get redColourLabel;

  /// Label of a decoration colour variant.
  ///
  /// In en, this message translates to:
  /// **'Orange'**
  String get orangeColourLabel;

  /// Label of a decoration colour variant.
  ///
  /// In en, this message translates to:
  /// **'Amber'**
  String get amberColourLabel;

  /// Label of a decoration colour variant.
  ///
  /// In en, this message translates to:
  /// **'Green'**
  String get greenColourLabel;

  /// Label of a decoration colour variant.
  ///
  /// In en, this message translates to:
  /// **'Cyan'**
  String get cyanColourLabel;

  /// Label of a decoration colour variant.
  ///
  /// In en, this message translates to:
  /// **'Blue'**
  String get blueColourLabel;

  /// Label of a decoration colour variant.
  ///
  /// In en, this message translates to:
  /// **'Violet'**
  String get violetColourLabel;

  /// Title of the dialog that will open when 'New Game with Layout...' action is called.
  ///
  /// In en, this message translates to:
  /// **'Select Layout'**
  String get selectLayoutDialogTitle;

  /// Title of the additional options section of the dialog.
  ///
  /// In en, this message translates to:
  /// **'Additional Options'**
  String get additionalOptionsGroupTitle;

  /// Label of the checkbox that sets if the discard pile should be empty at the beginning of the game.
  ///
  /// In en, this message translates to:
  /// **'Start with an empty discard pile'**
  String get startsEmptyOptionLabel;

  /// Label of the checkbox that sets if the values of closed cards should be shown.
  ///
  /// In en, this message translates to:
  /// **'Show values of closed cards'**
  String get showAllOptionLabel;

  /// Label of the cancel button of the dialog.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get selectDialogCancelAction;

  /// Label of the new game button of the dialog.
  ///
  /// In en, this message translates to:
  /// **'New game'**
  String get selectLayoutDialogNewGameAction;

  /// Title of the welcome dialog.
  ///
  /// In en, this message translates to:
  /// **'Welcome to TriPeaks NEUE'**
  String get welcomeDialogTitle;

  /// Welcome dialog body.
  ///
  /// In en, this message translates to:
  /// **'Would you like to...'**
  String get welcomeDialogMessage;

  /// Label of a button that navigates to the info page.
  ///
  /// In en, this message translates to:
  /// **'Learn how to play this game'**
  String get welcomeDialogToInfoPageAction;

  /// Label of a button that navigates to the settings page.
  ///
  /// In en, this message translates to:
  /// **'Check avalible customizations'**
  String get welcomeDialogToSettingsPageAction;

  /// Label of a button that closes the welcome dialog.
  ///
  /// In en, this message translates to:
  /// **'Just play'**
  String get welcomeDialogCloseAction;

  /// Title of the 'Player Statistics' page.
  ///
  /// In en, this message translates to:
  /// **'Player Statistics'**
  String get statisticsPageTitle;

  /// Title of the general statistics tab.
  ///
  /// In en, this message translates to:
  /// **'Overall'**
  String get overallStatisticsTitle;

  /// Title of the last game statistics group.
  ///
  /// In en, this message translates to:
  /// **'Last Game'**
  String get lastGameStatistics;

  /// Title of the best games statistics group.
  ///
  /// In en, this message translates to:
  /// **'Highest-Scoring Games'**
  String get bestGamesStatistics;

  /// Value label for the game result chip if the game was cleared.
  ///
  /// In en, this message translates to:
  /// **'Cleared'**
  String get gameClearedLabel;

  /// Value label for the game result chip if the game wasn't cleared.
  ///
  /// In en, this message translates to:
  /// **'Not cleared'**
  String get gameNotClearedLabel;

  /// Title of the general statistics group (overal & per each layout).
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get statisticsSummary;

  /// Label of the total games played statistic.
  ///
  /// In en, this message translates to:
  /// **'Total played'**
  String get totalPlayedLabel;

  /// Label of the total games cleared statistic.
  ///
  /// In en, this message translates to:
  /// **'Total cleared'**
  String get totalClearedLabel;

  /// Label of the best score statistic.
  ///
  /// In en, this message translates to:
  /// **'Highest score'**
  String get bestScoreLabel;

  /// Label of the longest chain statistic.
  ///
  /// In en, this message translates to:
  /// **'Longest chain'**
  String get longestChainLabel;

  /// Info page title.
  ///
  /// In en, this message translates to:
  /// **'How to & About'**
  String get infoPageTitle;

  /// 'How to play' tab title.
  ///
  /// In en, this message translates to:
  /// **'How to Play'**
  String get howToPlayTabTitle;

  /// 'About' tab title.
  ///
  /// In en, this message translates to:
  /// **'About the Game'**
  String get aboutTabTitle;

  /// Label of a button that displays the license of a dependency.
  ///
  /// In en, this message translates to:
  /// **'Show License'**
  String get showLicenseAction;

  /// If the dependency is direct.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get directDependencyLabel;

  /// If the dependency is a dependency of a direct dependency.
  ///
  /// In en, this message translates to:
  /// **'Indirect'**
  String get indirectDependencyLabel;

  /// Label of a button that closes the license dialog.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get licenseDialogCloseAction;

  /// Alt text for Wikipedia link.
  ///
  /// In en, this message translates to:
  /// **'Tri Peaks on Wikipedia'**
  String get wikiLinkAlt;

  /// Text for Wikipedia link.
  ///
  /// In en, this message translates to:
  /// **'Wikipedia article'**
  String get wikiLinkText;

  /// How to play text.
  ///
  /// In en, this message translates to:
  /// **'In a standard Tri Peaks patience (solitaire) game, 28 cards are arranged on the board in the shape of three peaks: 18 cards face-down and 10 cards face-up. The remaining  cards form the stock. At the start, the topmost card from the stock is placed on the discard pile.'**
  String get howToP01;

  /// How to play text, contains formatting.
  ///
  /// In en, this message translates to:
  /// **'The objective is to clear all the peaks by removing cards one by one and placing them on the discard pile. _A card may be removed from the board only if it is face-up and adjacent to the top card of the discard pile, irrespective of its suit._'**
  String get howToRichP02;

  /// How to play text.
  ///
  /// In en, this message translates to:
  /// **'The player can move in any direction, forming sequences such as _Ace → 2 → 3 → 2 → Ace → King → Queen → King_. As demonstrated in the example, sequences can loop, so movement from Ace to King or from King to Ace is possible.'**
  String get howToRichP03;

  /// How to play text.
  ///
  /// In en, this message translates to:
  /// **'When a face-down card is no longer blocked by other cards, it is flipped face-up.'**
  String get howToP04;

  /// How to play text.
  ///
  /// In en, this message translates to:
  /// **'If there are no cards on the board that are adjacent to the card on top of the discard pile (or at any time), the player can draw a card from the stock.'**
  String get howToP05;

  /// How to play text.
  ///
  /// In en, this message translates to:
  /// **'The game ends when the board is cleared or no more moves are possible.'**
  String get howToP06;

  /// How to play text.
  ///
  /// In en, this message translates to:
  /// **'In addition to the standard game, this app offers:'**
  String get howToP07;

  /// How to play text.
  ///
  /// In en, this message translates to:
  /// **'Three additional board layouts,'**
  String get howToP08;

  /// How to play text.
  ///
  /// In en, this message translates to:
  /// **'An option to show the values of face-down cards,'**
  String get howToP09;

  /// How to play text.
  ///
  /// In en, this message translates to:
  /// **'An option to start with an empty discard pile, allowing the player to choose any starting card.'**
  String get howToP10;

  /// UI & interaction text.
  ///
  /// In en, this message translates to:
  /// **'To remove a card from the board, just tap on it. If it is a valid move, the card will be moved on top of the discard pile; otherwise, it will wobble momentarily.'**
  String get interactionP01;

  /// UI & interaction text.
  ///
  /// In en, this message translates to:
  /// **'This is the draw button. Pressing this, _or swiping up on an otherwise non-actionable part (except the very edges) of the game screen_  will draw a card from the stock and place it on top of the discard pile.'**
  String get interactionRichP02;

  /// UI & interaction text.
  ///
  /// In en, this message translates to:
  /// **'This is the undo button. Pressing this will roll back the last move. This can go back to the very beginning of the game.'**
  String get interactionP03;

  /// UI & interaction text.
  ///
  /// In en, this message translates to:
  /// **'Between the board and the stock, you will see the card counter. Thick lines on the bottom or left show the remaining cards. The circles show the current chain.'**
  String get interactionP04;

  /// UI & interaction text.
  ///
  /// In en, this message translates to:
  /// **'This is the menu button.'**
  String get interactionP05;

  /// UI & interaction text.
  ///
  /// In en, this message translates to:
  /// **'From the menu, different game modes can be selected by visiting the settings page,'**
  String get interactionP06;

  /// UI & interaction text.
  ///
  /// In en, this message translates to:
  /// **'or by using \"New Game with Layout...\" option.'**
  String get interactionP07;

  /// UI & interaction text.
  ///
  /// In en, this message translates to:
  /// **'When a game ends, you will see an \"ending card\". They are not modal dialogs, and they don\'t block interaction with the other parts of the interface.'**
  String get interactionP08;

  /// UI & interaction text.
  ///
  /// In en, this message translates to:
  /// **'The game supports both portrait and landscape orientations.'**
  String get interactionP09;

  /// UI & interaction text.
  ///
  /// In en, this message translates to:
  /// **'Other Shorcuts'**
  String get interactionP10;

  /// UI & interaction text.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get interactionP12;

  /// UI & interaction text.
  ///
  /// In en, this message translates to:
  /// **'Back (alternative)'**
  String get interactionP13;

  /// Shortcut hint title
  ///
  /// In en, this message translates to:
  /// **'Shortcut: '**
  String get shortcutTitle;

  /// Scoring description.
  ///
  /// In en, this message translates to:
  /// **'Removing cards from the board one after the other creates a _chain_.'**
  String get scoringRichP01;

  /// Scoring description.
  ///
  /// In en, this message translates to:
  /// **'A chain ends when the player draws a card from the stock, or when the game ends. Using undo will only decrease the current chain\'s length, it will not end it. '**
  String get scoringP02;

  /// Scoring description.
  ///
  /// In en, this message translates to:
  /// **'When a chain ends, the player gains a score equal to the _square_ of that chain\'s length: 1 point for one card, 4 points for two cards, 9 points for three cards, and so on.'**
  String get scoringRichP03;

  /// Scoring description.
  ///
  /// In en, this message translates to:
  /// **'When the board is cleared, the player gains a bonus score equal to the _number of cards on the board at the start of the game_. '**
  String get scoringRichP04;

  /// Scoring description.
  ///
  /// In en, this message translates to:
  /// **'While clearing the board is the goal, you can easily get a higher score by creating long chains, even if you can\'t clear it. Play any way you want.'**
  String get scoringP05;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
