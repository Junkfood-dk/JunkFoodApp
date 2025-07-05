import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_provider.g.dart';

@riverpod
class DateProvider extends _$DateProvider {
  @override
  DateTime build() {
    return DateTime.now();
  }

  void nextDay() {
    state = state.add(const Duration(days: 1));
  }

  void previousDay() {
    state = state.subtract(const Duration(days: 1));
  }

  void setDate(DateTime date) {
    state = date;
  }

  void resetToToday() {
    state = DateTime.now();
  }
}