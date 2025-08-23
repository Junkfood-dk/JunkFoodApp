import 'package:flutter/material.dart';
import 'package:string_cache/string_cache.dart';

import 'package:junkfood/ui/widgets/logo_image.dart';
import 'package:junkfood/utilities/theming/color_theme.dart';
import 'package:junkfood/ui/pages/comments_page.dart';
import 'package:junkfood/utilities/widgets/gradiant_button_widget.dart';
import 'package:junkfood/extensions/sized_box_ext.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';

class AcknowledgeRatingPage extends StatelessWidget {
  const AcknowledgeRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const LogoImage(),
                  TitleLargeText(
                    text: SupabaseLocalizations.of(context)!.ratingAcknowledgeTitle,
                    textAlign: TextAlign.center,
                  ),
                  BodyText(
                    text: SupabaseLocalizations.of(context)!.ratingAcknowledgeText,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 48.0,
                  child: GradiantButton(
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      await navigator.push(
                        MaterialPageRoute(
                          builder: (context) => CommentsPage(),
                        ),
                      );
                      navigator.pop();
                    },
                    child: ButtonText(
                      text: SupabaseLocalizations.of(context)!.sendUsMsgBtn,
                    ),
                  ),
                ),
                SizedBoxExt.sizedBoxHeight16,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 48.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorTheme.surface,
                      foregroundColor: colorTheme.onSurface,
                      side: BorderSide(color: colorTheme.outline),
                      // Outline color
                    ),
                    child: ButtonText(
                      text:
                          SupabaseLocalizations.of(context)!.ratingAcknowledgeButton,
                    ),
                  ),
                ),
                SizedBoxExt.sizedBoxHeight24,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
