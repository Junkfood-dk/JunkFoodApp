/// Model representing an allergen with multilingual support
class AllergenModel {
  int id;
  String nameDa;
  String nameEn;
  String? originalName;

  AllergenModel({
    required this.id,
    required this.nameDa,
    required this.nameEn,
    this.originalName,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'allergen_name_da': nameDa,
      'allergen_name_en': nameEn,
      'allergen_name': originalName,
    };
  }

  static AllergenModel fromJson(Map<String, dynamic> json) {
    if (!json.containsKey('id')) {
      throw Exception('No id provided');
    }
    return AllergenModel(
      id: json['id'],
      nameDa: json['allergen_name_da'] ?? '',
      nameEn: json['allergen_name_en'] ?? '',
      originalName: json['allergen_name'],
    );
  }
}

/// Extension to provide language-specific allergen name retrieval
extension AllergenModelExtension on AllergenModel {
  /// Gets the allergen name for the specified language code.
  /// 
  /// Falls back gracefully:
  /// 1. Returns name in requested language if available
  /// 2. Falls back to the other language if requested language is empty/null
  /// 3. Falls back to original name if both language fields are empty
  /// 4. Returns generic fallback if all else fails
  String getNameForLanguage(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'da':
        if (nameDa.isNotEmpty) return nameDa;
        if (nameEn.isNotEmpty) return nameEn;
        break;
      case 'en':
        if (nameEn.isNotEmpty) return nameEn;
        if (nameDa.isNotEmpty) return nameDa;
        break;
      default:
        // For unsupported languages, prefer English, then Danish
        if (nameEn.isNotEmpty) return nameEn;
        if (nameDa.isNotEmpty) return nameDa;
    }
    
    // Final fallbacks
    if (originalName?.isNotEmpty == true) return originalName!;
    return 'Unknown allergen';
  }

  /// Gets the allergen name for Danish language
  String get danishName => getNameForLanguage('da');

  /// Gets the allergen name for English language
  String get englishName => getNameForLanguage('en');
}