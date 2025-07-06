import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junkfood/l10n/app_localizations.dart';
import 'package:junkfood/ui/widgets/logo_title_widget.dart';

class ServingEndedWidget extends ConsumerWidget {
  const ServingEndedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LogoTitleWidget(
      title: AppLocalizations.of(context)!.servingHasEndedText,
    );
  }
}
