import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/components/dish_display_component.dart';
import 'package:userapp/components/language_dropdown_component.dart';
import 'package:userapp/model/dish_of_the_day_model.dart';
import 'package:userapp/model/locale.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Edit this line to test time functionality
    final now = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 22, 00);

    return Consumer<LocaleModel>(
      builder: (context, localeModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.dishOfTheDay),
          actions: [LanguageDropdown()],
          automaticallyImplyLeading: false,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            print("Refreshing");
          },
          child: ListView(
            children: [
              Center(
                child:
                    Consumer<DishOfTheDayModel>(builder: (context, state, _) {
                  final startTime =
                      DateTime(now.year, now.month, now.day, 20, 59);
                  final endTime =
                      DateTime(now.year, now.month, now.day, 24, 00);

                  final isServingEnded =
                      now.isAfter(startTime) && now.isBefore(endTime);

                  return FutureBuilder(
                      future: state.hasDishOfTheDay,
                      builder: (context, snapshot) {
                        if (isServingEnded) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRuVuPxx1Ez15siEcgCMlOZ6nU4E6xzjsNe8QmRIUOJA&s",width: 200),
                              SizedBox(height: 20),
                              Text(AppLocalizations.of(context)!.servingHasEndedText),
                            ],
                          );
                        } else if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        } else if (!snapshot.data!) {
                          return Text("No dish -> Implementation kommer JI-88");
                        } else {
                          return Column(
                            children: [
                              Center(
                                  child: DishDisplayComponent(
                                      dish: state.dishOfTheDay))
                            ],
                          );
                        }
                      });
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
