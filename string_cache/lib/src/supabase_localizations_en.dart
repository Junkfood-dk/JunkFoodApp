import 'supabase_localizations.dart';
import 'string_cache_service.dart';

/// English localizations implementation using cached Supabase strings
class SupabaseLocalizationsEn extends SupabaseLocalizations {
  SupabaseLocalizationsEn() : super('en');

  // Cache for string lookups - initialized at app startup
  static Map<String, String> _cachedStrings = {};
  
  /// Initialize the cache for this language
  static Future<void> initializeCache() async {
    try {
      _cachedStrings = await StringCacheService.instance.getStrings('en');
    } catch (e) {
      _cachedStrings = {};
    }
  }

  /// Force refresh the cache from StringCacheService
  /// Call this when strings are updated in Supabase
  static Future<void> refreshCache() async {
    await initializeCache();
  }

  /// Get a string from cache with fallback
  String _getString(String key, String fallback) {
    return _cachedStrings[key] ?? fallback;
  }

  @override
  String get homePageTitle => _getString('homePageTitle', 'Homepage');

  @override
  String get allergens => _getString('allergens', 'Allergens');

  @override
  String get noAllergens => _getString('noAllergens', 'No allergens');

  @override
  String get noDishText => _getString('noDishText', 'Today\'s menu will be available at 13:00');

  @override
  String get calories => _getString('calories', 'Calories');

  @override
  String get mainCourse => _getString('mainCourse', 'Main Course');

  @override
  String get dessert => _getString('dessert', 'Dessert');

  @override
  String get dishOfTheDay => _getString('dishOfTheDay', 'Dish of the day');

  @override
  String get noDescription => _getString('noDescription', 'No description');

  @override
  String get noCalories => _getString('noCalories', 'No calories');

  @override
  String get noTitle => _getString('noTitle', 'No title');

  @override
  String get noDishType => _getString('noDishType', 'No dishtype');

  @override
  String get servingHasEndedText => _getString('servingHasEndedText', 
    'Yesterday\'s serving has ended.\nToday\'s menu will be available at 13:00.');

  @override
  String get rateButtonText => _getString('rateButtonText', 'Rate today\'s dish');

  @override
  String get localeHelper => _getString('localeHelper', 'en');

  @override
  String get ratingTitle => _getString('ratingTitle', 'How was your meal today?');

  @override
  String get ratingFeedback => _getString('ratingFeedback', 'Help us choose the favorites of the future!');

  @override
  String get ratingAcknowledgeTitle => _getString('ratingAcknowledgeTitle', 'Thank you for rating!');

  @override
  String get ratingAcknowledgeText => _getString('ratingAcknowledgeText', 
    'You are always welcome to send us a message.\nYour opinion means a lot to us.');

  @override
  String get ratingAcknowledgeButton => _getString('ratingAcknowledgeButton', 'Return to homepage');

  @override
  String get ratingContinue => _getString('ratingContinue', 'Continue');

  @override
  String get commentHeading => _getString('commentHeading', 'We\'d love to hear from you!');

  @override
  String get commentPageParagraph => _getString('commentPageParagraph', 
    'Do you have an idea for today\'s dish? A special request - or maybe a birthday coming up? Whether it\'s feedback, suggestions, or just something on your mind, your opinion matters to us. Send us a message here - we can\'t wait to hear from you!');

  @override
  String get yourNameHintText => _getString('yourNameHintText', 'Your name');

  @override
  String get writeCommentText => _getString('writeCommentText', 'Write your feedback here');

  @override
  String get commentPageSubmitButton => _getString('commentPageSubmitButton', 'Send feedback');

  @override
  String get changeRating => _getString('changeRating', 
    'You have rated this dish, would you like to change your rating?');

  @override
  String get yes => _getString('yes', 'Yes');

  @override
  String get no => _getString('no', 'No');

  @override
  String get emptyCommentErrorMessage => _getString('emptyCommentErrorMessage', 
    'Comment Field must be filled out');

  @override
  String get succesfulCommentSubmission => _getString('succesfulCommentSubmission', 
    'Comment posted successfully!');

  @override
  String get failedCommentSubmission => _getString('failedCommentSubmission', 
    'Failed to post comment');

  @override
  String get commentAcknowledgementTitle => _getString('commentAcknowledgementTitle', 
    'Thank you for your comment!');

  @override
  String get commentAcknowledgementText => _getString('commentAcknowledgementText', 
    'Your opinion means a lot to us');

  @override
  String get commentAcknowledgementButton => _getString('commentAcknowledgementButton', 
    'Return to homepage');

  @override
  String get sendUsMsgBtn => _getString('sendUsMsgBtn', 'Send us a message');

  @override
  String get dishContents => _getString('dishContents', 'The dish contains:');

  @override
  String get languageEnglish => _getString('languageEnglish', 'English');

  @override
  String get languageDanish => _getString('languageDanish', 'Dansk');

  @override
  String get appTitle => _getString('appTitle', 'Junkfood');
}