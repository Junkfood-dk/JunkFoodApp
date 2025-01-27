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

  bool hasServiceEnded(DateTime time) {
    final startTime = DateTime(time.year, time.month, time.day, 20, 59);
    final endTime = DateTime(time.year, time.month, time.day, 24, 00);
    return time.isAfter(startTime) && time.isBefore(endTime);
  }
}
