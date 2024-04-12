import 'package:flutter_test/flutter_test.dart';
import 'package:userapp/components/no_dish_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() {
//Test if locale changes when language is selected in dropdown-menu
  testWidgets('no_dish_component_displays_no_dish_text_when_no_dishes',
      (WidgetTester tester) async {
    //Arrange
    await tester
        .pumpWidget(MaterialApp(home: NoDishComponent()));

    //Act
    final noDishText = AppLocalizations.of(context as BuildContext)?.noDishText;
    final textFinder = find.text(noDishText!);

    //Assert
    expect(textFinder, find.text("Todays menu is not ready yet. Please check back later."));
  });
}

mixin context {
}