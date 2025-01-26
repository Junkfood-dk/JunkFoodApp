import 'package:flutter/material.dart';
import 'package:junkfood/domain/model/dish_model.dart';
import 'package:junkfood/ui/widgets/gradiant_button_widget.dart';
import 'package:junkfood/ui/widgets/rating_widget.dart';
import 'package:junkfood/utilities/widgets/sized_box_ext.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DishDisplayWidget extends StatelessWidget {
  final DishModel dish;

  const DishDisplayWidget({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.displayMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomLeft,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
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
            Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: DisplayMediumText(
                    text: dish.title.isNotEmpty
                        ? dish.title
                        : AppLocalizations.of(context)!.noTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: titleStyle,
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBoxExt.sizedBoxHeight16,
                BodyBoldText(
                  text: AppLocalizations.of(context)!.dishContents,
                ),
                SizedBoxExt.sizedBoxHeight8,
                ButtonText(
                  text: dish.description.isNotEmpty
                      ? dish.description
                      : AppLocalizations.of(context)!.noDescription,
                ),
                SizedBoxExt.sizedBoxHeight8,
                const Divider(
                  color: Colors.grey,
                ),
                BodyBoldText(
                  text: AppLocalizations.of(context)!.calories,
                ),
                BodyText(
                  text: dish.calories > 0
                      ? '${dish.calories}'
                      : AppLocalizations.of(context)!.noCalories,
                ),
                SizedBoxExt.sizedBoxHeight8,
                BodyBoldText(
                  text: AppLocalizations.of(context)!.allergens,
                ),
                SizedBoxExt.sizedBoxHeight8,
                dish.allergens.isNotEmpty
                    ? Row(
                        children: dish.allergens.map((allergen) {
                          bool isLast = allergen == dish.allergens.last;
                          return BodyText(
                            text: allergen + (!isLast ? ' • ' : ''),
                          );
                        }).toList(),
                      )
                    : Text(AppLocalizations.of(context)!.noAllergens),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 48.0, top: 8.0),
          child: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 48.0,
              // child: Text(AppLocalizations.of(context)!.rateButtonText),
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
