import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:junkfood/ui/controllers/dish_controller.dart';
import 'package:junkfood/ui/controllers/dish_of_the_day_controller.dart';
import 'package:junkfood/ui/controllers/servingtime_controller.dart';
import 'package:junkfood/ui/widgets/dish_display_widget.dart';
import 'package:junkfood/ui/widgets/language_dropdown_widget.dart';
import 'package:junkfood/ui/widgets/no_dish_widget.dart';
import 'package:junkfood/ui/widgets/rating_widget.dart';
import 'package:junkfood/ui/widgets/serving_ended_widget.dart';
import 'package:junkfood/utilities/widgets/comments_page.dart';
import 'package:junkfood/utilities/widgets/gradiant_button_widget.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';

import '../../domain/model/dish_model.dart';

class DishOfTheDayPage extends ConsumerWidget {
  const DishOfTheDayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = DateTime.now();
    final formattedDanish = DateFormat('EEEE \nd. MMMM', 'da_DK').format(time);
    final formattedEnglish = DateFormat('EEEE \nd. MMMM').format(time);
    final CarouselController controller = CarouselController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.localeHelper == 'da'
              ? formattedDanish.substring(0, 1).toUpperCase() +
                  formattedDanish.substring(1)
              : formattedEnglish,
        ),
        actions: [
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.chat_bubble_outline,
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            onPressed: () async {
              final navigator = Navigator.of(context);
              await navigator.push(
                MaterialPageRoute(
                  builder: (context) => CommentsPage(),
                ),
              );
              navigator.pop();
            },
          ),
          const LanguageDropdownWidget(),
        ],
        automaticallyImplyLeading: false,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref
              .read(dishOfTheDayControllerProvider.notifier)
              .refetchDishOfTheDay();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: switch (ref.watch(servingtimeControllerProvider)) {
            AsyncData(:final value) => !value
                ? switch (ref.watch(dishOfTheDayControllerProvider)) {
                    AsyncData(:final value) =>
                      value.isNotEmpty //Dish has content
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CarouselView(
                                    controller: controller,
                                    itemExtent: 800.0,
                                    itemSnapping: true,
                                    children: value.map((DishModel dish) {
                                      return DishDisplayWidget(dish: dish);
                                    }).toList(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: 48.0,
                                    child: GradiantButton(
                                      child: ButtonText(
                                        text: AppLocalizations.of(context)!
                                            .rateButtonText,
                                      ),
                                      onPressed: () {
                                        showModalBottomSheet<void>(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext context) {
                                            final dish = ref.watch(
                                              dishControllerProvider,
                                            );
                                            return SingleChildScrollView(
                                              child: dish != null
                                                  ? RatingWidget(dish: dish)
                                                  : const SizedBox.shrink(),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const Center(child: NoDishWidget()), //NO DISH
                    AsyncError(:final error) => Text(error.toString()),
                    _ => const Center(child: CircularProgressIndicator())
                  }
                : const Center(child: ServingEndedWidget()), //ENDED
            AsyncError(:final error) => Text(error.toString()),
            _ => const Center(child: CircularProgressIndicator())
          },
        ),
      ),
    );
  }
}
