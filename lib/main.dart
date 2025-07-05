import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:junkfood/l10n/app_localizations.dart';
import 'package:junkfood/providers/date_provider.dart';
import 'package:junkfood/providers/desktop_web_provider.dart';
import 'package:junkfood/ui/controllers/dish_of_the_day_controller.dart';
import 'package:junkfood/ui/controllers/servingtime_controller.dart';
import 'package:junkfood/ui/widgets/no_dish_widget.dart';
import 'package:junkfood/ui/widgets/serving_ended_widget.dart';
import 'package:junkfood/utilities/widgets/datetime/date_bar_small.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:junkfood/ui/controllers/locale_controller.dart';
import 'package:junkfood/ui/pages/dish_of_the_day_page.dart';
import 'package:junkfood/utilities/constants.dart';
import 'package:junkfood/utilities/theming/text_theming.dart';
import 'package:junkfood/utilities/theming/color_theme.dart';
import 'utilities/http/http_certificate_override_debug.dart'
    if (dart.library.html) 'utilities/http/http_certificate_override_stub.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    // This will ignore all invalid or self signed certificates.
    // It should NOT go into production!
    HttpOverrides.global = HttpCertificateOverrides();
  }

  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseAnonKey,
  );

  runApp(
    ProviderScope(
      child: Builder(
        // Builder is used here to get a BuildContext to access MediaQuery.sizeOf(context).width
        builder: (context) {
          // Override the screenWidthProvider with the actual screen width.
          // Using MediaQuery.sizeOf(context).width directly ensures that
          // only changes to the width (not other MediaQueryData properties)
          // will trigger a rebuild of the provider and subsequent dependents.
          return ProviderScope(
            overrides: [
              screenWidthProvider
                  .overrideWithValue(MediaQuery.sizeOf(context).width),
            ],
            child: const MyApp(),
          );
        },
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final time = ref.watch(dateProviderProvider);
    final servingTimeState = ref.watch(servingtimeControllerProvider.notifier);
    final servingHasEnded = servingTimeState.hasServiceEnded(time);

    final dishOfTheDayState = ref.watch(dishOfTheDayControllerProvider);

    return MaterialApp(
      title: 'Junkfood',
      theme: ThemeData(
        colorScheme: colorTheme,
        textTheme: appTextTheme,
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: switch (ref.watch(localeControllerProvider)) {
        AsyncData(:final value) => value,
        _ => null
      },
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) {
          if (dishOfTheDayState.hasValue &&
              dishOfTheDayState.value!.isNotEmpty) {
            return const DishOfTheDayPage();
          }

          return Consumer(
            builder: (context, ref, child) {
              final bool isDesktop = ref.watch(isDesktopLayoutProvider);

              if (isDesktop) {
                return Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (dishOfTheDayState.hasValue) const DateBarSmall(),
                      mainWidget(
                        servingHasEnded,
                        dishOfTheDayState.hasValue &&
                            dishOfTheDayState.value!.isNotEmpty,
                        !dishOfTheDayState.hasValue,
                      ),
                    ],
                  ),
                );
              }

              return mainWidget(
                servingHasEnded,
                dishOfTheDayState.hasValue &&
                    dishOfTheDayState.value!.isNotEmpty,
                !dishOfTheDayState.hasValue,
              );
            },
          );
        },
      ),
    );
  }

  Widget mainWidget(
    bool servingHasEnded,
    bool hasDishOfTheDay,
    bool isLoading,
  ) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (servingHasEnded) return const ServingEndedWidget();
    if (!hasDishOfTheDay) return const Center(child: NoDishWidget());
    return const DishOfTheDayPage();
  }
}
