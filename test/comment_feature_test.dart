import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junkfood/data/comments_repository.dart';
import 'package:junkfood/utilities/widgets/comments_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockCommentRepository extends Mock implements CommentRepository {}

void main() {
  late MockCommentRepository mockCommentRepository;

  setUpAll(() {
    mockCommentRepository = MockCommentRepository();
  });

  testWidgets('Displays an error when submitting an empty comment',
      (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        commentRepositoryProvider.overrideWithValue(mockCommentRepository),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: CommentPage(),
      ),
    ));

    await tester.tap(find.byType(ElevatedButton));
    await tester.pumpAndSettle();

    expect(find.text('Comment Field must be filled out'), findsOneWidget);
  });

  testWidgets('Comment field is empty at initialization',
      (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(
      overrides: [
        commentRepositoryProvider.overrideWithValue(mockCommentRepository),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: CommentPage(),
      ),
    ));

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    TextField textField = tester.widget(textFieldFinder);
    expect(textField.controller!.text, isEmpty);
  });
}
