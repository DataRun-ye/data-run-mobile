import 'dart:async';

import 'package:datarunmobile/core/main_constants.dart';
import 'package:datarunmobile/data/preference.provider.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/app/theme/app_theme.dart';
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
          _ => timeago.ArMessages(),
        });

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
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      locale: locale,
      // stacked
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,

      navigatorObservers: [
        StackedService.routeObserver,
      ],
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
}
