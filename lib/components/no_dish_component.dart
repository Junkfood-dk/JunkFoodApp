import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NoDishComponent extends StatelessWidget {
  const NoDishComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.center, // Center content horizontally
      children: [
        /*Image.network(
          'https://raw.githubusercontent.com/Junkfood-dk/JunkFoodApp/main/lib/logo.png',
          width: 200.0,
          height: 200.0,
        ),*/
        const SizedBox(height: 10.0), // Spacing
        Text(AppLocalizations.of(context)!.noDishText),
        Text("Fuck så af"),
      ],
    );
  }
}
