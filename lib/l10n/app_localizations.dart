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
  /// **'Values of closed cards'**
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
  /// **'Discard pile at start'**
  String get startEmptyControl;

  /// Value label of startEmpty control when it is off.
  ///
  /// In en, this message translates to:
  /// **'Has one card'**
  String get startEmptyOffLabel;

  /// Value label of startEmpty control when it is on.
  ///
  /// In en, this message translates to:
  /// **'Empty'**
  String get startEmptyOnLabel;

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
  /// **'Three peaks'**
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
  /// **'Crosshatch'**
  String get crosshatchDecorLabel;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'Grid Aligned'**
  String get gridAlignedDecorLabel;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'Lazy Suzan'**
  String get lazySuzanDecorLabel;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'N E U E'**
  String get neueDecorLabel;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'Oh, Rain'**
  String get ohRainDecorLabel;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'Seven Miles'**
  String get sevenMilesDecorLabel;

  /// Label of a decoration variant.
  ///
  /// In en, this message translates to:
  /// **'Solar'**
  String get solarDecorLabel;

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
