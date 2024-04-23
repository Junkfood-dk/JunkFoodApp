import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/ui/controllers/servingtime_controller.dart';

import 'servingtime_controller_test.mocks.dart';

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

@GenerateNiceMocks([MockSpec<ServingtimeController>()])
void main() {
  test('should return true when time is after service end time', () {
    //Arrange
    final container = createContainer();
    //Act
    var result = container
        .read(servingtimeControllerProvider.notifier)
        .hasServiceEnded(DateTime(2024, 4, 10, 21, 0));
    //Assert
    expect(result, isTrue);
  });

  test('should return false when time is before service end time', () {
    //Arrange
    final container = createContainer();
    //Act
    var result = container
        .read(servingtimeControllerProvider.notifier)
        .hasServiceEnded(DateTime(2024, 4, 10, 20, 58));
    //Assert
    expect(result, isFalse);
  });
}
