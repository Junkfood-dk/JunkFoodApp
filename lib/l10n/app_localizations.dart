import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_da.dart';
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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('da'),
    Locale('en')
  ];

  /// This is the title banner of the Homepage
  ///
  /// In en, this message translates to:
  /// **'Homepage'**
  String get homePageTitle;

  /// Display of allergens title
  ///
  /// In en, this message translates to:
  /// **'Allergens'**
  String get allergens;

  /// Display message for when no allergens
  ///
  /// In en, this message translates to:
  /// **'No allergens'**
  String get noAllergens;

  /// Text to show when no dish for today's date has been posted
  ///
  /// In en, this message translates to:
  /// **'Today\'s menu will be available at 13:00'**
  String get noDishText;

  /// Calories info on dish page
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get calories;

  /// Main course dish type.
  ///
  /// In en, this message translates to:
  /// **'Main Course'**
  String get mainCourse;

  /// Dessert dish type.
  ///
  /// In en, this message translates to:
  /// **'Dessert'**
  String get dessert;

  /// Title of the dish of the day page
  ///
  /// In en, this message translates to:
  /// **'Dish of the day'**
  String get dishOfTheDay;

  /// Display message for when no description
  ///
  /// In en, this message translates to:
  /// **'No description'**
  String get noDescription;

  /// Display message for when no calories
  ///
  /// In en, this message translates to:
  /// **'No calories'**
  String get noCalories;

  /// Display message for when no title
  ///
  /// In en, this message translates to:
  /// **'No title'**
  String get noTitle;

  /// Display message for when no dishtype
  ///
  /// In en, this message translates to:
  /// **'No dishtype'**
  String get noDishType;

  /// Text for today's dish serving is over
  ///
  /// In en, this message translates to:
  /// **'Yesterday\'s serving has ended.\nToday\'s menu will be available at 13:00.'**
  String get servingHasEndedText;

  /// The text on the rate the dish button
  ///
  /// In en, this message translates to:
  /// **'Rate today\'s dish'**
  String get rateButtonText;

  /// The text on the rate the dish button
  ///
  /// In en, this message translates to:
  /// **'en'**
  String get localeHelper;

  /// title for rating widget
  ///
  /// In en, this message translates to:
  /// **'How was your meal today?'**
  String get ratingTitle;

  /// feedback text for rating widget
  ///
  /// In en, this message translates to:
  /// **'Help us choose the favorites of the future!'**
  String get ratingFeedback;

  /// Title for the page that acknowlegde the user for spending their time on rating the dish
  ///
  /// In en, this message translates to:
  /// **'Thank you for rating!'**
  String get ratingAcknowledgeTitle;

  /// Text for the page that acknowlegde the user for spending their time on rating the dish
  ///
  /// In en, this message translates to:
  /// **'You are always welcome to send us a message.\nYour opinion means a lot to us.'**
  String get ratingAcknowledgeText;

  /// Text for the button to navigate user back to the frontpage
  ///
  /// In en, this message translates to:
  /// **'Return to homepage'**
  String get ratingAcknowledgeButton;

  /// Text to submit the rating
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get ratingContinue;

  /// heading for comment page
  ///
  /// In en, this message translates to:
  /// **'We\'d love to hear from you!'**
  String get commentHeading;

  /// paragraph for comment page
  ///
  /// In en, this message translates to:
  /// **'Do you have an idea for today\'s dish? A special request - or maybe a birthday coming up? Whether it’s feedback, suggestions, or just something on your mind, your opinion matters to us. Send us a message here - we can’t wait to hear from you!'**
  String get commentPageParagraph;

  /// hint text for inputting name in comment page
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get yourNameHintText;

  /// hint text for inputting the actual comment in comment page
  ///
  /// In en, this message translates to:
  /// **'Write your feedback here'**
  String get writeCommentText;

  /// text for submit button
  ///
  /// In en, this message translates to:
  /// **'Send feedback'**
  String get commentPageSubmitButton;

  /// if user has rated once, but tries to rate again
  ///
  /// In en, this message translates to:
  /// **'You have rated this dish, would you like to change your rating?'**
  String get changeRating;

  /// used for yes/no dialogs
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// used for yes/no dialogs
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// error message for when trying to submit an empty comment
  ///
  /// In en, this message translates to:
  /// **'Comment Field must be filled out'**
  String get emptyCommentErrorMessage;

  /// comment is submitted succesfully
  ///
  /// In en, this message translates to:
  /// **'Comment posted successfully!'**
  String get succesfulCommentSubmission;

  /// failed to submit comment
  ///
  /// In en, this message translates to:
  /// **'Failed to post comment'**
  String get failedCommentSubmission;

  /// Title for comment acknowledgement page
  ///
  /// In en, this message translates to:
  /// **'Thank you for your comment!'**
  String get commentAcknowledgementTitle;

  /// Text for comment acknowledgement page
  ///
  /// In en, this message translates to:
  /// **'Your opinion means a lot to us'**
  String get commentAcknowledgementText;

  /// Text for the button to navigate user back to the frontpage
  ///
  /// In en, this message translates to:
  /// **'Return to homepage'**
  String get commentAcknowledgementButton;

  /// Encouraging user to send a message
  ///
  /// In en, this message translates to:
  /// **'Send us a message'**
  String get sendUsMsgBtn;

  /// Text indicating what allergens the dish contains
  ///
  /// In en, this message translates to:
  /// **'The dish contains:'**
  String get dishContents;

  /// Name of English language in language selector
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// Name of Danish language in language selector
  ///
  /// In en, this message translates to:
  /// **'Dansk'**
  String get languageDanish;

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'Junkfood'**
  String get appTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['da', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'da':
      return AppLocalizationsDa();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
