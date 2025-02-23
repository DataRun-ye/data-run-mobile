import 'dart:async';
import 'dart:io';

import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/datarun_shared/utilities/authenticated_user.dart';
import 'package:datarun/commons/prefs/preference_provider.dart';
import 'package:datarun/core/auth/auth_service.dart';
import 'package:datarun/core/auth/user_session_manager.dart';
import 'package:datarun/data_run/screens/login_screen/auth_wrapper.dart';
import 'package:datarun/generated/l10n.dart';
import 'package:datarun/main.reflectable.dart';
import 'package:datarun/main_constants/main_constants.dart';
import 'package:datarun/utils/app_appearance.dart';
import 'package:datarun/utils/navigator_key.dart';
import 'package:datarun/utils/user_preferences/preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:timeago/timeago.dart' as timeago;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// import 'package:sentry_flutter/sentry_flutter.dart';

AuthenticationResult? authenticationResult;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeReflectable();
  await PreferenceProvider.initialize();
  final sharedPreferences = await SharedPreferences.getInstance();

  // // SDK initialization and repository setup
  // await D2Remote.initialize();

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

  final userSessionManager = UserSessionManager(sharedPreferences);

  final authService = AuthService(userSessionManager);

  // does the user have active session in preference (local check)
  final bool hasExistingSession = userSessionManager.isAuthenticated;
  final bool needsSync = userSessionManager.needsSync();
  DatabaseFactory? databaseFactory;
  if (Platform.isWindows) {
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
      authServiceProvider.overrideWithValue(authService),
      userSessionManagerProvider.overrideWithValue(userSessionManager),
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

    Locale locale = Locale(language, language == 'en' ? 'en_US' : '');
    timeago.setLocaleMessages(
        language,
        switch (language) {
          'ar' => timeago.ArMessages(),
          'en' => timeago.EnMessages(),
          String() => timeago.ArMessages(),
        });

    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Datarun',
      debugShowCheckedModeBanner: false,
      themeMode: ref.watch(appAppearanceNotifierProvider).themeMode,
      theme: getTheme(ref),
      darkTheme: getDarkTheme(ref),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      locale: locale,
      home: AuthSyncWrapper(
        isAuthenticated: isAuthenticated,
        needsSync: needsSync,
      ),
    );
  }

  ThemeData getTheme(WidgetRef ref) => ThemeData(
        colorSchemeSeed:
            ref.watch(appAppearanceNotifierProvider).colorSelectionMethod ==
                    ColorSelectionMethod.colorSeed
                ? ref.watch(appAppearanceNotifierProvider).colorSelected.color
                : null,
        colorScheme:
            ref.watch(appAppearanceNotifierProvider).colorSelectionMethod ==
                    ColorSelectionMethod.image
                ? ref.watch(appAppearanceNotifierProvider).imageColorScheme
                : null,
        useMaterial3: ref.watch(appAppearanceNotifierProvider).useMaterial3,
        brightness: Brightness.light,
      );

  ThemeData getDarkTheme(WidgetRef ref) => ThemeData(
        colorSchemeSeed: ref
                    .watch(appAppearanceNotifierProvider)
                    .colorSelectionMethod ==
                ColorSelectionMethod.colorSeed
            ? ref.watch(appAppearanceNotifierProvider).colorSelected.color
            : ref.watch(appAppearanceNotifierProvider).imageColorScheme.primary,
        useMaterial3: ref.watch(appAppearanceNotifierProvider).useMaterial3,
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
