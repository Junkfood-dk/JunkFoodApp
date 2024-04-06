import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:userapp/components/language_dropdown_component.dart';
import 'package:userapp/model/dish_model.dart';
import 'package:userapp/model/show_page.dart';
import 'package:userapp/model/dish_of_the_day_model.dart';
import 'package:userapp/model/language.dart';
import 'model/locale.dart';
import 'package:userapp/Constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Create Database reference
  await Supabase.initialize(
    url: Constants.supabaseUrl,
    anonKey: Constants.supabaseAnonKey,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => DishOfTheDayModel(database: _supabase), //pass db
    ),
  ], child: const MyApp()));
}

final _supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleModel(),
      child: Consumer<LocaleModel>(
        builder: (context, localeModel, child) => MaterialApp(
            title: 'User App',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: localeModel.locale,
            debugShowCheckedModeBanner: false,
            initialRoute: '/',
            routes: <String, WidgetBuilder>{
              '/': (_) => ShowPage(database: _supabase),
            }),
      ),
    );
  }
}
