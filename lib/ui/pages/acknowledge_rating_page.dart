import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:junkfood/utilities/theming/color_theme.dart';
import 'package:junkfood/utilities/widgets/comments_sheet.dart';
import 'package:junkfood/utilities/widgets/gradiant_button_widget.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';

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
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: GradiantButton(
                        onPressed: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => CommentPage()),
                          );
                          Navigator.pop(context);
                        },
                        child: ButtonText(
                          text: AppLocalizations.of(context)!.sendUsMsgBtn,
                        ))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          colorTheme.background, // Background color
                      foregroundColor: colorTheme.onBackground, // Text color
                      side: BorderSide(color: colorTheme.outline),
                      // Outline color
                    ),
                    child: ButtonText(
                        text: AppLocalizations.of(context)!
                            .ratingAcknowledgeButton),
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
