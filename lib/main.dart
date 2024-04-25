import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:userapp/ui/controllers/locale_controller.dart';
import 'package:userapp/ui/pages/dish_of_the_day_page.dart';
import 'package:userapp/utilities/Constants.dart';
import 'package:userapp/utilities/theming/text_theming.dart';
import 'package:userapp/utilities/theming/color_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Create Database reference
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
      locale: ref.watch(localeControllerProvider),
      debugShowCheckedModeBanner: false,
      home: DishOfTheDayPage(),
    );
  }
}
