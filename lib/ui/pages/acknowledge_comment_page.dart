import 'package:flutter/material.dart';
import 'package:junkfood/ui/pages/dish_of_the_day_page.dart';
import 'package:junkfood/utilities/theming/color_theme.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AcknowledgeCommentPage extends StatelessWidget {
  const AcknowledgeCommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Image.network(
              'https://raw.githubusercontent.com/Junkfood-dk/JunkFoodApp/main/lib/resources/logo.png',
              width: 200.0,
              height: 200.0, errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey,
              child: Center(
                child: Icon(
                  Icons.error_outline,
                  color: colorTheme.error,
                  size: 48.0,
                ),
              ),
            );
          }),
          const SizedBox(height: 10.0),
          TitleLargeText(
            text: AppLocalizations.of(context)!.commentAcknowledgementTitle,
            textAlign: TextAlign.center,
          ),
          BodyText(
            text: AppLocalizations.of(context)!.commentAcknowledgementText,
            textAlign: TextAlign.center,
          ),
          Expanded(child: Container()),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.8,
                  minHeight: 50,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DishOfTheDayPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorTheme.background,
                    foregroundColor: colorTheme.onBackground,
                    side: BorderSide(color: colorTheme.outline),
                  ),
                  child: BodyText(
                    text: AppLocalizations.of(context)!
                        .commentAcknowledgementButton,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
