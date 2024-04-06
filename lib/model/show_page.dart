import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase/src/supabase_client.dart';
import 'package:userapp/components/language_dropdown_component.dart';
import 'package:userapp/model/dish_display_component.dart';
import 'package:userapp/model/dish_of_the_day_model.dart';
import 'package:userapp/model/locale.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShowPage extends StatelessWidget {
  const ShowPage({super.key, required SupabaseClient database});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleModel>(
      builder: (context, localeModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.homePageTitle),
          actions: [LanguageDropdown()],
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Consumer<DishOfTheDayModel>(builder: (context, state, _) {
            return FutureBuilder(
                future: state.hasDishOfTheDay,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                   if (!snapshot.data!) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, // Center content horizontally
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .center, // Center content horizontally
                            children: [
                              Text(AppLocalizations.of(context)!.noDishText),
                              const SizedBox(width: 10.0), // Spacing
                              Image.network(
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRuVuPxx1Ez15siEcgCMlOZ6nU4E6xzjsNe8QmRIUOJA&s',
                                width: 100.0,
                                height: 100.0,
                              ),
                            ],
                          ),
                          const SizedBox(
                              height: 10.0), // Add spacing below the row
                        ],
                      );
                    } else  {
                      return  Column(
                        children: [
                          Center(
                              child: DishDisplayComponent(
                                  dish: state.dishOfTheDay))
                        ],
                      );
                    }
                  }
                });
          }),
        ),
      ),
    );
  }
}
