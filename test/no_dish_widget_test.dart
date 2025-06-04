import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:junkfood/l10n/app_localizations.dart';
import 'package:junkfood/ui/widgets/no_dish_widget.dart';

void main() {
  testWidgets('no_dish_component_displays_no_dish_text_when_no_dishes',
      (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: [AppLocalizations.delegate],
        locale: Locale('en'),
        home: NoDishWidget(),
      ),
    );

    // Act
    final textFinder =
        find.text('Todays menu is not ready yet. Please check back later.');

    // Assert
    expect(textFinder, findsOneWidget);
  });
}
