import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:userapp/domain/model/dish_model.dart';
import 'package:userapp/ui/controllers/locale_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/ui/widgets/dish_display_widget.dart';
import 'package:userapp/ui/widgets/rating_widget.dart';
import 'package:userapp/utilities/widgets/gradiant_button_widget.dart';

@GenerateNiceMocks([MockSpec<DishModel>()])
void main() {
  testWidgets('DishDisplayWidget should display the rating button',
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
    await tester.pumpWidget(ProviderScope(
        child: Consumer(
      builder: (context, ref, child) => MaterialApp(
          locale: ref.watch(localeControllerProvider),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: DishDisplayWidget(dish: dish)),
    )));

    final gradientButtonFinder = find.descendant(
      of: find.byType(GradiantButton),
      matching: find.text('Rate this dish'),
    );

    // Expect one GradiantButton widget is found
    expect(gradientButtonFinder, findsOneWidget);
  });

  testWidgets('Clicking the rating button the rating button should display the rating widget',
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
    await tester.pumpWidget(ProviderScope(
        child: Consumer(
      builder: (context, ref, child) => MaterialApp(
          locale: ref.watch(localeControllerProvider),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: RatingWidget(dish: dish)),
    )));

    
  });
}
