import 'package:flutter/material.dart';
import 'package:junkfood/ui/widgets/logo_image.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServingEndedWidget extends StatelessWidget {
  const ServingEndedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoImage(),
              TitleLargeText(
                text: AppLocalizations.of(context)!.servingHasEndedText,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
