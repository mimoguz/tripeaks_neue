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

  /// Label of a control that closes menu and returns to the game page.
  ///
  /// In en, this message translates to:
  /// **'Return to Game'**
  String get returnAction;

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

  /// Tooltip of a control that navigates to the 'Settings' page.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTooltip;

  /// Tooltip of a control that navigates to the 'Help & About' page.
  ///
  /// In en, this message translates to:
  /// **'Help & About'**
  String get infoTooltip;

  /// Tooltip of a control that navigates to the 'Help & About' page.
  ///
  /// In en, this message translates to:
  /// **'Return to Game'**
  String get homeTooltip;

  /// Title of the 'Settings' page.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Default semantic label of a multi-state switch.
  ///
  /// In en, this message translates to:
  /// **'Multi-state switch'**
  String get multiStateSwitchDefaultLabel;

  /// Label of a control that sets application theme mode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get themeModeControl;

  /// Label of a control that sets if the values of closed cards should be shown.
  ///
  /// In en, this message translates to:
  /// **'Show values of closed cards'**
  String get showAllControl;

  /// Label of a control that sets if the discard pile should be empty at the beginning of the game.
  ///
  /// In en, this message translates to:
  /// **'Start with an empty discard pile'**
  String get startEmptyControl;

  /// Label of a control that sets the decoration that is used on the back of the cards.
  ///
  /// In en, this message translates to:
  /// **'Card back decoration'**
  String get decorControl;
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
