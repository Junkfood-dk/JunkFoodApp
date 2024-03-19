import 'package:userapp/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DishDisplayComponent extends StatelessWidget {
  final List<DishModel> dish;
  final Map<int,String> dishTypeMap;
  const DishDisplayComponent({super.key, required this.dish, required this.dishTypeMap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: FlutterCarousel(
        options: CarouselOptions(
          height: 400.0,
          showIndicator: true,
          slideIndicator: CircularSlideIndicator(),
        ),
        items: dish.map((i) {
          return Builder(
            builder: (BuildContext context) {
              return SizedBox(
                // Wrap the Card with SizedBox
                width: MediaQuery.of(context).size.width *
                    0.8, // Specify desired width
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Text(
                            i.dishType,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              child: Image.network(i.imageUrl),
                            ),
                          ),
                          Text(
                            i.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(i.description),
                          Text(AppLocalizations.of(context)!.calories + ": ${i.calories}"),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  String dishTypeTranslator(int dishType, BuildContext context) {
    return dishTypeMap[dishType] ??
        "Unknown"; // Using ?? operator to handle cases where id is not found
  }
}

// Map<int, String> dishTypeMap(BuildContext context) {
//   return {0: AppLocalizations.of(context)!.mainCourse, 1: AppLocalizations.of(context)!.dessert
//   };
// }

// String dishTypeTranslator(int id, BuildContext context) {
//   return dishTypeMap(context)[id] ??
//       "Unknown"; // Using ?? operator to handle cases where id is not found
// }
