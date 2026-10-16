import 'package:flutter_test/flutter_test.dart';
import 'package:junkfood/providers/date_provider.dart';

void main() {
  group('servingDay', () {
    test('returns the previous day at midnight (00:00)', () {
      final result = servingDay(DateTime(2024, 4, 10, 0, 0));
      expect(
        DateTime(result.year, result.month, result.day),
        DateTime(2024, 4, 9),
      );
    });

    test('returns the previous day at 03:59', () {
      final result = servingDay(DateTime(2024, 4, 10, 3, 59));
      expect(
        DateTime(result.year, result.month, result.day),
        DateTime(2024, 4, 9),
      );
    });

    test('returns the previous month across a month boundary', () {
      final result = servingDay(DateTime(2024, 5, 1, 1, 30));
      expect(
        DateTime(result.year, result.month, result.day),
        DateTime(2024, 4, 30),
      );
    });

    test('returns the same day at 04:00', () {
      final now = DateTime(2024, 4, 10, 4, 0);
      expect(servingDay(now), now);
    });

    test('returns the same day at 23:59', () {
      final now = DateTime(2024, 4, 10, 23, 59);
      expect(servingDay(now), now);
    });
  });
}
