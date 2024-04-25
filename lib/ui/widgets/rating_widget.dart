import 'package:flutter/material.dart';
import 'package:userapp/utilities/widgets/gradiant_wrapper.dart';

class RatingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Titel hvad synes du lak"),
      Text("fuck dig og dit feedback, du fik det gratis"),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        primaryGradiantWidget(
          child: IconButton(
            icon: Icon(Icons.sentiment_dissatisfied_rounded,
                size: MediaQuery.of(context).size.height * 0.1),
            onPressed: () {},
          ),
        ),
        primaryGradiantWidget(
          child: IconButton(
            icon: Icon(Icons.sentiment_neutral_rounded, size: MediaQuery.of(context).size.height * 0.1),
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
