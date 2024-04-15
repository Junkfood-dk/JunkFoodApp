import 'package:userapp/dish_of_the_day_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/ui/controllers/locale_controller.dart';
import 'package:userapp/ui/widgets/dish_display_widget.dart';
import 'package:userapp/ui/widgets/language_dropdown_widget.dart';
import 'package:userapp/ui/widgets/no_dish_widget.dart';

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
                                children: [Center(child: NoDishWidget())],
                              );
                            } else {
                              return Column(
                                children: [
                                  Center(
                                      child: DishDisplayComponent
                                          .DishDisplayWidget(
                                              dishes: state.dishOfTheDay))
                                ],
                              );
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
