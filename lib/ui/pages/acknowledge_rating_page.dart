import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/utilities/theming/color_theme.dart';
import 'package:userapp/utilities/widgets/text_wrapper.dart';

class AcknowledgeRatingPage extends StatelessWidget {
  const AcknowledgeRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center content horizontally
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Image.network(
              'https://raw.githubusercontent.com/Junkfood-dk/JunkFoodApp/main/lib/resources/logo.png',
              width: 200.0,
              height: 200.0, errorBuilder: (context, error, stackTrace) {
            // Display placeholder or error message when image loading fails
            return Container(
              color: Colors.grey, // Placeholder color
              child: Center(
                child: Icon(
                  Icons.error_outline,
                  color: colorTheme.error, // Error icon color
                  size: 48.0,
                ),
              ),
            );
          }),
          const SizedBox(height: 10.0), // Spacing
          TitleLargeText(
            text: AppLocalizations.of(context)!.ratingAcknowledgeTitle,
            textAlign: TextAlign.center,
          ),
          BodyText(
            text: AppLocalizations.of(context)!.ratingAcknowledgeText,
            textAlign: TextAlign.center,
          ),
          Expanded(child: Container()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width *
                        0.8, // Maximum width based on screen width
                    minWidth: 400,
                    minHeight: 50 // No minimum width
                    ),
                child: ElevatedButton(
                  onPressed: () {
                    // Button onPressed action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorTheme.background, // Background color
                    foregroundColor: colorTheme.onBackground, // Text color
                    side: BorderSide(color: colorTheme.outline),
                    // Outline color
                  ),
                  child: BodyText(
                      text: AppLocalizations.of(context)!
                          .ratingAcknowledgeButton),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
