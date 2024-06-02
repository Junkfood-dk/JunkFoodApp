import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:junkfood/domain/model/language_model.dart';
import 'package:junkfood/ui/controllers/locale_controller.dart';
import 'package:junkfood/utilities/widgets/gradiant_wrapper.dart';

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
      icon: const PrimaryGradiantWidget(child: Icon(Icons.language)),
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
