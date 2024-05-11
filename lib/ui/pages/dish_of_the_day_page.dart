import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:userapp/ui/controllers/dish_of_the_day_controller.dart';
import 'package:userapp/ui/controllers/servingtime_controller.dart';
import 'package:userapp/ui/widgets/dish_display_widget.dart';
import 'package:userapp/ui/widgets/language_dropdown_widget.dart';
import 'package:userapp/ui/widgets/no_dish_widget.dart';
import 'package:userapp/utilities/widgets/comments_sheet.dart';

class DishOfTheDayPage extends ConsumerWidget {
  const DishOfTheDayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var time = DateTime.now();
    var formattedDanish = DateFormat("EEEE \n d. MMMM", 'da_DK').format(time);
    var formattedEnglish = DateFormat("EEEE \n d. MMMM").format(time);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.localeHelper == "da"
            ? formattedDanish.substring(0, 1).toUpperCase() +
                formattedDanish.substring(1)
            : formattedEnglish),
        centerTitle: false,
        actions: [
          const LanguageDropdownWidget(),
          IconButton(
            icon: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: Icon(
                Icons.chat_bubble_outline,
                color: Theme.of(context).colorScheme.background,
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => CommentPage()),
              );
            },
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(
                    height: 22,
                  ),
                  switch (ref.watch(servingtimeControllerProvider)) {
                    AsyncData(:final value) => !value
                        ? switch (ref.watch(dishOfTheDayControllerProvider)) {
                            AsyncData(:final value) =>
                              value.isNotEmpty //Dish has content
                                  ? FlutterCarousel(
                                      options: CarouselOptions(
                                        viewportFraction: 1,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.8,
                                        showIndicator: true,
                                        slideIndicator:
                                            const CircularSlideIndicator(),
                                      ),
                                      items: value.map((i) {
                                        return DishDisplayWidget(dish: i);
                                      }).toList())
                                  : const NoDishWidget(), //NO DISH
                            AsyncError(:final error) => Text(error.toString()),
                            _ => const CircularProgressIndicator()
                          }
                        : Text(value
                            .toString()) /* const ServingEndedWidget()*/, //ENDED
                    AsyncError(:final error) => Text(error.toString()),
                    _ => const CircularProgressIndicator()
                  },
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
