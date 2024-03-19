import 'package:userapp/components/dish_display_component.dart';
import 'package:userapp/components/language_dropdown_component.dart';
import 'package:userapp/model/dish_of_the_day_model.dart';
import 'package:userapp/model/locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleModel>(
      builder: (context, localeModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.dishOfTheDay),
          actions: [LanguageDropdown()],
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Consumer<DishOfTheDayModel>(builder: (context, state, _) { 
            return FutureBuilder(
                future: state.hasDishOfTheDay, //state is the dish_of_the
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  } else {
                    if (!snapshot.data!) {
                      return Text("No dish -> Implementation kommer JI-88");
                    } else {
                      return Column(
                        children: [
                          Center(
                              child: DishDisplayComponent(
                                  dish: state.dishOfTheDay,
                                  dishTypeMap: state.dishTypeMap))
                                  
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
