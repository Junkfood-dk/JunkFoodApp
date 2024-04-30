import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/utilities/widgets/text_wrapper.dart';

class NoDishWidget extends StatelessWidget {
  const NoDishWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // Center content horizontally
      children: [
        Image.network(
            'https://raw.githubusercontent.com/Junkfood-dk/JunkFoodApp/main/lib/resources/logo.png',
            width: 200.0,
            height: 200.0, errorBuilder: (context, error, stackTrace) {
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
        const SizedBox(height: 10.0), // Spacing
        BodyText(text: AppLocalizations.of(context)!.noDishText, textAlign: TextAlign.center,),
      ],
    );
  }
}
