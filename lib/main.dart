import 'dart:async';
import 'dart:io';

import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/authenticated_user.dart';
import 'package:datarun/app/app.bottomsheets.dart';
import 'package:datarun/app/app.dialogs.dart';
import 'package:datarun/app/app.locator.dart';
import 'package:datarun/app/app.router.dart';
import 'package:datarun/app/di/injection.dart';
import 'package:datarun/core/auth/user_session_manager.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:datarun/main.reflectable.dart';
import 'package:datarun/main_constants/main_constants.dart';
import 'package:datarun/utils/user_preferences/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:stacked_services/stacked_services.dart';
import 'package:timeago/timeago.dart' as timeago;

// import 'package:sentry_flutter/sentry_flutter.dart';

AuthenticationResult? authenticationResult;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();

  // stacked
  await configureDependencies();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  //

  final sharedPreferences = await SharedPreferences.getInstance();

  // await ConnectivityService.instance.initialize();

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) {
      return stack.vmTrace;
    }
    if (stack is stack_trace.Chain) {
      return stack.toTrace().vmTrace;
    }
    return stack;
  };

  // final userSessionManager = UserSessionManager(sharedPreferences);
  //
  // final authService = AuthService(userSessionManager);

  // does the user have active session in preference (local check)
  // final bool hasExistingSession = userSessionManager.isAuthenticated;
  // final bool needsSync = userSessionManager.needsSync();
  final bool hasExistingSession = locator<UserSessionManager>().isAuthenticated;
  final bool needsSync = locator<UserSessionManager>().needsSync();
  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // is has active session initialize, otherwise it will be initialized
  // by user login in.
  if (hasExistingSession) {
    await D2Remote.initialize(databaseFactory: databaseFactory);
  }

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
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      // authServiceProvider.overrideWithValue(authService),
      // userSessionManagerProvider.overrideWithValue(userSessionManager),
    ],
    child: App(
      key: ValueKey('DATARUN_MAIN_APP'),
      isAuthenticated: hasExistingSession,
      needsSync: needsSync,
    ),
  ));
}

class App extends ConsumerWidget {
  const App({
    super.key,
    required this.isAuthenticated,
    required this.needsSync,
  });

  final bool isAuthenticated;
  final bool needsSync;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(preferenceNotifierProvider(Preference.language));
    final colorSeed = ColorSeed
        .values[ref.watch(preferenceNotifierProvider(Preference.colorSeed))];
    final useMaterial3 =
        ref.watch(preferenceNotifierProvider(Preference.useMaterial3));
    final themeMode = ThemeMode
        .values[ref.watch(preferenceNotifierProvider(Preference.themeMode))];
    Locale locale = Locale(language, language == 'en' ? 'en_US' : '');
    timeago.setLocaleMessages(
        language,
        switch (language) {
          'ar' => timeago.ArMessages(),
          'en' => timeago.EnMessages(),
          String() => timeago.ArMessages(),
        });

    return MaterialApp(
      restorationScopeId: 'Test__',
      navigatorKey: StackedService.navigatorKey,
      // navigatorKey: StackedService.navigatorKey,
      title: 'Datarun',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: getTheme(colorSeed, useMaterial3),
      darkTheme: getDarkTheme(colorSeed, useMaterial3),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      locale: locale,
      // stacked
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorObservers: [
        StackedService.routeObserver,
      ],

      // home: AuthSyncWrapper(
      //   isAuthenticated: isAuthenticated,
      //   needsSync: needsSync,
      // ),
    );
  }

  ThemeData getTheme(ColorSeed colorSeed, bool useMaterial3) => ThemeData(
        // fontFamily: GoogleFonts.rubik().fontFamily,
        // textTheme: Typography.blackHelsinki.copyWith(),
        fontFamily: 'Rubik',
        colorScheme: ColorScheme.fromSeed(
            seedColor: colorSeed.color, brightness: Brightness.light),
        useMaterial3: useMaterial3,
        brightness: Brightness.light,
      );

  ThemeData getDarkTheme(ColorSeed colorSeed, bool useMaterial3) => ThemeData(
        // colorSchemeSeed: colorSeed.color,
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
    // L.delegate,
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];
}
