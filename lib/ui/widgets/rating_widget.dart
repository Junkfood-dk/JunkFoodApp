import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:junkfood/domain/model/dish_model.dart';
import 'package:junkfood/l10n/app_localizations.dart';
import 'package:junkfood/ui/controllers/dish_rating_controller.dart';
import 'package:junkfood/ui/pages/acknowledge_rating_page.dart';
import 'package:junkfood/utilities/widgets/gradiant_button_widget.dart';
import 'package:junkfood/utilities/widgets/gradiant_wrapper.dart';
import 'package:junkfood/extensions/sized_box_ext.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';

class RatingWidget extends HookConsumerWidget {
  final DishModel dish;

  const RatingWidget({super.key, required this.dish});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var ratingController = ref.watch(dishRatingControllerProvider.notifier);
    var rating = useState(-1);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBoxExt.sizedBoxHeight24,
          BodyBoldText(text: AppLocalizations.of(context)!.ratingTitle),
          BodyText(
            text: AppLocalizations.of(context)!.ratingFeedback,
            textAlign: TextAlign.center,
          ),
          SizedBoxExt.sizedBoxHeight24,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // SAD BUTTON
              Opacity(
                opacity: (rating.value == -1 || rating.value == 0 ? 1 : 0.3),
                child: PrimaryGradiantWidget(
                  child: IconButton(
                    icon: Icon(
                      Icons.sentiment_dissatisfied_rounded,
                      size: MediaQuery.of(context).size.height * 0.1,
                    ),
                    onPressed: () {
                      rating.value = 0;
                    },
                  ),
                ),
              ),
              Opacity(
                // NEUTRAL BUTTON
                opacity: (rating.value == -1 || rating.value == 1 ? 1 : 0.3),
                child: PrimaryGradiantWidget(
                  child: IconButton(
                    icon: Icon(
                      Icons.sentiment_neutral_rounded,
                      size: MediaQuery.of(context).size.height * 0.1,
                    ),
                    onPressed: () {
                      rating.value = 1;
                    },
                  ),
                ),
              ), // HAPPY BUTTON
              Opacity(
                opacity: (rating.value == -1 || rating.value == 2 ? 1 : 0.3),
                child: PrimaryGradiantWidget(
                  child: IconButton(
                    icon: Icon(
                      Icons.sentiment_satisfied_alt_rounded,
                      size: MediaQuery.of(context).size.height * 0.1,
                    ),
                    onPressed: () {
                      rating.value = 2;
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBoxExt.sizedBoxHeight24,
          GradiantButton(
            onPressed: rating.value == -1
                ? null
                : () async {
                    final navigator = Navigator.of(context);
                    final isRatingForDishDifferent = ratingController
                        .isRatingForDishDifferent(dish.id, rating.value);
                    bool? wishToChange = true;
                    if (isRatingForDishDifferent) {
                      wishToChange = await updateRating(context);
                    }
                    if (!isRatingForDishDifferent || (wishToChange ?? true)) {
                      ratingController.setUserRating(
                        dish.id,
                        rating.value,
                      );

                      navigator.pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const AcknowledgeRatingPage(),
                        ),
                      );
                    }
                  },
            child: ButtonText(
              text: AppLocalizations.of(context)!.ratingContinue,
            ),
          ),
          SizedBoxExt.sizedBoxHeight8,
        ],
      ),
    );
  }

  Future<bool?> updateRating(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) => Dialog(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BodyText(
                text: AppLocalizations.of(context)!.changeRating,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(
                          context,
                          true,
                        ); // UPDATE THE RATING FUNCTIONALITY WILL GO HERE
                      },
                      child: BodyText(
                        text: AppLocalizations.of(context)!.yes,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  GradiantButton(
                    width: MediaQuery.of(context).size.width * 0.2,
                    onPressed: () {
                      Navigator.pop(
                        context,
                        false,
                      ); // GO BACK AND DO NOT UPDATE
                    },
                    child: BodyText(
                      text: AppLocalizations.of(context)!.no,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
