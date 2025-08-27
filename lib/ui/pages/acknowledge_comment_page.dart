import 'package:flutter/material.dart';
import 'package:string_cache/string_cache.dart';
import 'package:junkfood/ui/pages/dish_of_the_day_page.dart';
import 'package:junkfood/ui/widgets/logo_image.dart';
import 'package:junkfood/utilities/theming/color_theme.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';

class AcknowledgeCommentPage extends StatelessWidget {
  const AcknowledgeCommentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          const LogoImage(),
          const SizedBox(height: 10.0),
          TitleLargeText(
            text: SupabaseLocalizations.of(context)!.commentAcknowledgementTitle,
            textAlign: TextAlign.center,
          ),
          BodyText(
            text: SupabaseLocalizations.of(context)!.commentAcknowledgementText,
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const DishOfTheDayPage(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorTheme.surface,
                    foregroundColor: colorTheme.onSurface,
                    side: BorderSide(color: colorTheme.outline),
                  ),
                  child: BodyText(
                    text: SupabaseLocalizations.of(context)!
                        .commentAcknowledgementButton,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
