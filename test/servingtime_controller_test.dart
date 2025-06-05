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
  test('should return true when time is after service end time', () {
    //Arrange
    final container = createContainer();
    //Act
    var result = container
        .read(servingtimeControllerProvider.notifier)
        .hasServiceEnded(DateTime(2024, 4, 10, 2, 1));
    //Assert
    expect(result, isTrue);
  });

  test('should return false when time is before service end time', () {
    //Arrange
    final container = createContainer();
    //Act
    var result = container
        .read(servingtimeControllerProvider.notifier)
        .hasServiceEnded(DateTime(2024, 4, 10, 1, 58));
    //Assert
    expect(result, isFalse);
  });
}
