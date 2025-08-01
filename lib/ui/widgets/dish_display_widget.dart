import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junkfood/domain/model/dish_model.dart';
import 'package:junkfood/l10n/app_localizations.dart';
import 'package:junkfood/ui/controllers/dish_controller.dart';
import 'package:junkfood/ui/controllers/dish_of_the_day_controller.dart';
import 'package:junkfood/extensions/sized_box_ext.dart';
import 'package:junkfood/extensions/string_ext.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';

class DishDisplayWidget extends ConsumerWidget {
  final DishModel dish;

  const DishDisplayWidget({super.key, required this.dish});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleStyle = Theme.of(context).textTheme.displayMedium?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        );

    // Set the current widget for rating
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .watch(
            dishControllerProvider.notifier,
          )
          .set(dish);
    });

    final title = dish.title.isNotEmpty
        ? dish.title.toSentenceCase()
        : AppLocalizations.of(context)!.noTitle;

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(dishOfTheDayControllerProvider.notifier).refetchDishOfTheDay();
      },
      child: ListView(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              SizedBox(
                width: double.infinity,
                height: 450,
                child: Image.network(
                  dish.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
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
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                    ),
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: DisplayMediumText(
                      text: title,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBoxExt.sizedBoxHeight16,
                ButtonText(
                  text: dish.description.isNotEmpty
                      ? dish.description
                      : AppLocalizations.of(context)!.noDescription,
                ),
                if (dish.calories > 0) ...[
                  SizedBoxExt.sizedBoxHeight8,
                  const Divider(
                    color: Colors.grey,
                  ),
                  BodyBoldText(
                    text: AppLocalizations.of(context)!.calories,
                  ),
                  BodyText(
                    text: '${dish.calories}',
                  ),
                ],
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
                SizedBoxExt.sizedBoxHeight24,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
