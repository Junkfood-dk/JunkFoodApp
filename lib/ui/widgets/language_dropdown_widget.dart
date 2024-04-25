import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:userapp/domain/model/language_model.dart';
import 'package:userapp/ui/controllers/locale_controller.dart';
import 'package:userapp/utilities/widgets/gradiant_wrapper.dart';

class LanguageDropdownWidget extends ConsumerWidget {
  const LanguageDropdownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<Language>(
      onSelected: (Language language) {
        ref
            .read(localeControllerProvider.notifier)
            .set(Locale(language.languageCode));
      },
      icon: primaryGradiantWidget(child: const Icon(Icons.language )),
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<Language>> menuItems =
            Language.languageList().map((e) {
          return PopupMenuItem<Language>(value: e, child: Text(e.name));
        }).toList();

        return menuItems;
      },
    );
  }
}
