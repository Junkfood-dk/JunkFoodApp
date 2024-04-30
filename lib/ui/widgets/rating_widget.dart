import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/data/rating_repository.dart';
import 'package:userapp/domain/model/dish_model.dart';
import 'package:userapp/ui/controllers/rating_controller.dart';
import 'package:userapp/ui/controllers/shared_preference_controller.dart';
import 'package:userapp/utilities/widgets/gradiant_button_widget.dart';
import 'package:userapp/utilities/widgets/gradiant_wrapper.dart';
import 'package:userapp/utilities/widgets/text_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RatingWidget extends ConsumerWidget {
  final DishModel dish;

  const RatingWidget({super.key, required this.dish});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var prefs = ref.watch(sharedPreferencesControllerProvider.notifier);
    var rating = ref.watch(ratingControllerProvider);

    void setLocalRating(int rating) {
      prefs.setUserId();
      prefs.setUserRating(rating);
    }

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
          opacity: (rating == -1 || rating == 0 ? 1 : 0.3),
          child: PrimaryGradiantWidget(
            child: IconButton(
              icon: Icon(Icons.sentiment_dissatisfied_rounded,
                  size: MediaQuery.of(context).size.height * 0.1),
              onPressed: () {
                setLocalRating(0);
                ref.read(ratingControllerProvider.notifier).changeRating(0);
              },
            ),
          ),
        ),
        Opacity(
          // NEUTRAL BUTTON
          opacity: (rating == -1 || rating == 1 ? 1 : 0.3),
          child: PrimaryGradiantWidget(
            child: IconButton(
              icon: Icon(Icons.sentiment_neutral_rounded,
                  size: MediaQuery.of(context).size.height * 0.1),
              onPressed: () {
                setLocalRating(1);
                ref.read(ratingControllerProvider.notifier).changeRating(1);
              },
            ),
          ),
        ), // HAPPY BUTTON
        Opacity(
          opacity: (rating == -1 || rating == 2 ? 1 : 0.3),
          child: PrimaryGradiantWidget(
            child: IconButton(
              icon: Icon(Icons.sentiment_satisfied_alt_rounded,
                  size: MediaQuery.of(context).size.height * 0.1),
              onPressed: () {
                setLocalRating(2);
                ref.read(ratingControllerProvider.notifier).changeRating(2);
              },
            ),
          ),
        )
      ]),
      SizedBox(height: MediaQuery.of(context).size.height * 0.1),
      Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.08,
          child: GradiantButton(
              child: ButtonText(
                text: AppLocalizations.of(context)!.ratingContinue,
              ),
              onPressed: ref.watch(ratingControllerProvider) == -1
                  ? null
                  : () {
                      ref
                          .read(ratingRepositoryProvider)
                          .postNewRating(rating, dish.id);
                    }))
    ]);
  }
}
