import 'package:flutter_test/flutter_test.dart';
import 'package:userapp/components/no_dish_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
  testWidgets('no_dish_component_displays_no_dish_text_when_no_dishes',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(MaterialApp(
      localizationsDelegates: const[AppLocalizations.delegate],
      locale: Locale('en'),
      home: NoDishComponent()));

    // Act
    final textFinder =
        find.text('Todays menu is not ready yet. Please check back later.');

    // Assert
    expect(textFinder, findsOneWidget);
  });
}
