import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:userapp/ui/controllers/dish_of_the_day_controller.dart';
import 'package:userapp/ui/controllers/servingtime_controller.dart';
import 'package:userapp/ui/widgets/dish_display_widget.dart';
import 'package:userapp/ui/widgets/language_dropdown_widget.dart';
import 'package:userapp/ui/widgets/no_dish_widget.dart';

class DishOfTheDayPage extends ConsumerWidget {
  const DishOfTheDayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat("EEEE \n d. MMMM").format(DateTime.now())),
        actions: [LanguageDropdownWidget()],
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref
              .read(dishOfTheDayControllerProvider.notifier)
              .refetchDishOfTheDay();
        },
        child: ListView(
          children: [
            Center(
                child: switch (ref.watch(servingtimeControllerProvider)) {
              AsyncData(:final value) => !value
                  ? switch (ref.watch(dishOfTheDayControllerProvider)) {
                      AsyncData(:final value) => value.isNotEmpty
                          ? DishDisplayWidget(dishes: value)
                          : const NoDishWidget(),
                      AsyncError(:final error) => Text(error.toString()),
                      _ => const CircularProgressIndicator()
                    }
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTRuVuPxx1Ez15siEcgCMlOZ6nU4E6xzjsNe8QmRIUOJA&s",
                            width: 200),
                        const SizedBox(height: 20),
                        Text(AppLocalizations.of(context)!.servingHasEndedText),
                      ],
                    ),
              AsyncError(:final error) => Text(error.toString()),
              _ => const CircularProgressIndicator()
            }),
          ],
        ),
      ),
    );
  }
}

// switch (ref.watch(dishOfTheDayControllerProvider)) {
//               AsyncData(:final value) => value.isNotEmpty
//                   ? DishDisplayWidget(dishes: value)
//                   : const NoDishWidget(),
//               AsyncError(:final error) => Text(error.toString()),
//               _ => const CircularProgressIndicator()
//             }
