import 'package:flutter/material.dart';
import 'package:junkfood/domain/model/dish_model.dart';
import 'package:junkfood/ui/widgets/rating_widget.dart';
import 'package:junkfood/utilities/widgets/gradiant_button_widget.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DishDisplayWidget extends StatelessWidget {
  final DishModel dish;

  const DishDisplayWidget({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomLeft,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                dish.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // TODO: Add dummy image...
                  return Container(
                    color: Colors.grey,
                    child: const Center(
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.red,
                        size: 48.0,
                      ),
                    ),
                  );
                },
              ),
            ),
            if (dish.title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: DisplayMediumText(
                      text: dish.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    )),
              )
            else
              Text(AppLocalizations.of(context)!.noTitle),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ButtonText(
                    text: dish.description.isNotEmpty
                        ? dish.description
                        : AppLocalizations.of(context)!.noDescription,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  BodyBoldText(
                    text: AppLocalizations.of(context)!.calories,
                  ),
                  BodyText(
                    text: dish.calories > 0
                        ? "${dish.calories}"
                        : AppLocalizations.of(context)!.noCalories,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  BodyBoldText(
                    text: AppLocalizations.of(context)!.allergens,
                  ),
                  dish.allergens.isNotEmpty
                      ? Row(
                          children: dish.allergens.map((allergen) {
                            bool isLast = allergen == dish.allergens.last;
                            return BodyText(
                                text: allergen + (!isLast ? " • " : ""));
                          }).toList(),
                        )
                      : Text(AppLocalizations.of(context)!.noAllergens),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 48.0,
              child: GradiantButton(
                child: ButtonText(
                  text: AppLocalizations.of(context)!.rateButtonText,
                ),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return RatingWidget(dish: dish);
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
