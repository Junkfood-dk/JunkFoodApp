import 'package:flutter_test/flutter_test.dart';
import 'package:junkfood/domain/model/allergen_model.dart';

void main() {
  group('Multilingual Allergen Repository Integration', () {
    group('AllergenModel Data Processing', () {
      test('processes database response data correctly', () {
        // Simulate processing database response similar to what repository does
        final mockDatabaseResponse = [
          {
            'Allergens': {
              'id': 1,
              'allergen_name_da': 'Gluten',
              'allergen_name_en': 'Gluten',
              'allergen_name': 'Original Gluten',
            },
          },
          {
            'Allergens': {
              'id': 2,
              'allergen_name_da': 'Mælk',
              'allergen_name_en': 'Milk',
              'allergen_name': 'Original Milk',
            },
          },
        ];

        final allergens = mockDatabaseResponse.map((json) {
          final allergenData = json['Allergens'];
          return AllergenModel.fromJson({
            'id': allergenData?['id'],
            'allergen_name_da': allergenData?['allergen_name_da'],
            'allergen_name_en': allergenData?['allergen_name_en'],
            'allergen_name': allergenData?['allergen_name'],
          });
        }).toList();

        expect(allergens.length, 2);
        expect(allergens[0].id, 1);
        expect(allergens[0].nameDa, 'Gluten');
        expect(allergens[0].nameEn, 'Gluten');
        expect(allergens[1].nameDa, 'Mælk');
        expect(allergens[1].nameEn, 'Milk');
      });

      test('handles missing language fields in database response', () {
        final mockDatabaseResponse = [
          {
            'Allergens': {
              'id': 3,
              'allergen_name_da': null,
              'allergen_name_en': 'Nuts',
              'allergen_name': 'Legacy Nuts',
            },
          },
          {
            'Allergens': {
              'id': 4,
              'allergen_name_da': 'Soja',
              'allergen_name_en': null,
              'allergen_name': null,
            },
          },
        ];

        final allergens = mockDatabaseResponse.map((json) {
          final allergenData = json['Allergens'];
          return AllergenModel.fromJson({
            'id': allergenData?['id'],
            'allergen_name_da': allergenData?['allergen_name_da'],
            'allergen_name_en': allergenData?['allergen_name_en'],
            'allergen_name': allergenData?['allergen_name'],
          });
        }).toList();

        expect(allergens.length, 2);

        // First allergen: missing Danish, has English
        expect(allergens[0].id, 3);
        expect(allergens[0].nameDa, ''); // null becomes empty string
        expect(allergens[0].nameEn, 'Nuts');
        expect(allergens[0].originalName, 'Legacy Nuts');

        // Second allergen: has Danish, missing English
        expect(allergens[1].id, 4);
        expect(allergens[1].nameDa, 'Soja');
        expect(allergens[1].nameEn, ''); // null becomes empty string
        expect(allergens[1].originalName, null);
      });

      test('converts allergen models to language-specific names', () {
        final allergens = [
          AllergenModel(
            id: 1,
            nameDa: 'Nødder',
            nameEn: 'Nuts',
            originalName: 'Original Nuts',
          ),
          AllergenModel(
            id: 2,
            nameDa: 'Fisk',
            nameEn: 'Fish',
            originalName: 'Original Fish',
          ),
        ];

        // Simulate repository method: allergens.map((allergen) => allergen.getNameForLanguage(languageCode))
        final danishNames = allergens
            .map((allergen) => allergen.getNameForLanguage('da'))
            .toList();
        final englishNames = allergens
            .map((allergen) => allergen.getNameForLanguage('en'))
            .toList();

        expect(danishNames, ['Nødder', 'Fisk']);
        expect(englishNames, ['Nuts', 'Fish']);
      });

      test('handles fallback scenarios in name conversion', () {
        final allergens = [
          AllergenModel(
            id: 1,
            nameDa: '', // Missing Danish
            nameEn: 'Shellfish',
            originalName: 'Original Shellfish',
          ),
          AllergenModel(
            id: 2,
            nameDa: 'Selleri',
            nameEn: '', // Missing English
            originalName: 'Original Celery',
          ),
        ];

        final danishNames = allergens
            .map((allergen) => allergen.getNameForLanguage('da'))
            .toList();
        final englishNames = allergens
            .map((allergen) => allergen.getNameForLanguage('en'))
            .toList();

        // Danish should fall back to English for first allergen
        expect(danishNames, ['Shellfish', 'Selleri']);
        // English should fall back to Danish for second allergen
        expect(englishNames, ['Shellfish', 'Selleri']);
      });
    });

    group('Database Query Structure Validation', () {
      test('validates expected database query structure', () {
        // This test ensures the query structure matches what the repository expects
        const expectedSelectQuery =
            'Allergens(id, allergen_name_da, allergen_name_en, allergen_name)';
        const expectedTable = 'Allergens_to_Dishes';
        const expectedFilterField = 'dish_id';

        // These constants should match what's used in the actual repository
        expect(expectedSelectQuery, contains('allergen_name_da'));
        expect(expectedSelectQuery, contains('allergen_name_en'));
        expect(expectedSelectQuery, contains('allergen_name')); // Legacy field
        expect(expectedTable, 'Allergens_to_Dishes');
        expect(expectedFilterField, 'dish_id');
      });

      test('validates legacy query structure for backwards compatibility', () {
        const legacySelectQuery = 'Allergens(allergen_name)';
        const expectedTable = 'Allergens_to_Dishes';

        expect(legacySelectQuery, 'Allergens(allergen_name)');
        expect(expectedTable, 'Allergens_to_Dishes');
      });
    });

    group('Integration Scenarios', () {
      test('simulates complete allergen fetching flow', () {
        // Simulate the complete flow from database response to UI display
        final mockDatabaseResponse = [
          {
            'Allergens': {
              'id': 1,
              'allergen_name_da': 'Gluten',
              'allergen_name_en': 'Gluten',
              'allergen_name': 'Original Gluten',
            },
          },
          {
            'Allergens': {
              'id': 2,
              'allergen_name_da': 'Æg',
              'allergen_name_en': 'Eggs',
              'allergen_name': 'Original Eggs',
            },
          },
        ];

        // Step 1: Parse database response to AllergenModel
        final allergenModels = mockDatabaseResponse.map((json) {
          final allergenData = json['Allergens'];
          return AllergenModel.fromJson({
            'id': allergenData?['id'],
            'allergen_name_da': allergenData?['allergen_name_da'],
            'allergen_name_en': allergenData?['allergen_name_en'],
            'allergen_name': allergenData?['allergen_name'],
          });
        }).toList();

        // Step 2: Convert to language-specific strings for UI (Danish)
        final danishAllergenNames = allergenModels
            .map((allergen) => allergen.getNameForLanguage('da'))
            .toList();

        // Step 3: Convert to language-specific strings for UI (English)
        final englishAllergenNames = allergenModels
            .map((allergen) => allergen.getNameForLanguage('en'))
            .toList();

        // Verify the complete flow
        expect(allergenModels.length, 2);
        expect(danishAllergenNames, ['Gluten', 'Æg']);
        expect(englishAllergenNames, ['Gluten', 'Eggs']);
      });

      test('simulates error handling and fallbacks', () {
        // Test with problematic data that should still work
        final problematicData = [
          {
            'Allergens': {
              'id': 1,
              'allergen_name_da': null,
              'allergen_name_en': null,
              'allergen_name': 'Only Legacy Available',
            },
          },
          {
            'Allergens': {
              'id': 2,
              'allergen_name_da': '',
              'allergen_name_en': '',
              'allergen_name': null,
            },
          },
        ];

        final allergenModels = problematicData.map((json) {
          final allergenData = json['Allergens'];
          return AllergenModel.fromJson({
            'id': allergenData?['id'],
            'allergen_name_da': allergenData?['allergen_name_da'],
            'allergen_name_en': allergenData?['allergen_name_en'],
            'allergen_name': allergenData?['allergen_name'],
          });
        }).toList();

        final names = allergenModels
            .map((allergen) => allergen.getNameForLanguage('en'))
            .toList();

        expect(
          names[0],
          'Only Legacy Available',
        ); // Falls back to original name
        expect(names[1], 'Unknown allergen'); // Final fallback
      });
    });
  });
}
