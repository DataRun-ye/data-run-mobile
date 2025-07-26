import 'dart:async';

import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/auth/ref_extension.provider.dart';
import 'package:datarunmobile/core/main_constants.dart';
import 'package:datarunmobile/core/user_session/locale_service.dart';
import 'package:datarunmobile/core/user_session/preference.provider.dart';
import 'package:datarunmobile/features/common_ui_element/common/app_colors.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show SystemUiOverlayStyle, SystemChrome, SystemUiMode;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:stacked_services/stacked_services.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    // to control the icon brightness on the status bar
    statusBarIconBrightness: Brightness.dark,
    // For light background content
    // statusBarIconBrightness: Brightness.light, // For dark background content
    // to control the icon brightness on the navigation bar
    systemNavigationBarIconBrightness: Brightness.dark,
    // For light background content
    // systemNavigationBarIconBrightness: Brightness.light, // For dark background content
    // The deprecated setNavigationBarDividerColor corresponds to systemNavigationBarDividerColor
    // Setting it to transparent or null effectively removes the divider color.
    systemNavigationBarDividerColor: Colors.transparent,
  ));

  // Ensures that the app can draw behind the system bars
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

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
      theme: buildTheme(
          colorSeed: colorSeed,
          base: ThemeData.light(useMaterial3: useMaterial3),
          platform: Theme.of(context).platform),
      darkTheme: buildTheme(
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

    timeago.setLocaleMessages(
        userLocale.languageCode,
        switch (userLocale.languageCode) {
          'ar' => timeago.ArMessages(),
          'en' => timeago.EnMessages(),
          _ => timeago.EnMessages(),
        });
    return userLocale;
  }

  ThemeData buildTheme(
      {required ColorSeed colorSeed,
      required ThemeData base,
      required TargetPlatform platform,
      Brightness brightness = Brightness.light}) {
    final cs = ColorScheme.fromSeed(
        seedColor: colorSeed.color, brightness: brightness, contrastLevel: 0.5);

    final bool isDark = brightness == Brightness.dark;

    // For surfaces that use primary color in light themes and surface color in dark
    final Color primarySurfaceColor = isDark ? cs.surface : cs.primary;
    final Color onPrimarySurfaceColor = isDark ? cs.onSurface : cs.onPrimary;

    final barBg = isDark ? cs.surface : cs.primary;
    final barFg = isDark ? cs.onSurface : cs.onPrimary;

    return base.copyWith(
      iconTheme: base.iconTheme.copyWith(color: cs.outlineVariant),
      colorScheme: cs,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      typography: Typography.material2021(platform: platform, colorScheme: cs),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cs.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          // textStyle: Typography.material2021().bodyMedium,
        ),
      ),
      tabBarTheme: base.tabBarTheme.copyWith(
        labelColor: barFg.withValues(alpha: 0.8),
        unselectedLabelColor: barFg.withValues(alpha: 0.5),
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: barBg,
        foregroundColor: barFg,
        centerTitle: true,
        iconTheme: IconThemeData(color: barFg.withValues(alpha: 0.6)),
        actionsIconTheme: IconThemeData(color: barFg),
        surfaceTintColor: barBg,
        systemOverlayStyle:
            isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardThemeData(
        color: cs.surfaceContainerLow,
        surfaceTintColor: cs.surfaceTint,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        // alignLabelWithHint: true,
        fillColor: isDark ? cs.surfaceContainerHighest : cs.surface,
        errorStyle: TextStyle(
            color: SurfaceColors.Error,
            backgroundColor: SurfaceColors.ErrorContainerHighest),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: SurfaceColors.Error, width: 2),
        ),
        hintStyle: TextStyle(
            color: cs.onSurfaceVariant.withValues(alpha: 0.8), fontSize: 13),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cs.outlineVariant, width: 0.5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: cs.primary, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cs.primary, width: 1),
        ),
        prefixIconColor: cs.onSurfaceVariant,
        floatingLabelStyle: TextStyle(color: cs.primary),
      ),
      //
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          // textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: cs.primary,
        thickness: 0.3,
        // space: 3,
        indent: 16,
        endIndent: 16,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          side: BorderSide(color: cs.outline),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: cs.secondary,
        foregroundColor: cs.onSecondary,
        elevation: 4,
      ),
      actionIconTheme: ActionIconThemeData(
        drawerButtonIconBuilder: (BuildContext context) {
          return const _CustomDrawerIcon();
        },
        endDrawerButtonIconBuilder: (BuildContext context) {
          return const _CustomEndDrawerIcon();
        },
      ),
      dataTableTheme: DataTableThemeData(
        headingRowColor:
            WidgetStateProperty.all(cs.primary.withValues(alpha: 0.08)),
        headingTextStyle: base.textTheme.titleSmall!.copyWith(
          color: cs.onSurface,
          fontWeight: FontWeight.w600,
        ),
        dataTextStyle: base.textTheme.bodyMedium!.copyWith(
          color: cs.onSurface,
        ),
        dividerThickness: 0.3,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: cs.outline),
            bottom: BorderSide(color: cs.outline),
          ),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return cs.primary;
          return cs.outline;
        }),
      ),
      textTheme: _buildShrineTextTheme(base.textTheme),
      // 1️⃣ Global ChipTheme (applies to basic Chip/ActionChip/InputChip)
      chipTheme: base.chipTheme.copyWith(
        secondarySelectedColor: cs.primaryFixedDim,
        checkmarkColor: DColors.Orange600,
        elevation: 3,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: cs.outline.withValues(alpha: .6)),
        ),
        // labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      ),
      splashColor: cs.primary.withValues(alpha: 0.08),
      // highlightColor: cs.primary.withValues(alpha:0.1),
      //
      // 2️⃣ FilterChip (for “multi‑select” filters)
      // filterChipTheme: FilterChipThemeData(
      //   selectedColor: cs.primary.withValues(alpha:0.16),
      //   checkmarkColor: cs.primary,
      //   backgroundColor: cs.surfaceVariant,
      //   disabledColor: cs.onSurface.withValues(alpha:0.12),
      //   labelStyle: base.textTheme.bodyMedium!,
      //   secondaryLabelStyle:
      //       base.textTheme.bodyMedium!.copyWith(color: cs.onPrimary),
      //   side: BorderSide(color: cs.outline),
      //   selectedShadowColor: cs.primary.withValues(alpha:0.24),
      //   elevation: 0,
      //   pressElevation: 2,
      //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(8),
      //   ),
      // ),
    );
  }

  TextTheme _buildShrineTextTheme(TextTheme base) {
    return base.apply(
      fontFamily: 'Rubik', //'Raleway',
    );
  }
}

class _CustomEndDrawerIcon extends StatelessWidget {
  const _CustomEndDrawerIcon();

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localization =
        MaterialLocalizations.of(context);
    return Icon(
      Icons.more_horiz,
      semanticLabel: localization.openAppDrawerTooltip,
    );
  }
}

class _CustomDrawerIcon extends StatelessWidget {
  const _CustomDrawerIcon();

  @override
  Widget build(BuildContext context) {
    final MaterialLocalizations localization =
        MaterialLocalizations.of(context);
    return Icon(
      Icons.segment,
      semanticLabel: localization.openAppDrawerTooltip,
    );
  }
}
