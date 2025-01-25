import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:junkfood/ui/widgets/logo_image.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';

class NoDishWidget extends StatelessWidget {
  const NoDishWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoImage(),
            const SizedBox(height: 10.0), // Spacing
            BodyText(
              text: AppLocalizations.of(context)!.noDishText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
