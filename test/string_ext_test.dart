import 'package:flutter_test/flutter_test.dart';
import 'package:junkfood/extensions/string_ext.dart';

void main() {
  group('StringExtensions toSentenceCase', () {
    test('converts all caps to sentence case', () {
      expect('GRILLED CHICKEN WITH VEGETABLES'.toSentenceCase(),
          'Grilled chicken with vegetables',);
    });

    test('converts title case to sentence case', () {
      expect('Grilled Chicken With Vegetables'.toSentenceCase(),
          'Grilled chicken with vegetables',);
    });

    test('converts lowercase to sentence case', () {
      expect('grilled chicken with vegetables'.toSentenceCase(),
          'Grilled chicken with vegetables',);
    });

    test('handles single word titles', () {
      expect('PASTA'.toSentenceCase(), 'Pasta');
      expect('pasta'.toSentenceCase(), 'Pasta');
      expect('Pasta'.toSentenceCase(), 'Pasta');
    });

    test('handles empty string', () {
      expect(''.toSentenceCase(), '');
    });

    test('handles titles starting with numbers', () {
      expect('123 SPECIAL DISH'.toSentenceCase(), '123 Special dish');
      expect('3-COURSE MEAL'.toSentenceCase(), '3-Course meal');
    });

    test('handles titles starting with special characters', () {
      expect('!AMAZING DISH'.toSentenceCase(), '!Amazing dish');
      expect('[PREMIUM] STEAK'.toSentenceCase(), '[Premium] steak');
      expect('(VEGETARIAN) PASTA'.toSentenceCase(), '(Vegetarian) pasta');
    });

    test('handles titles with accented characters', () {
      expect('CAFÉ AU LAIT'.toSentenceCase(), 'Café au lait');
      expect('NAÏVE APPROACH'.toSentenceCase(), 'Naïve approach');
      expect('PIÑA COLADA'.toSentenceCase(), 'Piña colada');
    });

    test('handles titles with mixed special characters and letters', () {
      expect('123!CAFÉ SPECIAL'.toSentenceCase(), '123!Café special');
      expect('***PREMIUM DISH***'.toSentenceCase(), '***Premium dish***');
    });

    test('handles titles with only special characters', () {
      expect('123!@#'.toSentenceCase(), '123!@#');
      expect('***'.toSentenceCase(), '***');
    });

    test('handles Danish characters', () {
      expect('KØDBOLLER MED ÆG'.toSentenceCase(), 'Kødboller med æg');
      expect('SMØRREBRØD'.toSentenceCase(), 'Smørrebrød');
      expect('FÅR OG ÅLEKAGE'.toSentenceCase(), 'Får og ålekage');
    });

    test('preserves formatting for already correct sentence case', () {
      expect('Grilled chicken with vegetables'.toSentenceCase(),
          'Grilled chicken with vegetables');
    });

    test('handles very long titles', () {
      const longTitle = 'THIS IS A VERY LONG DISH TITLE THAT CONTAINS MANY WORDS AND SHOULD BE HANDLED CORRECTLY BY THE SENTENCE CASE FUNCTION';
      const expected = 'This is a very long dish title that contains many words and should be handled correctly by the sentence case function';
      expect(longTitle.toSentenceCase(), expected,);
    });
  });
}