import 'dart:async';

import 'package:d_sdk/di/injection.dart';
import 'package:datarunmobile/app/router/app_router.dart' show AppRouter;
import 'package:datarunmobile/core/main_constants.dart';
import 'package:datarunmobile/data/preference2.provider.dart';
import 'package:datarunmobile/di/app.bottomsheets.dart';
import 'package:datarunmobile/di/app.dialogs.dart';
import 'package:datarunmobile/di/app_environment.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:timeago/timeago.dart' as timeago;

// import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // stacked
  setupSdkLocator();
  // await setupLocator();
  await configureDependencies();
  setupDialogUi();
  setupBottomSheetUi();

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) {
      return stack.vmTrace;
    }
    if (stack is stack_trace.Chain) {
      return stack.toTrace().vmTrace;
    }
    return stack;
  };

  // if (Platform.isWindows || Platform.isLinux) {
  //   sqfliteFfiInit();
  //   databaseFactory = databaseFactoryFfi;
  // }

  // is has active session initialize, otherwise it will be initialized
  // by user login in.
  // if (hasExistingSession) {
  //   await D2Remote.initialize(
  //       databaseFactory:
  //           Platform.isWindows || Platform.isLinux ? databaseFactory : null);
  // }

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
  //   appRunner: () => runApp(ProviderScope(
  //     overrides: [
  //       sharedPreferencesProvider.overrideWithValue(sharedPreferences),
  //       authServiceProvider.overrideWithValue(authService),
  //       userSessionManagerProvider.overrideWithValue(userSessionManager),
  //     ],
  //     child: App(
  //       isAuthenticated: hasExistingSession,
  //       needsSync: needsSync,
  //     ),
  //   )),
  // );

  runApp(ProviderScope(
    child: App(
      key: const ValueKey('DATARUN_MAIN_APP'),
    ),
  ));
}

class App extends ConsumerWidget {
  App({super.key});

  final _appRouter = appLocator<AppRouter>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language =
        ref.watch(preferenceNotifierProvider(Preference.language)) as String;
    final seed = ref.watch(preferenceNotifierProvider(Preference.colorSeed));
    final mode = ref.watch(preferenceNotifierProvider(Preference.themeMode));
    final colorSeed = ColorSeed.values[seed];
    final useMaterial3 =
        ref.watch(preferenceNotifierProvider(Preference.useMaterial3));
    final themeMode = ThemeMode.values[mode];
    Locale locale = Locale(language, language == 'en' ? 'en_US' : '');
    timeago.setLocaleMessages(
        language,
        switch (language) {
          'ar' => timeago.ArMessages(),
          'en' => timeago.EnMessages(),
          String() => timeago.ArMessages(),
        });

    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        restorationScopeId: 'Test__',
        title: 'Datarun',
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: getTheme(colorSeed, useMaterial3),
        darkTheme: getDarkTheme(colorSeed, useMaterial3),
        localizationsDelegates: localizationsDelegates,
        supportedLocales: supportedLocales,
        locale: locale,
        builder: (context, child) {
          return Banner(
            message: AppEnvironment.envLabel,
            location: BannerLocation.topEnd,
            color: Colors.redAccent,
            child: child,
          );
        },
      ),
    );
    // return GlobalLoaderOverlay(
    //   child: MaterialApp(
    //     restorationScopeId: 'Test__',
    //     navigatorKey: StackedService.navigatorKey,
    //     title: 'Datarun',
    //     debugShowCheckedModeBanner: false,
    //     themeMode: themeMode,
    //     theme: getTheme(colorSeed, useMaterial3),
    //     darkTheme: getDarkTheme(colorSeed, useMaterial3),
    //     localizationsDelegates: localizationsDelegates,
    //     supportedLocales: supportedLocales,
    //     locale: locale,
    //     // stacked
    //     initialRoute: Routes.startupView,
    //     onGenerateRoute: StackedRouter().onGenerateRoute,
    //     navigatorObservers: [
    //       StackedService.routeObserver,
    //     ],
    //     builder: (context, child) {
    //       return Banner(
    //         message: AppEnvironment.envLabel,
    //         location: BannerLocation.topEnd,
    //         color: Colors.redAccent,
    //         child: child,
    //       );
    //     },
    //   ),
    // );
  }

  ThemeData getTheme(ColorSeed colorSeed, bool useMaterial3) => ThemeData(
        fontFamily: 'Rubik',
        colorScheme: ColorScheme.fromSeed(
            seedColor: colorSeed.color, brightness: Brightness.light),
        useMaterial3: useMaterial3,
        brightness: Brightness.light,
      );

  ThemeData getDarkTheme(ColorSeed colorSeed, bool useMaterial3) => ThemeData(
        fontFamily: 'Rubik',
        colorScheme: ColorScheme.fromSeed(
            seedColor: colorSeed.color, brightness: Brightness.dark),
        useMaterial3: useMaterial3,
        brightness: Brightness.dark,
      );

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
}
