import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'date_provider.g.dart';

/// The hour at which a new serving day begins.
///
/// Serving at some locations continues past midnight, so before this hour
/// the previous day's menu is shown.
const servingDayStartHour = 4;

/// Returns the serving day for [now], which is the previous day before
/// [servingDayStartHour].
DateTime servingDay(DateTime now) {
  if (now.hour >= servingDayStartHour) return now;
  return DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);
}

@riverpod
class DateProvider extends _$DateProvider {
  @override
  DateTime build() {
    return servingDay(DateTime.now());
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
    state = servingDay(DateTime.now());
  }
}
