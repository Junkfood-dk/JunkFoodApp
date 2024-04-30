import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_guid/flutter_guid.dart';
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
  Future<Guid?> setUserId() async{
    var userId = prefs!.getString('userId');
    if (userId != null) {
      return Guid(userId);
    } else {
      var newId = Guid.newGuid;
      prefs!.setString('userId', newId.toString());
      return newId;
    }
  }

  void setUserRating(int rating) async{
    prefs!.setInt('rating', rating);
  }
}