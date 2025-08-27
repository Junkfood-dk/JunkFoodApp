import 'supabase_localizations.dart';
import 'string_cache_service.dart';

/// Danish localizations implementation using cached Supabase strings
class SupabaseLocalizationsDa extends SupabaseLocalizations {
  SupabaseLocalizationsDa() : super('da');

  // Cache for string lookups - initialized at app startup
  static Map<String, String> _cachedStrings = {};
  
  /// Initialize the cache for this language
  static Future<void> initializeCache() async {
    try {
      _cachedStrings = await StringCacheService.instance.getStrings('da');
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
  String get homePageTitle => _getString('homePageTitle', 'Startside');

  @override
  String get allergens => _getString('allergens', 'Allergener');

  @override
  String get noAllergens => _getString('noAllergens', 'Ingen allergener');

  @override
  String get noDishText => _getString('noDishText', 'Dagens ret vises kl. 13:00');

  @override
  String get calories => _getString('calories', 'Kalorier');

  @override
  String get mainCourse => _getString('mainCourse', 'Hovedret');

  @override
  String get dessert => _getString('dessert', 'Dessert');

  @override
  String get dishOfTheDay => _getString('dishOfTheDay', 'Dagens ret');

  @override
  String get noDescription => _getString('noDescription', 'Ingen beskrivelse');

  @override
  String get noCalories => _getString('noCalories', 'Ingen kalorier');

  @override
  String get noTitle => _getString('noTitle', 'Ingen titel');

  @override
  String get noDishType => _getString('noDishType', 'Ingen type ret');

  @override
  String get servingHasEndedText => _getString('servingHasEndedText', 
    'Servering af gårsdagens ret er slut.\nDagens ret vises kl. 13:00.');

  @override
  String get rateButtonText => _getString('rateButtonText', 'Bedøm dagens ret');

  @override
  String get localeHelper => _getString('localeHelper', 'da');

  @override
  String get ratingTitle => _getString('ratingTitle', 'Hvordan var dagens ret?');

  @override
  String get ratingFeedback => _getString('ratingFeedback', 'Hjælp os med at vælge fremtidens favoritter!');

  @override
  String get ratingAcknowledgeTitle => _getString('ratingAcknowledgeTitle', 'Tak for din bedømmelse!');

  @override
  String get ratingAcknowledgeText => _getString('ratingAcknowledgeText', 
    'Du er altid velkommen til at sende os en besked.\nDin mening betyder meget for os');

  @override
  String get ratingAcknowledgeButton => _getString('ratingAcknowledgeButton', 'Tilbage til forsiden');

  @override
  String get ratingContinue => _getString('ratingContinue', 'Fortsæt');

  @override
  String get commentHeading => _getString('commentHeading', 'Send os en besked her');

  @override
  String get commentPageParagraph => _getString('commentPageParagraph', 
    'Har du en idé til dagens ret? Et særligt ønske - eller måske en fødselsdag på vej? Uanset om du har ris, ros eller bare noget på hjerte, betyder din mening meget for os. Vi glæder os til at høre fra dig!');

  @override
  String get yourNameHintText => _getString('yourNameHintText', 'Dit navn');

  @override
  String get writeCommentText => _getString('writeCommentText', 'Skriv din besked her');

  @override
  String get commentPageSubmitButton => _getString('commentPageSubmitButton', 'Send besked');

  @override
  String get changeRating => _getString('changeRating', 
    'Du har bedømt dagens ret. Vil du ændre din bedømmelse?');

  @override
  String get yes => _getString('yes', 'Ja');

  @override
  String get no => _getString('no', 'Nej');

  @override
  String get emptyCommentErrorMessage => _getString('emptyCommentErrorMessage', 
    'Kommentarfeltet skal være udfyldt');

  @override
  String get succesfulCommentSubmission => _getString('succesfulCommentSubmission', 
    'Kommentar indsendt!');

  @override
  String get failedCommentSubmission => _getString('failedCommentSubmission', 
    'Kommentar kunne ikke indsendes');

  @override
  String get commentAcknowledgementTitle => _getString('commentAcknowledgementTitle', 
    'Tak for din kommentar!');

  @override
  String get commentAcknowledgementText => _getString('commentAcknowledgementText', 
    'Din mening betyder meget for os');

  @override
  String get commentAcknowledgementButton => _getString('commentAcknowledgementButton', 
    'Tilbage til forsiden');

  @override
  String get sendUsMsgBtn => _getString('sendUsMsgBtn', 'Send os en besked');

  @override
  String get dishContents => _getString('dishContents', 'Retten består af:');

  @override
  String get languageEnglish => _getString('languageEnglish', 'English');

  @override
  String get languageDanish => _getString('languageDanish', 'Dansk');

  @override
  String get appTitle => _getString('appTitle', 'Junkfood');
}