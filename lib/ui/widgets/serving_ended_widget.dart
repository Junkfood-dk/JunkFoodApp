import 'package:flutter/widgets.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServingEndedWidget extends StatelessWidget {
  const ServingEndedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
            'https://raw.githubusercontent.com/Junkfood-dk/JunkFoodApp/main/lib/resources/logo.png',
            width: 200),
        const SizedBox(height: 20),
        BodyText(
          text: AppLocalizations.of(context)!.servingHasEndedText,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.5),
      ],
    );
  }
}
