import 'package:userapp/components/no_dish_component.dart';
import 'package:userapp/components/language_dropdown_component.dart';
import 'package:userapp/model/dish_of_the_day_model.dart';
import 'package:userapp/model/locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DishOfTheDay extends StatelessWidget {
  const DishOfTheDay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleModel>(
      builder: (context, localeModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.dishOfTheDay),
          actions: [LanguageDropdown()],
          automaticallyImplyLeading: false,
        ),
        body: Consumer<DishOfTheDayModel>(
          builder: (context, dishOfTheDayModel, child) => RefreshIndicator(
            onRefresh: () async {
              dishOfTheDayModel.fetchDishOfTheDay();
            },
            child: ListView(
              children: [
                Center(
                  child:
                      Consumer<DishOfTheDayModel>(builder: (context, state, _) {
                    return FutureBuilder(
                        future:
                            state.hasDishOfTheDay, //state is the dish_of_the
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          } else {
                            if (!snapshot.data!) {
                              return Column(
                                children: [
                                  Center(
                                      child: NoDishComponent(
                                          dishes: state.dishOfTheDay))
                                ],
                              );
                            } else {
                              return Text("Show dish -> JI-3");
                            }
                          }
                        });
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
