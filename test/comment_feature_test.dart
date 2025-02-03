import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junkfood/data/comments_repository.dart';
import 'package:junkfood/ui/pages/comments_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockCommentRepository extends Mock implements CommentRepository {}

void main() {
  late MockCommentRepository mockCommentRepository;

  setUpAll(() {
    mockCommentRepository = MockCommentRepository();
  });

  testWidgets('Comment field is empty at initialization',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
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
          home: CommentsPage(),
        ),
      ),
    );

    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    TextField textField = tester.widget(textFieldFinder);
    expect(textField.controller!.text, isEmpty);
  });
}
