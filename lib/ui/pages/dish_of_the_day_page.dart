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
import 'package:userapp/utilities/theming/color_theme.dart';
import 'package:userapp/utilities/widgets/comments_sheet.dart';
import 'package:userapp/utilities/widgets/gradiant_wrapper.dart';
import 'package:userapp/utilities/widgets/text_wrapper.dart';

class DishOfTheDayPage extends ConsumerWidget {
  const DishOfTheDayPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(DateFormat("EEEE \n d. MMMM").format(DateTime.now())),
        centerTitle: false,
        actions: [
          LanguageDropdownWidget(),
          IconButton(
            icon: primaryGradiantWidget(
              child: Icon(Icons.chat_bubble_outline),
            ),
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CommentPage()));
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
        child: ListView(
          children: [
            SizedBox(
              height: 22,
            ),
            Center(
                child: switch (ref.watch(servingtimeControllerProvider)) {
              AsyncData(:final value) => !value
                  ? switch (ref.watch(dishOfTheDayControllerProvider)) {
                      AsyncData(:final value) => value.isNotEmpty
                          ? FlutterCarousel(
                              options: CarouselOptions(
                                viewportFraction: 1,
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                showIndicator: true,
                                slideIndicator: CircularSlideIndicator(),
                              ),
                              items: value.map((i) {
                                return DishDisplayWidget(dish: i);
                              }).toList())
                          : const NoDishWidget(),
                      AsyncError(:final error) => Text(error.toString()),
                      _ => const CircularProgressIndicator()
                    }
                  : Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                        Image.network(
                            'https://raw.githubusercontent.com/Junkfood-dk/JunkFoodApp/main/lib/resources/logo.png',
                            width: 200),
                        const SizedBox(height: 20),
                        BodyText(
                          text:
                              AppLocalizations.of(context)!.servingHasEndedText,
                          textAlign: TextAlign.center,
                        ),
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
