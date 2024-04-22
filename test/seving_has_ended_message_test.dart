import 'package:flutter_test/flutter_test.dart';
import 'package:userapp/services/service_time_checker.dart';
import 'package:userapp/services/time_provider.dart'; 

void main() {
  group('ServiceTimeChecker', () {
    late MockTimeProvider mockTimeProvider;
    late ServiceTimeChecker serviceTimeChecker;

    setUp(() {
      // You need to initialize it with a specific time for each test
      mockTimeProvider = MockTimeProvider(mockCurrentTime: DateTime(2024, 4, 10, 21, 0));
      serviceTimeChecker = ServiceTimeChecker(mockTimeProvider);
    });

    test('should return true when time is after service end time', () {
      // Set the mock time to after the service end time
      mockTimeProvider.mockCurrentTime = DateTime(2024, 4, 10, 21, 0);
      expect(serviceTimeChecker.isServiceEnded(), isTrue);
    });

    test('should return false when time is before service end time', () {
      // Set the mock time to before the service end time
      mockTimeProvider.mockCurrentTime = DateTime(2024, 4, 10, 20, 58);
      expect(serviceTimeChecker.isServiceEnded(), isFalse);
    });
  });
}

// MockTimeProvider should simply override the getCurrentTime method
class MockTimeProvider extends TimeProvider {
  DateTime mockCurrentTime;

  MockTimeProvider({required this.mockCurrentTime});

  @override
  DateTime getCurrentTime() => mockCurrentTime;
}
