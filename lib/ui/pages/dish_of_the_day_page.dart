import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:junkfood/ui/controllers/dish_of_the_day_controller.dart';
import 'package:junkfood/ui/controllers/servingtime_controller.dart';
import 'package:junkfood/ui/widgets/dish_display_widget.dart';
import 'package:junkfood/ui/widgets/language_dropdown_widget.dart';
import 'package:junkfood/ui/widgets/no_dish_widget.dart';
import 'package:junkfood/ui/widgets/serving_ended_widget.dart';
import 'package:junkfood/utilities/widgets/comments_sheet.dart';

class DishOfTheDayPage extends ConsumerWidget {
  const DishOfTheDayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = DateTime.now();
    final formattedDanish = DateFormat("EEEE d. MMMM", 'da_DK').format(time);
    final formattedEnglish = DateFormat("EEEE d. MMMM").format(time);

    return Scaffold(
      appBar: AppBar(
        leading: const LanguageDropdownWidget(),
        title: Text(AppLocalizations.of(context)!.localeHelper == "da"
            ? formattedDanish.substring(0, 1).toUpperCase() +
                formattedDanish.substring(1)
            : formattedEnglish),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.chat_bubble_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return CommentPage();
                  });
            },
            padding: const EdgeInsets.only(right: 16.0),
          ),
        ],
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
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 650),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: switch (ref.watch(servingtimeControllerProvider)) {
                    AsyncData(:final value) => !value
                        ? switch (ref.watch(dishOfTheDayControllerProvider)) {
                            AsyncData(:final value) => value.isNotEmpty
                                ? FlutterCarousel(
                                    options: CarouselOptions(
                                      viewportFraction: 1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.92,
                                      showIndicator: true,
                                      slideIndicator:
                                          const CircularSlideIndicator(),
                                    ),
                                    items: value.map((i) {
                                      return DishDisplayWidget(dish: i);
                                    }).toList())
                                : const NoDishWidget(), //NO DISH
                            AsyncError(:final error) => Text(error.toString()),
                            _ =>
                              const Center(child: CircularProgressIndicator())
                          }
                        : const ServingEndedWidget(), //ENDED
                    AsyncError(:final error) => Text(error.toString()),
                    _ => const Center(child: CircularProgressIndicator())
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
