import 'dart:async';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/app/theme/app_theme.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/auth/ref_extension.provider.dart';
import 'package:datarunmobile/core/main_constants.dart';
import 'package:datarunmobile/core/user_session/locale_service.dart';
import 'package:datarunmobile/core/user_session/preference.provider.dart';
import 'package:datarunmobile/features/home/presentation/home_wrapper_page.dart';
import 'package:datarunmobile/features/login/presentation/login_view.dart';
import 'package:datarunmobile/features/startup/presentation/splash_view.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:stacked_services/stacked_services.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) {
      return stack.vmTrace;
    }
    if (stack is stack_trace.Chain) {
      return stack.toTrace().vmTrace;
    }
    return stack;
  };

  // await SentryFlutter.init(
  //   (options) {
  //     options.dsn =
  //         'https://c39a75530f4b8694183508a689bbafb7@o4504831846645760.ingest.us.sentry.io/4507587127214080';
  //     // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
  //     // We recommend adjusting this value in production.
  //     // options.tracesSampleRate = 1.0;
  //     // The sampling rate for profiling is relative to tracesSampleRate
  //     // Setting to 1.0 will profile 100% of sampled transactions:
  //     // options.profilesSampleRate = 1.0;
  //   },
  //   appRunner: () => runApp(
  //     const ProviderScope(
  //       child: App(
  //         key: ValueKey('DATARUN_MAIN_APP'),
  //       ),
  //     ),
  //   ),
  // );

  runApp(const ProviderScope(
    child: App(key: ValueKey('DATARUN_MAIN_APP')),
  ));
}

class App extends ConsumerWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authManager = ref.watch(authNotifierProvider);
    final language =
        ref.watch(preferenceNotifierProvider(Preference.language)) as String;
    // timeago.setLocaleMessages(
    //     language,
    //     switch (language) {
    //       'ar' => timeago.ArMessages(),
    //       'en' => timeago.EnMessages(),
    //       _ => timeago.EnMessages(),
    //     });

    final seed = ref.watch(preferenceNotifierProvider(Preference.colorSeed));
    final mode = ref.watch(preferenceNotifierProvider(Preference.themeMode));
    final colorSeed = ColorSeed.values[seed];
    final useMaterial3 =
        ref.watch(preferenceNotifierProvider(Preference.useMaterial3));
    final themeMode = ThemeMode.values[mode];

    final cs = ColorScheme.fromSeed(
        seedColor: colorSeed.color,
        brightness: Brightness.light,
        contrastLevel: 0.1);

    return MaterialApp(
      restorationScopeId: 'Test__',
      navigatorKey: StackedService.navigatorKey,
      title: 'Datarun',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: AppTheme.buildTheme(
          colorSeed: colorSeed,
          base: ThemeData.light(useMaterial3: useMaterial3),
          platform: Theme.of(context).platform),
      darkTheme: AppTheme.buildTheme(
          colorSeed: colorSeed,
          base: ThemeData.dark(useMaterial3: useMaterial3),
          platform: Theme.of(context).platform,
          brightness: Brightness.dark),
      // localizationsDelegates: localizationsDelegates,
      // supportedLocales: supportedLocales,
      locale: resolveLocale(status: authManager.status, languageCode: language),
      // Setup internationalization
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      // Dynamically set locale based on the LocaleService (if authenticated)
      localeResolutionCallback:
          (Locale? locale, Iterable<Locale> supportedLocales) {
        // Locale locale = Locale(language, language == 'en' ? 'en_US' : '');

        late final Locale? userLocale;

        if (authManager.status == AuthStatus.authenticated) {
          // preference take precedence over api user's local

          userLocale = language != 'NA'
              ? Locale(language, language == 'en' ? 'US' : '')
              : appLocator<LocaleService>().currentLocale;
          if (userLocale != null) {
            // If the user has a specific locale set, use that
            // timeago.setDefaultLocale('en');
            timeago.setLocaleMessages(
                userLocale.languageCode,
                switch (language) {
                  'ar' => timeago.ArMessages(),
                  'en' => timeago.EnMessages(),
                  _ => timeago.EnMessages(),
                });
            return userLocale;
          }
        }
        // Otherwise, use the device locale or default to English
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale?.languageCode) {
            return supportedLocale;
          }
        }

        // Fallback to the first supported locale (e.g., en)
        return supportedLocales.first;
      },
      // stacked
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
      //
      initialRoute: Routes.splashView,
      // home: switch (authManager.status) {
      //   AuthStatus.unknown =>
      //     const SplashView(), // Show splash while checking auth
      //   AuthStatus.unauthenticated =>
      //     const LoginView(), // Show login if not authenticated
      //   AuthStatus.authenticated => HomeWrapperPage(),
      // },
    );
  }

  final supportedLocales = const <Locale>[
    Locale('ar', ''),
    Locale('en', 'en_us'),
  ];

  final localizationsDelegates = const <LocalizationsDelegate<dynamic>>[
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  Locale resolveLocale(
      {required AuthStatus status, required String languageCode}) {
    Locale? userLocale =
        Locale(languageCode, languageCode == 'en' ? 'en_US' : '');

    if (status == AuthStatus.authenticated &&
        appLocator.isRegistered<LocaleService>()) {
      // preference take precedence over api user's local
      userLocale = appLocator<LocaleService>().currentLocale ?? userLocale;
    }

    final String ff = userLocale.languageCode;
    final String? ff2 = userLocale.scriptCode;
    final String? ff3 = userLocale.countryCode;

    timeago.setLocaleMessages(
        userLocale.languageCode,
        switch (userLocale.languageCode) {
          'ar' => timeago.ArMessages(),
          'en' => timeago.EnMessages(),
          _ => timeago.EnMessages(),
        });
    return userLocale;
  }
}
