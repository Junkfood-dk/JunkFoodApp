import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:userapp/components/dish_display_component.dart';
import 'package:userapp/components/language_dropdown_component.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:userapp/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/model/locale.dart';
import 'package:userapp/pages/dish_of_the_day.dart';

void main() {
//Test if locale changes when language is selected in dropdown-menu
  testWidgets('dish_display_component_displays_nothing_when_no_dishes',
      (WidgetTester tester) async {
    //Arrange
    List<DishModel> testData = List.empty();
    await tester
        .pumpWidget(MaterialApp(home: DishDisplayComponent(dishes: testData,)));

    //Act
    final carouselFinder = find.byType(FlutterCarousel);
    final carouselWidget = tester.widget<FlutterCarousel>(carouselFinder);

    //Assert
    expect(carouselFinder, findsOneWidget);
    expect(carouselWidget.items, isEmpty);
  });
}
