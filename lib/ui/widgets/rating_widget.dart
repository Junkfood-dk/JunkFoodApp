import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:junkfood/domain/model/dish_model.dart';
import 'package:junkfood/ui/controllers/dish_rating_controller.dart';
import 'package:junkfood/ui/pages/acknowledge_rating_page.dart';
import 'package:junkfood/utilities/widgets/gradiant_button_widget.dart';
import 'package:junkfood/utilities/widgets/gradiant_wrapper.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RatingWidget extends HookConsumerWidget {
  final DishModel dish;

  const RatingWidget({super.key, required this.dish});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var ratingController = ref.watch(dishRatingControllerProvider.notifier);
    var rating = useState(-1);

    return Column(children: [
      SizedBox(height: MediaQuery.of(context).size.height * 0.06),
      BodyBoldText(text: AppLocalizations.of(context)!.ratingTitle),
      BodyText(
          text: AppLocalizations.of(context)!.ratingFeedback,
          textAlign: TextAlign.center),
      SizedBox(height: MediaQuery.of(context).size.height * 0.05),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        // SAD BUTTON
        Opacity(
          opacity: (rating.value == -1 || rating.value == 0 ? 1 : 0.3),
          child: PrimaryGradiantWidget(
            child: IconButton(
              icon: Icon(Icons.sentiment_dissatisfied_rounded,
                  size: MediaQuery.of(context).size.height * 0.1),
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
              icon: Icon(Icons.sentiment_neutral_rounded,
                  size: MediaQuery.of(context).size.height * 0.1),
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
              icon: Icon(Icons.sentiment_satisfied_alt_rounded,
                  size: MediaQuery.of(context).size.height * 0.1),
              onPressed: () {
                rating.value = 2;
              },
            ),
          ),
        )
      ]),
      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
      SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.08,
          child: GradiantButton(
              onPressed: rating.value == -1
                  ? null
                  : () async {
                      var isRatingForDishDifferent = await ratingController
                          .isRatingForDishDifferent(dish.id, rating.value);
                      if (isRatingForDishDifferent) {
                        var wishToChange = await updateRating(context);
                        if (wishToChange!) {
                          ratingController.setUserRating(dish.id, rating.value);
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => const AcknowledgeRatingPage(),
                          ));
                        }
                      } else {
                        ratingController.setUserRating(dish.id, rating.value);
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const AcknowledgeRatingPage(),
                        ));
                        // Navigator.pop(context);
                      }
                    },
              child: ButtonText(
                text: AppLocalizations.of(context)!.ratingContinue,
              )))
    ]);
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
                  textAlign: TextAlign.center),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context,
                              true); // UPDATE THE RATING FUNCTIONALITY WILL GO HERE
                        },
                        child: BodyText(
                          text: AppLocalizations.of(context)!.yes,
                        )),
                  ),
                  const SizedBox(width: 15),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: GradiantButton(
                        onPressed: () {
                          Navigator.pop(
                              context, false); // GO BACK AND DO NOT UPDATE
                        },
                        child: BodyText(
                          text: AppLocalizations.of(context)!.no,
                        )),
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
