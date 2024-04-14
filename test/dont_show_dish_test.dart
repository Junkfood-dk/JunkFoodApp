import 'package:flutter_test/flutter_test.dart';
import 'package:userapp/components/no_dish_component.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('no_dish_component_displays_no_dish_text_when_no_dishes',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(home: NoDishComponent()));

    // Act
    final textFinder =
        find.text('Todays menu is not ready yet. Please check back later.');
        //Dagens ret er ikke offentliggjort endnu. Tjek siden senere.

    // Assert
    expect(textFinder, findsOneWidget);
  });
}
