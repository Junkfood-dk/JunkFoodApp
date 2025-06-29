import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:junkfood/domain/model/language_model.dart';
import 'package:junkfood/l10n/app_localizations.dart';
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
        final localizations = AppLocalizations.of(context)!;
        List<PopupMenuEntry<Language>> menuItems =
            Language.languageList().map((e) {
          String localizedName;
          switch (e.languageCode) {
            case 'en':
              localizedName = localizations.languageEnglish;
              break;
            case 'da':
              localizedName = localizations.languageDanish;
              break;
            default:
              localizedName = e.name;
          }
          return PopupMenuItem<Language>(value: e, child: Text(localizedName));
        }).toList();

        return menuItems;
      },
    );
  }
}
