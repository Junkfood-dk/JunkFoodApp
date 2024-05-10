import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:userapp/domain/model/dish_model.dart';
import 'package:userapp/ui/controllers/dish_rating_controller.dart';
import 'package:userapp/ui/controllers/locale_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/ui/pages/acknowledge_rating_page.dart';
import 'package:userapp/ui/widgets/rating_widget.dart';
import 'package:userapp/utilities/widgets/gradiant_button_widget.dart';
import 'package:userapp/utilities/widgets/gradiant_wrapper.dart';

import 'acknowledge_rating_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DishRatingController>()])
void main() {
  testWidgets(
      'When pressing the continue-button the acknowledgement page will display',
      (WidgetTester tester) async {
    final dish = DishModel(
      id: 1,
      title: 'Test Dish',
      description: 'Test description',
      calories: 200,
      imageUrl: 'test_image_url',
      dishTypeId: 1,
      dishTypeName: 'Test Dish Type',
      allergens: ['Test Allergen 1', 'Test Allergen 2'],
    );
    final mockDishRatingController = MockDishRatingController();
    await mockDishRatingController.build();
    when(mockDishRatingController.setUserRating(1, 0))
        .thenAnswer((realInvocation) {});
    when(mockDishRatingController.isRatingForDishDifferent(1, 0))
        .thenAnswer((realInvocation) => Future(() => false));
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

    final ratingIconFinder = find.descendant(
        of: find.byType(PrimaryGradiantWidget),
        matching: find.byType(IconButton));

    final firstRatingIcon = ratingIconFinder.first;
    await tester.tap(firstRatingIcon);
    await tester.pumpAndSettle();
    final findContinueBtn = find.descendant(
      of: find.byType(GradiantButton),
      matching: find.text('Continue'),
    );
    await tester.tap(findContinueBtn);
    await tester.pumpAndSettle();
    expect(find.byType(AcknowledgeRatingPage), findsOneWidget);
  });
}
