import 'package:userapp/services/time_provider.dart';

class MockTimeProvider extends TimeProvider {
  final DateTime fakeTime;

  MockTimeProvider(this.fakeTime);

  @override 
  DateTime getCurrentTime() {
    return fakeTime;
  }
}