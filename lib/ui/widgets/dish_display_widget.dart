import 'package:flutter/widgets.dart';
import 'package:userapp/domain/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DishDisplayWidget extends StatelessWidget {
  final DishModel dish;
  const DishDisplayWidget({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              Stack(children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(dish.imageUrl, fit: BoxFit.cover,
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
                if (dish.title != "")
                  Text(
                    dish.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  )
                else
                  Text(AppLocalizations.of(context)!.noTitle),
              ]),
              if (dish.description != "")
                Text(dish.description)
              else
                Text(AppLocalizations.of(context)!.noDescription),
              Text(
                "${AppLocalizations.of(context)!.calories}:",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (dish.calories > 0)
                Text("${dish.calories}")
              else
                Text(AppLocalizations.of(context)!.noCalories),
              Text(
                "${AppLocalizations.of(context)!.allergens}:",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              if (dish.allergens.isNotEmpty)
                for (var allergen in dish.allergens) Text(allergen)
              else
                Text(AppLocalizations.of(context)!.noAllergens)
            ],
          ),
        ],
      ),
    );
  }
}
