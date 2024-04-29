import 'package:userapp/domain/model/dish_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/utilities/theming/text_theming.dart';
import 'package:userapp/utilities/widgets/gradiant_button_widget.dart';
import 'package:userapp/utilities/widgets/text_wrapper.dart';

class DishDisplayWidget extends StatelessWidget {
  final DishModel dish;
  const DishDisplayWidget({super.key, required this.dish});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.bottomLeft,
              children: [
                ShaderMask(
                  blendMode: BlendMode.srcOver,
                  shaderCallback: (bounds) => LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.center,
                      colors: [
                        Color.fromRGBO(99, 99, 99, 1),
                        Colors.transparent
                      ]).createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: AspectRatio(
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
                ),
                if (dish.title != "")
                  Positioned(
                    width: MediaQuery.of(context).size.width < 650
                        ? MediaQuery.of(context).size.width * 0.8
                        : 650,
                    top: MediaQuery.of(context).size.width < 650
                        ? MediaQuery.of(context).size.width * ((9 / 16) * 0.8)
                        : 650 * ((9 / 16) * 0.9),
                    height: MediaQuery.of(context).size.width < 650
                        ? MediaQuery.of(context).size.width * ((9 / 16) * 0.4)
                        : 650 * ((9 / 16) * 0.4),
                    left: 16,
                    child: MediaQuery.of(context).size.width > 370
                        ? DisplayMediumText(
                            text: dish.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis)
                        : BodyBoldText(
                            text: dish.title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                  )
                else
                  Text(AppLocalizations.of(context)!.noTitle),
              ]),
          SizedBox(
            height: MediaQuery.of(context).size.width < 650
                ? MediaQuery.of(context).size.width * ((9 / 16) * 0.2)
                : 650 * ((9 / 16) * 0.2),
          ),
          FittedBox(
            child: Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyText(
                      text: dish.description != ""
                          ? dish.description
                          : AppLocalizations.of(context)!.noDescription),
                  BodyBoldText(
                    text: "${AppLocalizations.of(context)!.calories}:",
                  ),
                  BodyText(
                      text: dish.calories > 0
                          ? "${dish.calories}"
                          : AppLocalizations.of(context)!.noCalories),
                  Divider(),
                  BodyBoldText(
                    text: "${AppLocalizations.of(context)!.allergens}:",
                  ),
                  dish.allergens.isNotEmpty
                      ? Row(
                          children: dish.allergens.map((allergen) {
                          bool isLast = allergen == dish.allergens.last;
                          return BodyText(
                              text: allergen + (!isLast ? " • " : ""));
                        }).toList())
                      : Text(AppLocalizations.of(context)!.noAllergens),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: gradiantButton(
                          child: Text(
                              AppLocalizations.of(context)!.rateButtonText,
                              style: appTextTheme.labelMedium),
                          onPressed: () {}))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
