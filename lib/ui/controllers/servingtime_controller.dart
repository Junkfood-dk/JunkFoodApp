import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'servingtime_controller.g.dart';

@riverpod
class ServingtimeController extends _$ServingtimeController {
  @override
  FutureOr<bool> build() {
    return hasServiceEnded(DateTime.now());
  }

  void checkIfServiceHasEnded() {
    state = AsyncData(hasServiceEnded(DateTime.now()));
  }

  /// If time is after 24:00 (midnight), but before 04:00 AM, the service has ended.
  bool hasServiceEnded(DateTime time) {
    return time.hour >= 0 && time.hour <= 3;
  }
}
