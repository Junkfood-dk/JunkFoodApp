import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'supabase_localizations_en.dart';
import 'supabase_localizations_da.dart';

/// Drop-in replacement for Flutter's AppLocalizations using cached Supabase strings
abstract class SupabaseLocalizations {
  SupabaseLocalizations(String locale) : localeName = locale;

  final String localeName;

  static SupabaseLocalizations? of(BuildContext context) {
    return Localizations.of<SupabaseLocalizations>(context, SupabaseLocalizations);
  }

  static const LocalizationsDelegate<SupabaseLocalizations> delegate =
      _SupabaseLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
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

  // String getters - must match AppLocalizations interface exactly
  
  /// This is the title banner of the Homepage
  String get homePageTitle;

  /// Display of allergens title
  String get allergens;

  /// Display message for when no allergens
  String get noAllergens;

  /// Text to show when no dish for today's date has been posted
  String get noDishText;

  /// Calories info on dish page
  String get calories;

  /// Main course dish type.
  String get mainCourse;

  /// Dessert dish type.
  String get dessert;

  /// Title of the dish of the day page
  String get dishOfTheDay;

  /// Display message for when no description
  String get noDescription;

  /// Display message for when no calories
  String get noCalories;

  /// Display message for when no title
  String get noTitle;

  /// Display message for when no dishtype
  String get noDishType;

  /// Text for today's dish serving is over
  String get servingHasEndedText;

  /// The text on the rate the dish button
  String get rateButtonText;

  /// The text on the rate the dish button
  String get localeHelper;

  /// title for rating widget
  String get ratingTitle;

  /// feedback text for rating widget
  String get ratingFeedback;

  /// Title for the page that acknowledge the user for spending their time on rating the dish
  String get ratingAcknowledgeTitle;

  /// Text for the page that acknowledge the user for spending their time on rating the dish
  String get ratingAcknowledgeText;

  /// Text for the button to navigate user back to the frontpage
  String get ratingAcknowledgeButton;

  /// Text to submit the rating
  String get ratingContinue;

  /// heading for comment page
  String get commentHeading;

  /// paragraph for comment page
  String get commentPageParagraph;

  /// hint text for inputting name in comment page
  String get yourNameHintText;

  /// hint text for inputting the actual comment in comment page
  String get writeCommentText;

  /// text for submit button
  String get commentPageSubmitButton;

  /// if user has rated once, but tries to rate again
  String get changeRating;

  /// used for yes/no dialogs
  String get yes;

  /// used for yes/no dialogs
  String get no;

  /// error message for when trying to submit an empty comment
  String get emptyCommentErrorMessage;

  /// comment is submitted successfully
  String get succesfulCommentSubmission;

  /// failed to submit comment
  String get failedCommentSubmission;

  /// Title for comment acknowledgement page
  String get commentAcknowledgementTitle;

  /// Text for comment acknowledgement page
  String get commentAcknowledgementText;

  /// Text for the button to navigate user back to the frontpage
  String get commentAcknowledgementButton;

  /// Encouraging user to send a message
  String get sendUsMsgBtn;

  /// Text indicating what allergens the dish contains
  String get dishContents;

  /// Name of English language in language selector
  String get languageEnglish;

  /// Name of Danish language in language selector
  String get languageDanish;

  /// Application title
  String get appTitle;
}

class _SupabaseLocalizationsDelegate extends LocalizationsDelegate<SupabaseLocalizations> {
  const _SupabaseLocalizationsDelegate();

  @override
  Future<SupabaseLocalizations> load(Locale locale) {
    return SynchronousFuture<SupabaseLocalizations>(_lookupSupabaseLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['da', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_SupabaseLocalizationsDelegate old) => false;
}

SupabaseLocalizations _lookupSupabaseLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'da':
      return SupabaseLocalizationsDa();
    case 'en':
      return SupabaseLocalizationsEn();
  }

  throw FlutterError(
      'SupabaseLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}