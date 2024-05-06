import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:userapp/data/comments_repository.dart';
import 'package:userapp/utilities/widgets/comments_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MockCommentRepository extends Mock implements CommentRepository {}

void main() {
  group('CommentPage Tests', () {
    late MockCommentRepository mockCommentRepository;

    setUp(() {
      mockCommentRepository = MockCommentRepository();
    });

    testWidgets('should display an error when submitting an empty comment', (WidgetTester tester) async {
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

    testWidgets('should call postComment when a valid comment is submitted', (WidgetTester tester) async {
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

      await tester.enterText(find.byType(TextField), 'A valid comment');
      await tester.pump(); 

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); 

      verify(mockCommentRepository.postComment('A valid comment')).called(1);
    });
  });
}
