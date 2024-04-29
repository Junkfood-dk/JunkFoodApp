import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/ui/controllers/rating_controller.dart';
import 'package:userapp/utilities/widgets/gradiant_button_widget.dart';
import 'package:userapp/utilities/widgets/gradiant_wrapper.dart';
import 'package:userapp/utilities/widgets/text_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RatingWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var rating = ref.watch(ratingControllerProvider);
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
          child: primaryGradiantWidget(
            child: IconButton(
              icon: Icon(Icons.sentiment_dissatisfied_rounded,
                  size: MediaQuery.of(context).size.height * 0.1),
              onPressed: () {
                ref.read(ratingControllerProvider.notifier).changeRating(0);
              },
            ),
          ),
        ),
        Opacity( // NEUTRAL BUTTON
          opacity: (rating == -1 || rating == 1 ? 1 : 0.3),
          child: primaryGradiantWidget(
            child: IconButton(
              icon: Icon(Icons.sentiment_neutral_rounded,
                  size: MediaQuery.of(context).size.height * 0.1),
              onPressed: () {
                ref.read(ratingControllerProvider.notifier).changeRating(1);
              },
            ),
          ),
        ), // HAPPY BUTTON
        Opacity(
          opacity: (rating == -1 || rating == 2 ? 1 : 0.3),
          child: primaryGradiantWidget(
            child: IconButton(
              icon: Icon(Icons.sentiment_satisfied_alt_rounded,
                  size: MediaQuery.of(context).size.height * 0.1),
              onPressed: () {
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
          child: gradiantButton(
              child: ButtonText(
                text: AppLocalizations.of(context)!.ratingContinue,
              ),
              onPressed: ref.watch(ratingControllerProvider)==-1 ? null : (){}))
    ]);
  }
}
