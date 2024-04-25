import 'package:flutter/material.dart';
import 'package:userapp/utilities/widgets/gradiant_wrapper.dart';
import 'package:userapp/utilities/widgets/text_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RatingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BodyBoldText(text: AppLocalizations.of(context)!.ratingTitle),
      BodyText(
          text: AppLocalizations.of(context)!.ratingFeedback, textAlign: TextAlign.center),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        primaryGradiantWidget(
          child: IconButton(
            icon: Icon(Icons.sentiment_dissatisfied_rounded,
                size: MediaQuery.of(context).size.height * 0.1),
            onPressed: () {},
          ),
        ),
        primaryGradiantWidget(
          child: IconButton(
            icon: Icon(Icons.sentiment_neutral_rounded,
                size: MediaQuery.of(context).size.height * 0.1),
            onPressed: () {},
          ),
        ),
        primaryGradiantWidget(
          child: IconButton(
            icon: Icon(Icons.sentiment_satisfied_alt_rounded,
                size: MediaQuery.of(context).size.height * 0.1),
            onPressed: () {},
          ),
        )
      ])
    ]);
  }
}
