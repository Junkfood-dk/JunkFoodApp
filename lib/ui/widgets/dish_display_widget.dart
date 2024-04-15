import 'package:userapp/domain/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DishDisplayComponent extends StatelessWidget {
  final List<DishModel> dishes;
  const DishDisplayComponent.DishDisplayWidget(
      {super.key, required this.dishes});

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
                width: MediaQuery.of(context).size.width * 0.8,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          if (i.dishTypeName != "")
                            Text(
                              i.dishTypeName,
                              style: Theme.of(context).textTheme.headlineMedium,
                            )
                          else
                            Text(AppLocalizations.of(context)!.noDishType,
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
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
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                  // Display placeholder or error message when image loading fails
                                  return Container(
                                    color: Colors.grey, // Placeholder color
                                    child: const Center(
                                      child: Icon(
                                        Icons.error_outline,
                                        color: Colors.red, // Error icon color
                                        size: 48.0,
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          if (i.title != "")
                            Text(
                              i.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            )
                          else
                            Text(AppLocalizations.of(context)!.noTitle),
                          if (i.description != "")
                            Text(i.description)
                          else
                            Text(AppLocalizations.of(context)!.noDescription),
                          Text(
                            "${AppLocalizations.of(context)!.calories}:",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          if (i.calories > 0)
                            Text("${i.calories}")
                          else
                            Text(AppLocalizations.of(context)!.noCalories),
                          Text(
                            "${AppLocalizations.of(context)!.allergens}:",
                            style: const TextStyle(fontWeight: FontWeight.bold),
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
