import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:junkfood/ui/controllers/servingtime_controller.dart';

ProviderContainer createContainer({
  ProviderContainer? parent,
  List<Override> overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

void main() {
  group('hasServiceEnded', () {
    late ProviderContainer container;

    setUp(() {
      container = createContainer();
    });

    group('should return true when service has ended', () {
      test('at midnight (00:00)', () {
        //Arrange & Act
        var result = container
            .read(servingtimeControllerProvider.notifier)
            .hasServiceEnded(DateTime(2024, 4, 10, 0, 0));
        //Assert
        expect(result, isTrue);
      });

      test('at 00:01 AM', () {
        //Arrange & Act
        var result = container
            .read(servingtimeControllerProvider.notifier)
            .hasServiceEnded(DateTime(2024, 4, 10, 0, 1));
        //Assert
        expect(result, isTrue);
      });

      test('at 01:30 AM', () {
        //Arrange & Act
        var result = container
            .read(servingtimeControllerProvider.notifier)
            .hasServiceEnded(DateTime(2024, 4, 10, 1, 30));
        //Assert
        expect(result, isTrue);
      });

      test('at 02:00 AM', () {
        //Arrange & Act
        var result = container
            .read(servingtimeControllerProvider.notifier)
            .hasServiceEnded(DateTime(2024, 4, 10, 2, 0));
        //Assert
        expect(result, isTrue);
      });

      test('at 03:59 AM', () {
        //Arrange & Act
        var result = container
            .read(servingtimeControllerProvider.notifier)
            .hasServiceEnded(DateTime(2024, 4, 10, 3, 59));
        //Assert
        expect(result, isTrue);
      });
    });

    group('should return false when service is active', () {
      test('at 04:00 AM', () {
        //Arrange & Act
        var result = container
            .read(servingtimeControllerProvider.notifier)
            .hasServiceEnded(DateTime(2024, 4, 10, 4, 0));
        //Assert
        expect(result, isFalse);
      });

      test('at 04:01 AM', () {
        //Arrange & Act
        var result = container
            .read(servingtimeControllerProvider.notifier)
            .hasServiceEnded(DateTime(2024, 4, 10, 4, 1));
        //Assert
        expect(result, isFalse);
      });

      test('at 10:00 AM', () {
        //Arrange & Act
        var result = container
            .read(servingtimeControllerProvider.notifier)
            .hasServiceEnded(DateTime(2024, 4, 10, 10, 0));
        //Assert
        expect(result, isFalse);
      });

      test('at 18:00 PM', () {
        //Arrange & Act
        var result = container
            .read(servingtimeControllerProvider.notifier)
            .hasServiceEnded(DateTime(2024, 4, 10, 18, 0));
        //Assert
        expect(result, isFalse);
      });

      test('at 23:59 PM', () {
        //Arrange & Act
        var result = container
            .read(servingtimeControllerProvider.notifier)
            .hasServiceEnded(DateTime(2024, 4, 10, 23, 59));
        //Assert
        expect(result, isFalse);
      });
    });

    group('edge cases', () {
      test('boundary at 03:59:59 should return true', () {
        //Arrange & Act
        var result = container
            .read(servingtimeControllerProvider.notifier)
            .hasServiceEnded(DateTime(2024, 4, 10, 3, 59, 59));
        //Assert
        expect(result, isTrue);
      });

      test('boundary at 04:00:00 should return false', () {
        //Arrange & Act
        var result = container
            .read(servingtimeControllerProvider.notifier)
            .hasServiceEnded(DateTime(2024, 4, 10, 4, 0, 0));
        //Assert
        expect(result, isFalse);
      });
    });
  });
}
