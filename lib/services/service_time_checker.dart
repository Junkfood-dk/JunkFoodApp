import 'package:userapp/services/time_provider.dart';

class ServiceTimeChecker {
  final TimeProvider timeProvider;

  ServiceTimeChecker(this.timeProvider);

  bool isServiceEnded() {
    final now = timeProvider.getCurrentTime();
    final startTime = DateTime(now.year, now.month, now.day, 20, 59);
    final endTime = DateTime(now.year, now.month, now.day, 24, 00);
    return now.isAfter(startTime) && now.isBefore(endTime);
  }
}
