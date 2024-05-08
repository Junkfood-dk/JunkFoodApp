import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:userapp/domain/model/language_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/ui/controllers/locale_controller.dart';
import 'package:userapp/ui/widgets/language_dropdown_widget.dart';

void main() {
  test('English is present in language list', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final bool englishExists =
        languages.any((language) => language.name == 'English');

    // Assert
    expect(englishExists, isTrue);
  });

  test('Spanish is not present in language list', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final bool englishExists =
        languages.any((language) => language.name == 'Spanish');

    // Assert
    expect(englishExists, isFalse);
  });

  test('Language object for English (id: 1) exists', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final Language englishLanguage =
        languages.firstWhere((language) => language.id == 1);

    // Assert
    expect(englishLanguage.name, equals('English'));
  });

  test('Language object for Danish (id: 2) exists', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final Language danishLanguage =
        languages.firstWhere((language) => language.id == 2);

    // Assert
    expect(danishLanguage.name, equals('Dansk'));
  });

  test('Language object with id 3000 does not exist', () {
    // Arrange
    final List<Language> languages = Language.languageList();

    // Act
    final bool id3Exists = languages.any((language) => language.id == 3000);

    // Assert
    expect(id3Exists, isFalse);
  });

  testWidgets('Language_dropdown_widget contains danish and english options',
      (WidgetTester tester) async {
    //Arrange
    await tester.pumpWidget(
      ProviderScope(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) =>
              MaterialApp(
            title: 'User app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: switch (ref.watch(localeControllerProvider)) {
              AsyncData(:final value) => value,
              _ => null
            },
            debugShowCheckedModeBanner: false,
            home: const LanguageDropdownWidget(),
          ),
        ),
      ),
    );

    //Act

    // Open the language dropdown.
    await tester.tap(find.byType(LanguageDropdownWidget));
    await tester.pumpAndSettle();

    final englishItemFinder = find.text('English');
    final danishItemFinder = find.text('Dansk');

    //Assert
    expect(englishItemFinder, findsOneWidget);
    expect(danishItemFinder, findsOneWidget);
  });

//Test if locale changes when language is selected in dropdown-menu
  testWidgets('Language_dropdown_widget changes locale when option is pressed',
      (WidgetTester tester) async {
    //Arrange
    await tester.pumpWidget(
      ProviderScope(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) =>
              MaterialApp(
            title: 'User app',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: switch (ref.watch(localeControllerProvider)) {
              AsyncData(:final value) => value,
              _ => null
            },
            debugShowCheckedModeBanner: false,
            home: const LanguageDropdownWidget(),
          ),
        ),
      ),
    );

    //Act
    Locale? initialLocale = Localizations.localeOf(
        tester.element(find.byType(LanguageDropdownWidget)));

    await tester.tap(
        find.byType(LanguageDropdownWidget)); // Open the language dropdown.
    await tester.pumpAndSettle();

    await tester.tap(find.text('Dansk'));
    await tester.pumpAndSettle();

    Locale? localeAfterDanishIsPressed = Localizations.localeOf(
        tester.element(find.byType(LanguageDropdownWidget)));

    await tester.tap(
        find.byType(LanguageDropdownWidget)); // Open the language dropdown.
    await tester.pumpAndSettle();

    await tester.tap(find.text('English'));
    await tester.pumpAndSettle();

    Locale? localeAfterEnglishIsPressed = Localizations.localeOf(
        tester.element(find.byType(LanguageDropdownWidget)));

    //Assert
    expect(initialLocale, equals(Locale('en')));
    expect(localeAfterDanishIsPressed, equals(Locale('da')));
    expect(localeAfterEnglishIsPressed, equals(Locale('en')));
  });
}
