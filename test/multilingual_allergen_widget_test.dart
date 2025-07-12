import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junkfood/domain/model/dish_model.dart';
import 'package:junkfood/l10n/app_localizations.dart';
import 'package:junkfood/ui/widgets/dish_display_widget.dart';

void main() {
  group('Multilingual Allergen Display Tests', () {
    Widget createTestWidget(DishModel dish, {Locale? locale}) {
      return ProviderScope(
        child: Consumer(
          builder: (context, ref, child) => MaterialApp(
            locale: locale ?? const Locale('en'),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('da'),
            ],
            home: Scaffold(
              body: DishDisplayWidget(dish: dish),
            ),
          ),
        ),
      );
    }

    testWidgets('displays allergens in English when locale is English',
        (WidgetTester tester) async {
      final dish = DishModel(
        title: 'Test Dish',
        description: 'A test dish',
        calories: 300,
        imageUrl: 'https://example.com/dish.jpg',
        dishTypeId: 1,
        dishTypeName: 'Main',
        allergens: [
          'Gluten',
          'Milk',
          'Nuts',
        ], // English names for backward compatibility
      );

      await tester
          .pumpWidget(createTestWidget(dish, locale: const Locale('en')));
      await tester.pumpAndSettle();

      // Verify English allergen names are displayed
      expect(find.text('Gluten • '), findsOneWidget);
      expect(find.text('Milk • '), findsOneWidget);
      expect(find.text('Nuts'), findsOneWidget); // Last one doesn't have bullet

      // Verify Danish names are not displayed
      expect(find.text('Mælk'), findsNothing);
      expect(find.text('Nødder'), findsNothing);
    });

    testWidgets('displays allergens in Danish when locale is Danish',
        (WidgetTester tester) async {
      final dish = DishModel(
        title: 'Test Ret',
        description: 'En test ret',
        calories: 300,
        imageUrl: 'https://example.com/dish.jpg',
        dishTypeId: 1,
        dishTypeName: 'Hovedret',
        allergens: [
          'Gluten',
          'Mælk',
          'Nødder',
        ], // Danish names for backward compatibility
      );

      await tester
          .pumpWidget(createTestWidget(dish, locale: const Locale('da')));
      await tester.pumpAndSettle();

      // Verify Danish allergen names are displayed
      expect(find.text('Gluten • '), findsOneWidget);
      expect(find.text('Mælk • '), findsOneWidget);
      expect(
        find.text('Nødder'),
        findsOneWidget,
      ); // Last one doesn't have bullet

      // Verify English-only names are not displayed (except Gluten which is same)
      expect(find.text('Milk'), findsNothing);
      expect(find.text('Nuts'), findsNothing);
    });

    testWidgets('displays "No allergens" message when allergen list is empty',
        (WidgetTester tester) async {
      final dish = DishModel(
        title: 'Safe Dish',
        description: 'A dish with no allergens',
        calories: 200,
        imageUrl: 'https://example.com/safe-dish.jpg',
        dishTypeId: 1,
        dishTypeName: 'Main',
        allergens: [],
      );

      await tester
          .pumpWidget(createTestWidget(dish, locale: const Locale('en')));
      await tester.pumpAndSettle();

      // Should find the "No allergens" text
      expect(find.text('No allergens'), findsOneWidget);
    });

    testWidgets('displays Danish "No allergens" message when locale is Danish',
        (WidgetTester tester) async {
      final dish = DishModel(
        title: 'Sikker Ret',
        description: 'En ret uden allergener',
        calories: 200,
        imageUrl: 'https://example.com/safe-dish.jpg',
        dishTypeId: 1,
        dishTypeName: 'Hovedret',
        allergens: [],
      );

      await tester
          .pumpWidget(createTestWidget(dish, locale: const Locale('da')));
      await tester.pumpAndSettle();

      // Should find the Danish "No allergens" text
      expect(find.text('Ingen allergener'), findsOneWidget);
      // Should not find the English version
      expect(find.text('No allergens'), findsNothing);
    });

    testWidgets('falls back gracefully when allergen has missing translation',
        (WidgetTester tester) async {
      final dish = DishModel(
        title: 'Complex Dish',
        description: 'A dish with mixed translations',
        calories: 400,
        imageUrl: 'https://example.com/complex-dish.jpg',
        dishTypeId: 1,
        dishTypeName: 'Main',
        allergens: ['Gluten', 'Shellfish', 'Soja'], // Fallback values
      );

      // Test Danish locale with missing Danish translation
      await tester
          .pumpWidget(createTestWidget(dish, locale: const Locale('da')));
      await tester.pumpAndSettle();

      expect(find.text('Gluten • '), findsOneWidget);
      expect(
        find.text('Shellfish • '),
        findsOneWidget,
      ); // Falls back to English
      expect(find.text('Soja'), findsOneWidget); // Danish available

      // Test English locale with missing English translation
      await tester
          .pumpWidget(createTestWidget(dish, locale: const Locale('en')));
      await tester.pumpAndSettle();

      expect(find.text('Gluten • '), findsOneWidget);
      expect(find.text('Shellfish • '), findsOneWidget); // English available
      expect(find.text('Soja'), findsOneWidget); // Falls back to Danish
    });

    testWidgets('displays allergen section header in correct language',
        (WidgetTester tester) async {
      final dish = DishModel(
        title: 'Test Dish',
        description: 'Test description',
        calories: 300,
        imageUrl: 'https://example.com/dish.jpg',
        dishTypeId: 1,
        dishTypeName: 'Main',
        allergens: ['Gluten'],
      );

      // Test English
      await tester
          .pumpWidget(createTestWidget(dish, locale: const Locale('en')));
      await tester.pumpAndSettle();
      expect(find.text('Allergens'), findsOneWidget);

      // Test Danish
      await tester
          .pumpWidget(createTestWidget(dish, locale: const Locale('da')));
      await tester.pumpAndSettle();
      expect(find.text('Allergener'), findsOneWidget);
    });

    testWidgets('handles special characters in allergen names correctly',
        (WidgetTester tester) async {
      final dish = DishModel(
        title: 'Special Characters Dish',
        description: 'A dish with special character allergens',
        calories: 350,
        imageUrl: 'https://example.com/special-dish.jpg',
        dishTypeId: 1,
        dishTypeName: 'Main',
        allergens: ['Æg', 'Sennep & Krydderier'],
      );

      await tester
          .pumpWidget(createTestWidget(dish, locale: const Locale('da')));
      await tester.pumpAndSettle();

      expect(find.text('Æg • '), findsOneWidget);
      expect(find.text('Sennep & Krydderier'), findsOneWidget);
    });

    testWidgets('displays correct bullet separators between allergens',
        (WidgetTester tester) async {
      final dish = DishModel(
        title: 'Multi-Allergen Dish',
        description: 'A dish with multiple allergens',
        calories: 500,
        imageUrl: 'https://example.com/multi-allergen.jpg',
        dishTypeId: 1,
        dishTypeName: 'Main',
        allergens: ['First', 'Second', 'Third', 'Last'],
      );

      await tester
          .pumpWidget(createTestWidget(dish, locale: const Locale('en')));
      await tester.pumpAndSettle();

      // Verify bullets are present except for the last item
      expect(find.text('First • '), findsOneWidget);
      expect(find.text('Second • '), findsOneWidget);
      expect(find.text('Third • '), findsOneWidget);
      expect(find.text('Last'), findsOneWidget); // No bullet for last item
    });
  });
}
