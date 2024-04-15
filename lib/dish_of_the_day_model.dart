import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:userapp/domain/model/dish_model.dart';

class DishOfTheDayModel extends ChangeNotifier {
  final SupabaseClient database;
  DishOfTheDayModel({required this.database});
  List<DishModel> _dishOfTheDay = [];
  Map<int, String> _dishTypeMap = {};

  Future<void> fetchDishOfTheDay() async {
    Future.microtask(() async {
      List<DishModel> dishes = await database
          .from("Dish_Schedule")
          .select(
              "Dishes(id, title, description, calories, Dish_type(id, dish_type), image)")
          .filter("date", "eq", DateTime.now().toIso8601String())
          .then((rows) =>
              rows.map((json) => DishModel.fromJson(json["Dishes"])).toList());
      for (DishModel dish in dishes) {
        var allergens = await database
          .from("Allergens_to_Dishes")
          .select(
            "Allergens(allergen_name)")
          .filter("dish_id", "eq", dish.id)
          .then((rows) => 
            rows.map((json) => json["Allergens"]["allergen_name"].toString()).toList());
        dish.allergens = allergens;
      }
      dishes.sort(((a, b) => a.dishTypeId.compareTo(b.dishTypeId)));
      _dishOfTheDay = dishes;
      notifyListeners();
    });
  }

  // Future.microtask(() async {
  //   var response = await database.rpc('get_dishes_of_current_day');
  //   print(response);
  //   if (response != null) {
  //     _dishOfTheDay.add(DishModel.fromJson(response));
  //   } else {
  //     _dishOfTheDay = List.empty();
  //   }
  //   notifyListeners();
  // });

  Future<void> fetchDishTypeMap() async {
    Future.microtask(() async {
      var response = await database.from("Dish_type").select();
      if (response.isNotEmpty) {
        Map<int, String> fetchedDishTypes = {};
        for (var row in response) {
          fetchedDishTypes[row['id']] = row['dish_type'];
        }
        for (var fetchedDishTypeKey in fetchedDishTypes.keys) {
          bool exists = false;
          for (var existingDishTypeKey in _dishTypeMap.keys) {
            if (fetchedDishTypeKey == existingDishTypeKey) {
              exists = true;
              break;
            }
          }
          if (!exists) {
            _dishTypeMap[fetchedDishTypeKey] =
                fetchedDishTypes[fetchedDishTypeKey].toString();
          }
        }
      } else {
        _dishTypeMap = {};
      }
      notifyListeners();
    });
  }

  List<DishModel> get dishOfTheDay {
    if (_dishOfTheDay.isNotEmpty) {
      return _dishOfTheDay;
    } else {
      return [DishModel(title: "There is no dish of the day")];
    }
  }

  Map<int, String> get dishTypeMap {
    if (_dishTypeMap.isNotEmpty) {
      return _dishTypeMap;
    } else {
      return {};
    }
  }

  Future<bool> get hasDishOfTheDay async {
    if (_dishOfTheDay.isEmpty) {
      await fetchDishOfTheDay();
    }

    // if (_dishOfTheDay.isEmpty) {
    //   _dishOfTheDay.add(DishModel(
    //     title: 'Flæskesteg',
    //     description: 'Flæskesteg med brunede kartofler og sovs.',
    //     calories: 200,
    //     imageUrl:
    //         'https://voresmad.dk/-/media/voresmad/recipes/f/flaeskesteg-af-svinekam-med-sproedt-svaer-og-traditionelt-tilbehoer2.jpg',
    //     dishType: "Main course",
    //   ));
    //   _dishOfTheDay.add(DishModel(
    //     title: 'Knolselleri-steg',
    //     description: 'Vegetarisk alternativ til flæskesteg',
    //     calories: 10,
    //     imageUrl:
    //         'https://cdn.sanity.io/images/2aoj8j2d/gastrologik/a7d05b4deaaacc0ab9f55f821ad61c8c38d12692-2048x1365.jpg?rect=1,0,2047,1365&w=1024&h=683&auto=format',
    //     dishType: "Main course",
    //   ));
    //   _dishOfTheDay.add(DishModel(
    //     title: 'Vaffelis',
    //     description: 'Lækker dessert, mulighed for chokolade- og vaniljesmag',
    //     calories: 5000,
    //     imageUrl:
    //         'https://miro.medium.com/v2/resize:fit:1400/format:webp/1*9Lhb5e44WqRdM50iJ1T-XA.jpeg',
    //     dishType: "Dessert",
    //   ));
    // }
    return _dishOfTheDay.isNotEmpty;
  }

  Future<DishModel> fetchDishById(int id) async {
    var response = await database.from("Dishes").select('''
        *,
        "Dish_type" (dish_type)
        ''').filter("id", "eq", id);
    print(response.toString());
    DishModel dish = DishModel.fromJson(response[0]);
    return dish;
  }
}
