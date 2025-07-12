import 'package:flutter_test/flutter_test.dart';
import 'package:junkfood/domain/model/allergen_model.dart';

void main() {
  group('AllergenModel', () {
    group('fromJson', () {
      test('creates AllergenModel from valid JSON with all fields', () {
        final json = {
          'id': 1,
          'allergen_name_da': 'Gluten',
          'allergen_name_en': 'Gluten',
          'allergen_name': 'Original Gluten',
        };

        final allergen = AllergenModel.fromJson(json);

        expect(allergen.id, 1);
        expect(allergen.nameDa, 'Gluten');
        expect(allergen.nameEn, 'Gluten');
        expect(allergen.originalName, 'Original Gluten');
      });

      test('creates AllergenModel with empty strings for missing language fields', () {
        final json = {
          'id': 2,
          'allergen_name': 'Original Milk',
        };

        final allergen = AllergenModel.fromJson(json);

        expect(allergen.id, 2);
        expect(allergen.nameDa, '');
        expect(allergen.nameEn, '');
        expect(allergen.originalName, 'Original Milk');
      });

      test('throws exception when id is missing', () {
        final json = {
          'allergen_name_da': 'Nødder',
          'allergen_name_en': 'Nuts',
        };

        expect(() => AllergenModel.fromJson(json), throwsException);
      });
    });

    group('toJson', () {
      test('converts AllergenModel to JSON with all fields', () {
        final allergen = AllergenModel(
          id: 3,
          nameDa: 'Mælk',
          nameEn: 'Milk',
          originalName: 'Dairy',
        );

        final json = allergen.toJson();

        expect(json, {
          'id': 3,
          'allergen_name_da': 'Mælk',
          'allergen_name_en': 'Milk',
          'allergen_name': 'Dairy',
        });
      });

      test('converts AllergenModel to JSON with null originalName', () {
        final allergen = AllergenModel(
          id: 4,
          nameDa: 'Selleri',
          nameEn: 'Celery',
        );

        final json = allergen.toJson();

        expect(json, {
          'id': 4,
          'allergen_name_da': 'Selleri',
          'allergen_name_en': 'Celery',
          'allergen_name': null,
        });
      });
    });

    group('getNameForLanguage', () {
      late AllergenModel allergen;

      setUp(() {
        allergen = AllergenModel(
          id: 1,
          nameDa: 'Nødder',
          nameEn: 'Nuts',
          originalName: 'Original Nuts',
        );
      });

      test('returns Danish name for "da" language code', () {
        expect(allergen.getNameForLanguage('da'), 'Nødder');
      });

      test('returns Danish name for "DA" language code (case insensitive)', () {
        expect(allergen.getNameForLanguage('DA'), 'Nødder');
      });

      test('returns English name for "en" language code', () {
        expect(allergen.getNameForLanguage('en'), 'Nuts');
      });

      test('returns English name for "EN" language code (case insensitive)', () {
        expect(allergen.getNameForLanguage('EN'), 'Nuts');
      });

      test('returns English name for unsupported language code', () {
        expect(allergen.getNameForLanguage('fr'), 'Nuts');
      });

      test('falls back to English when Danish is empty', () {
        final allergenWithEmptyDanish = AllergenModel(
          id: 2,
          nameDa: '',
          nameEn: 'Shellfish',
          originalName: 'Original Shellfish',
        );

        expect(allergenWithEmptyDanish.getNameForLanguage('da'), 'Shellfish');
      });

      test('falls back to Danish when English is empty', () {
        final allergenWithEmptyEnglish = AllergenModel(
          id: 3,
          nameDa: 'Skaldyr',
          nameEn: '',
          originalName: 'Original Shellfish',
        );

        expect(allergenWithEmptyEnglish.getNameForLanguage('en'), 'Skaldyr');
      });

      test('falls back to original name when both language fields are empty', () {
        final allergenWithEmptyLanguages = AllergenModel(
          id: 4,
          nameDa: '',
          nameEn: '',
          originalName: 'Legacy Allergen',
        );

        expect(allergenWithEmptyLanguages.getNameForLanguage('da'), 'Legacy Allergen');
        expect(allergenWithEmptyLanguages.getNameForLanguage('en'), 'Legacy Allergen');
      });

      test('returns "Unknown allergen" when all fields are empty or null', () {
        final allergenWithNoNames = AllergenModel(
          id: 5,
          nameDa: '',
          nameEn: '',
          originalName: null,
        );

        expect(allergenWithNoNames.getNameForLanguage('da'), 'Unknown allergen');
        expect(allergenWithNoNames.getNameForLanguage('en'), 'Unknown allergen');
      });

      test('returns "Unknown allergen" when original name is empty string', () {
        final allergenWithEmptyOriginal = AllergenModel(
          id: 6,
          nameDa: '',
          nameEn: '',
          originalName: '',
        );

        expect(allergenWithEmptyOriginal.getNameForLanguage('da'), 'Unknown allergen');
      });
    });

    group('danishName getter', () {
      test('returns Danish name', () {
        final allergen = AllergenModel(
          id: 1,
          nameDa: 'Fisk',
          nameEn: 'Fish',
        );

        expect(allergen.danishName, 'Fisk');
      });

      test('falls back to English when Danish is empty', () {
        final allergen = AllergenModel(
          id: 1,
          nameDa: '',
          nameEn: 'Fish',
        );

        expect(allergen.danishName, 'Fish');
      });
    });

    group('englishName getter', () {
      test('returns English name', () {
        final allergen = AllergenModel(
          id: 1,
          nameDa: 'Fisk',
          nameEn: 'Fish',
        );

        expect(allergen.englishName, 'Fish');
      });

      test('falls back to Danish when English is empty', () {
        final allergen = AllergenModel(
          id: 1,
          nameDa: 'Fisk',
          nameEn: '',
        );

        expect(allergen.englishName, 'Fisk');
      });
    });

    group('edge cases', () {
      test('handles empty string values correctly', () {
        final allergen = AllergenModel(
          id: 1,
          nameDa: '',
          nameEn: '',
          originalName: '',
        );

        expect(allergen.getNameForLanguage('da'), 'Unknown allergen');
        expect(allergen.getNameForLanguage('en'), 'Unknown allergen');
      });

      test('handles mixed empty and filled values', () {
        final allergen = AllergenModel(
          id: 1,
          nameDa: 'Æg',
          nameEn: '',
          originalName: null,
        );

        expect(allergen.getNameForLanguage('da'), 'Æg');
        expect(allergen.getNameForLanguage('en'), 'Æg');
        expect(allergen.getNameForLanguage('fr'), 'Æg');
      });

      test('handles special characters and unicode correctly', () {
        final allergen = AllergenModel(
          id: 1,
          nameDa: 'Café Français Æøå',
          nameEn: 'French Café äöü',
          originalName: 'Spëciål Çhãrs',
        );

        expect(allergen.getNameForLanguage('da'), 'Café Français Æøå');
        expect(allergen.getNameForLanguage('en'), 'French Café äöü');
      });
    });
  });
}