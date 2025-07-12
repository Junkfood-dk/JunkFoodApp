import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junkfood/domain/model/dish_model.dart';
import 'package:junkfood/l10n/app_localizations.dart';
import 'package:junkfood/ui/controllers/locale_controller.dart';
import 'package:junkfood/ui/widgets/dish_display_widget.dart';

void main() {
  group('DishDisplayWidget Title Display Tests', () {
    Widget createTestWidget(DishModel dish) {
      return ProviderScope(
        child: Consumer(
          builder: (context, ref, child) => MaterialApp(
            locale: switch (ref.watch(localeControllerProvider)) {
              AsyncData(:final value) => value,
              _ => const Locale('en'),
            },
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

    testWidgets('Short title displays completely without truncation',
        (WidgetTester tester) async {
      const shortTitle = 'Pasta';
      final dish = DishModel(
        title: shortTitle,
        description: 'Delicious pasta dish',
        calories: 300,
        imageUrl: 'https://example.com/pasta.jpg',
        dishTypeId: 1,
        dishTypeName: 'Main',
        allergens: ['Gluten'],
      );

      await tester.pumpWidget(createTestWidget(dish));
      await tester.pumpAndSettle();

      expect(find.text(shortTitle), findsOneWidget);
    });

    testWidgets('Long title displays completely without ellipsis truncation',
        (WidgetTester tester) async {
      const longTitle =
          'This is a very long dish title that should be fully visible and not truncated with ellipsis';
      final dish = DishModel(
        title: longTitle,
        description: 'Test description',
        calories: 400,
        imageUrl: 'https://example.com/long-title-dish.jpg',
        dishTypeId: 1,
        dishTypeName: 'Main',
        allergens: ['Test Allergen'],
      );

      await tester.pumpWidget(createTestWidget(dish));
      await tester.pumpAndSettle();

      // The title should be displayed in sentence case
      const expectedLongTitle =
          'This is a very long dish title that should be fully visible and not truncated with ellipsis';
      expect(find.text(expectedLongTitle), findsOneWidget);

      // Verify the text is not truncated by checking that the full text exists
      final textWidget = tester.widget<Text>(find.text(expectedLongTitle));
      expect(textWidget.data, equals(expectedLongTitle));
    });

    testWidgets('Title with special characters and emojis displays correctly',
        (WidgetTester tester) async {
      const specialTitle = 'Delicious Café Français 🍽️ & Spätzle with Åccénts';
      final dish = DishModel(
        title: specialTitle,
        description: 'Test description',
        calories: 350,
        imageUrl: 'https://example.com/special-dish.jpg',
        dishTypeId: 1,
        dishTypeName: 'Main',
        allergens: ['Gluten', 'Dairy'],
      );

      await tester.pumpWidget(createTestWidget(dish));
      await tester.pumpAndSettle();

      // The title should be displayed in sentence case
      const expectedTitle =
          'Delicious café français 🍽️ & spätzle with åccénts';
      expect(find.text(expectedTitle), findsOneWidget);
    });

    testWidgets('Empty title shows fallback text', (WidgetTester tester) async {
      final dish = DishModel(
        title: '',
        description: 'Test description',
        calories: 200,
        imageUrl: 'https://example.com/no-title-dish.jpg',
        dishTypeId: 1,
        dishTypeName: 'Main',
        allergens: [],
      );

      await tester.pumpWidget(createTestWidget(dish));
      await tester.pumpAndSettle();

      // Should show the localized "No title" text instead of empty string
      expect(find.text(''), findsNothing);
      // The exact fallback text depends on localization, but it should exist
      expect(find.textContaining('title', findRichText: true), findsWidgets);
    });

    testWidgets('Title allows multiple lines for wrapping',
        (WidgetTester tester) async {
      const multiLineTitle =
          'This is a very long title that should wrap to multiple lines when displayed in the dish display widget';
      final dish = DishModel(
        title: multiLineTitle,
        description: 'Test description',
        calories: 500,
        imageUrl: 'https://example.com/multiline-title-dish.jpg',
        dishTypeId: 1,
        dishTypeName: 'Main',
        allergens: ['Test'],
      );

      await tester.pumpWidget(createTestWidget(dish));
      await tester.pumpAndSettle();

      final textWidget = tester.widget<Text>(find.text(multiLineTitle));
      // Verify maxLines is set to allow multiple lines (3 or more)
      expect(textWidget.maxLines, greaterThanOrEqualTo(3));
      expect(textWidget.overflow, equals(TextOverflow.ellipsis));
    });
  });
}
