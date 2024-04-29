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

  void setUserId() async{
    var random = Random();
    var userId = random.nextInt(1000000);
    prefs!.setInt('userId', userId);
  }

  void setUserRating(int rating) async{
    prefs!.setInt('rating', rating);
  }

  int? getUserId() {
    var userId = prefs!.getInt('userId');
    if(userId != 0){
      return userId;
    } else {
      return 0;
    }
  }
}