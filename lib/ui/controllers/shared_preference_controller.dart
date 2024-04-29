import 'dart:math';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'shared_preference_controller.g.dart';

@riverpod 
class SharedPreferencesController extends _$SharedPreferencesController {
  SharedPreferences? prefs;
  @override
  Future<SharedPreferences?> build() async{
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  //If the user dos not have a a userId a new will be assigned and returned
  Future<int?> setUserId() async{
    var userId = prefs!.getInt('userId');
    if (userId != null) {
      return userId;
    } else {
      var random = Random();
      var newUserId = random.nextInt(1000000);
      prefs!.setInt('userId', newUserId);
      return newUserId;
    }
  }

  void setUserRating(int rating) async{
    prefs!.setInt('rating', rating);
  }
}