import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:junkfood/ui/controllers/string_controller.dart';
import 'package:string_cache/string_cache.dart';
import 'package:junkfood/providers/date_provider.dart';
import 'package:junkfood/providers/desktop_web_provider.dart';
import 'package:junkfood/ui/controllers/dish_of_the_day_controller.dart';
import 'package:junkfood/ui/controllers/servingtime_controller.dart';
import 'package:junkfood/ui/controllers/settings_controller.dart';
import 'package:junkfood/ui/widgets/serving_ended_widget.dart';
import 'package:junkfood/ui/widgets/no_dish_widget.dart';
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
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
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
            overrides: kIsWeb
                ? [
                    screenWidthProvider
                        .overrideWithValue(MediaQuery.sizeOf(context).width),
                  ]
                : [],
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
    final stringControllerState = ref.watch(stringControllerProvider);
    final settingsState = ref.watch(settingsControllerProvider);

    return MaterialApp(
      title: 'Junkfood',
      theme: ThemeData(
        colorScheme: colorTheme,
        textTheme: appTextTheme,
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        SupabaseLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: SupabaseLocalizations.supportedLocales,
      locale: switch (ref.watch(localeControllerProvider)) {
        AsyncData(:final value) => value,
        _ => null
      },
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) {
          // Check string loading state first
          return stringControllerState.when(
            loading: () => const Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading translations...'),
                  ],
                ),
              ),
            ),
            error: (error, stackTrace) => Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 16),
                    const Text('Failed to load translations'),
                    const SizedBox(height: 8),
                    Text('$error', textAlign: TextAlign.center),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        ref
                            .read(stringControllerProvider.notifier)
                            .refreshStrings();
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
            data: (stringsLoaded) {
              // Continue with normal app flow regardless of whether strings loaded
              // from Supabase or using fallback translations
              if (dishOfTheDayState.hasValue &&
                  dishOfTheDayState.value!.isNotEmpty) {
                return const DishOfTheDayPage();
              }

              return Consumer(
                builder: (context, ref, child) {
                  final bool isDesktop = ref.watch(isDesktopLayoutProvider);

                  if (isDesktop) {
                    return Scaffold(
                      body: Center(
                        child: mainWidget(
                          servingHasEnded,
                          !dishOfTheDayState.hasValue,
                          settingsState,
                        ),
                      ),
                    );
                  }

                  return Scaffold(
                    body: Center(
                      child: mainWidget(
                        servingHasEnded,
                        !dishOfTheDayState.hasValue,
                        settingsState,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget mainWidget(
    bool servingHasEnded,
    bool isLoading,
    AsyncValue<bool> settingsState,
  ) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (servingHasEnded) return const ServingEndedWidget();

    // Check settings to determine which widget to show
    return settingsState.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) =>
          const DishOfTheDayPage(), // Fallback to dish page on error
      data: (showNoDishMessage) {
        if (showNoDishMessage) {
          return const NoDishWidget();
        }
        return const DishOfTheDayPage();
      },
    );
  }
}
