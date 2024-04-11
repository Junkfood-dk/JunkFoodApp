import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/components/dish_display_component.dart';
import 'package:userapp/components/language_dropdown_component.dart';
import 'package:userapp/model/dish_of_the_day_model.dart';
import 'package:userapp/model/locale.dart';
import 'package:userapp/services/service_time_checker.dart';
import 'package:userapp/services/time_provider.dart';

class HomePage extends StatelessWidget {
  final TimeProvider timeProvider;

  const HomePage({super.key, required this.timeProvider});

  @override
  Widget build(BuildContext context) {
    final serviceTimeChecker = ServiceTimeChecker(timeProvider);

    return Consumer<LocaleModel>(
      builder: (context, localeModel, child) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.dishOfTheDay),
          actions: [LanguageDropdown()],
          automaticallyImplyLeading: false,
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            debugPrint("Refreshing");
          },
          child: ListView(
            children: [
              Center(
                child:
                    Consumer<DishOfTheDayModel>(builder: (context, state, _) {
                  final isServingEnded = serviceTimeChecker.isServiceEnded();
                  return FutureBuilder(
                      future: state.hasDishOfTheDay,
                      builder: (context, snapshot) {
                        if (isServingEnded) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRuVuPxx1Ez15siEcgCMlOZ6nU4E6xzjsNe8QmRIUOJA&s",width: 200),
                              const SizedBox(height: 20),
                              Text(AppLocalizations.of(context)!.servingHasEndedText),
                            ],
                          );
                        } else if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        } else if (!snapshot.data!) {
                          return const Text("No dish -> Implementation kommer JI-88");
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
