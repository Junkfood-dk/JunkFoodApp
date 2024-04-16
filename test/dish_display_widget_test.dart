import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:userapp/domain/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/ui/widgets/dish_display_widget.dart';

void main() {
//Test if locale changes when language is selected in dropdown-menu
  testWidgets('dish_display_component_displays_nothing_when_no_dishes',
      (WidgetTester tester) async {
    //Arrange
    List<DishModel> testData = List.empty();
    await tester.pumpWidget(MaterialApp(
      home: DishDisplayWidget(
        dishes: testData,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    ));

    //Act
    final carouselFinder = find.byType(FlutterCarousel);
    final carouselWidget = tester.widget<FlutterCarousel>(carouselFinder);

    //Assert
    expect(carouselFinder, findsOneWidget);
    expect(carouselWidget.items, isEmpty);
  });

  testWidgets('dish_display_component_displays_one_card_when_one_dish',
      (WidgetTester tester) async {
    //Arrange
    List<DishModel> testData = [
      DishModel(
        title: 'Test ret',
        description: 'En ret til at teste med',
        calories: 200,
        imageUrl: 'https://testurl.jpg',
        dishTypeId: 0,
        dishTypeName: "Test dishtype",
      )
    ];

    await tester.pumpWidget(MaterialApp(
      home: DishDisplayWidget(
        dishes: testData,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    ));

    //Act
    final cardFinder = find.byType(Card);

    //Assert
    expect(cardFinder, findsExactly(1));
  });

  testWidgets('dish_display_component_displays_multiple_cards_when_multiple dishes',
      (WidgetTester tester) async {
    //Arrange
    List<DishModel> testData = [
      DishModel(
        title: 'Test ret',
        description: 'En ret til at teste med',
        calories: 200,
        imageUrl: 'https://testurl.jpg',
        dishTypeId: 0,
        dishTypeName: "Test dishtype",
      ),
      DishModel(
        title: 'Test ret2',
        description: 'En ret til at teste med',
        calories: 200,
        imageUrl: 'https://testurl.jpg',
        dishTypeId: 0,
        dishTypeName: "Test dishtype",
      )
    ];

    await tester.pumpWidget(MaterialApp(
      home: DishDisplayWidget(
        dishes: testData,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    ));

    //Act
    final cardFinder = find.byType(Card);

    //Assert
    expect(cardFinder, findsExactly(2));
  });

  testWidgets('dish_display_component_displays_information_from_fetched_data',
      (WidgetTester tester) async {
    //Arrange
    List<DishModel> testData = [
      DishModel(
          title: 'Test ret',
          description: 'En ret til at teste med',
          calories: 200,
          imageUrl: 'https://testurl.jpg',
          dishTypeId: 0,
          dishTypeName: "Test dishtype",
          allergens: ["test allergen"])
    ];

    await tester.pumpWidget(MaterialApp(
      home: DishDisplayWidget(
        dishes: testData,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    ));

    //Act
    final titleFinder = find.text('Test ret');
    final dishTypeFinder = find.text('Test dishtype');
    final caloriesFinder = find.text('200');
    final allergenFinder = find.text('test allergen');

    //Assert
    expect(titleFinder, findsExactly(1));
    expect(dishTypeFinder, findsExactly(1));
    expect(caloriesFinder, findsExactly(1));
    expect(allergenFinder, findsExactly(1));
  });

  testWidgets(
      'dish_display_component_displays_information_from_fetched_data_when_bad_data',
      (WidgetTester tester) async {
    //Arrange
    List<DishModel> testData = [
      DishModel(
          title: "",
          description: "",
          calories: 0,
          imageUrl: 'https://testurl.jpg',
          dishTypeId: -1,
          dishTypeName: "",
          allergens: [])
    ];

    await tester.pumpWidget(MaterialApp(
      home: DishDisplayWidget(
        dishes: testData,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('en'),
      supportedLocales: AppLocalizations.supportedLocales,
    ));

    //Act
    final titleFinder = find.text('No title');
    final dishTypeFinder = find.text('No dishtype');
    final caloriesFinder = find.text('No calories');
    final allergenFinder = find.text('No allergens');

    //Assert
    expect(titleFinder, findsExactly(1));
    expect(dishTypeFinder, findsExactly(1));
    expect(caloriesFinder, findsExactly(1));
    expect(allergenFinder, findsExactly(1));
  });
}
