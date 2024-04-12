import 'package:userapp/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DishDisplayComponent extends StatelessWidget {
  final List<DishModel> dishes;
  const DishDisplayComponent({super.key, required this.dishes});

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
        items: dishes.map((i) {
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
                            i.dishTypeName,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: Image.network(i.imageUrl,
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          Text(
                            i.title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(i.description),
                          Text(
                            AppLocalizations.of(context)!.calories + ":",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text("${i.calories}"),
                          Text(
                            AppLocalizations.of(context)!.allergens + ":",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (i.allergens.isNotEmpty)
                            for (var allergen in i.allergens) Text(allergen)
                          else
                            Text(AppLocalizations.of(context)!.noAllergens)
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
}

// Map<int, String> dishTypeMap(BuildContext context) {
//   return {0: AppLocalizations.of(context)!.mainCourse, 1: AppLocalizations.of(context)!.dessert
//   };
// }

// String dishTypeTranslator(int id, BuildContext context) {
//   return dishTypeMap(context)[id] ??
//       "Unknown"; // Using ?? operator to handle cases where id is not found
// }
