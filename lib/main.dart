import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/ui/controllers/locale_controller.dart';
import 'package:userapp/ui/pages/dish_of_the_day_page.dart';
import 'package:userapp/utilities/Constants.dart';
import 'package:userapp/utilities/theming/text_theming.dart';
import 'package:userapp/utilities/theming/color_theme.dart';
import 'dart:io';

import 'utilities/http/http_certificate_override_debug.dart'
    if (dart.library.html) 'utilities/http/http_certificate_override_stub.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Create Database reference

  if (kDebugMode) {
    // This will ignore all invalid or self signed certificates.
    // It should NOT go into production!
    HttpOverrides.global = HttpCertificateOverrides();
  }

  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseAnonKey,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'User App',
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
      home: DishOfTheDayPage(),
    );
  }
}
