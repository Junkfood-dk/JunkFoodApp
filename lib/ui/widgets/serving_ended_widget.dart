import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junkfood/l10n/app_localizations.dart';
import 'package:junkfood/ui/controllers/dish_of_the_day_controller.dart';
import 'package:junkfood/ui/widgets/logo_image.dart';
import 'package:junkfood/utilities/widgets/sized_box_ext.dart';
import 'package:junkfood/utilities/widgets/text_wrapper.dart';

class ServingEndedWidget extends ConsumerWidget {
  const ServingEndedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: RefreshIndicator(
          onRefresh: () async {
            ref
                .read(dishOfTheDayControllerProvider.notifier)
                .refetchDishOfTheDay();
          },
          child: ListView(
            children: [
              SizedBoxExt.sizedBoxHeight24,
              const LogoImage(),
              TitleLargeText(
                text: AppLocalizations.of(context)!.servingHasEndedText,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
