import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:junkfood/data/rating_repository.dart';
import 'package:junkfood/domain/model/dish_model.dart';
import 'package:junkfood/ui/controllers/locale_controller.dart';
import 'package:junkfood/ui/pages/acknowledge_rating_page.dart';
import 'package:junkfood/ui/widgets/rating_widget.dart';
import 'package:junkfood/utilities/widgets/gradiant_button_widget.dart';
import 'package:junkfood/utilities/widgets/gradiant_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'acknowledge_rating_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<RatingRepository>()])
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
    final mockRatingRepository = MockRatingRepository();
    when(mockRatingRepository.postNewRating(1, 0))
        .thenAnswer((realInvocation) => Future(() => 1));
    when(mockRatingRepository.updateRating(1, 1, 0))
        .thenAnswer((realInvocation) => Future(() => 1));
    await tester.pumpWidget(ProviderScope(
        overrides: [
          ratingRepositoryProvider.overrideWithValue(mockRatingRepository),
        ],
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
