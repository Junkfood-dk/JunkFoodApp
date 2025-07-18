import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junkfood/l10n/app_localizations.dart';
import 'package:mockito/annotations.dart';
import 'package:junkfood/domain/model/dish_model.dart';
import 'package:junkfood/ui/controllers/locale_controller.dart';
import 'package:junkfood/ui/widgets/rating_widget.dart';
import 'package:junkfood/utilities/widgets/gradiant_wrapper.dart';

@GenerateNiceMocks([MockSpec<DishModel>()])
void main() {
  testWidgets('The rating widget displays 3 icons for rating',
      (WidgetTester tester) async {
    final dish = DishModel(
      title: 'Test Dish',
      description: 'Test description',
      calories: 200,
      imageUrl: 'test_image_url',
      dishTypeId: 1,
      dishTypeName: 'Test Dish Type',
      allergens: ['Test Allergen 1', 'Test Allergen 2'],
    );
    await tester.pumpWidget(
      ProviderScope(
        child: Consumer(
          builder: (context, ref, child) => MaterialApp(
            locale: switch (ref.watch(localeControllerProvider)) {
              AsyncData(:final value) => value,
              _ => null
            },
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: RatingWidget(dish: dish),
          ),
        ),
      ),
    );

    final ratingIconFinder = find.descendant(
      of: find.byType(PrimaryGradiantWidget),
      matching: find.byType(IconButton),
    );

    expect(ratingIconFinder, findsExactly(3));
  });
}
