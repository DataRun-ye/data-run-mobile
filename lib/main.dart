import 'dart:async';
import 'dart:io';

import 'package:d2_remote/modules/datarun_shared/utilities/authenticated_user.dart';
import 'package:datarunmobile/app/app.bottomsheets.dart';
import 'package:datarunmobile/app/app.dialogs.dart';
import 'package:datarunmobile/app/app.locator.dart';
import 'package:datarunmobile/app/app.router.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/main_constants.dart';
import 'package:datarunmobile/data/preference.provider.dart';
import 'package:datarunmobile/generated/l10n.dart';
import 'package:datarunmobile/main.reflectable.dart';
import 'package:datarunmobile/ui/common/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:stacked_services/stacked_services.dart';
import 'package:timeago/timeago.dart' as timeago;

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

  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) {
      return stack.vmTrace;
    }
    if (stack is stack_trace.Chain) {
      return stack.toTrace().vmTrace;
    }
    return stack;
  };

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
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
      theme: _buildTheme(
          colorSeed: colorSeed,
          base: ThemeData.light(useMaterial3: useMaterial3),
          platform: Theme.of(context).platform),
      darkTheme: _buildTheme(
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

  ThemeData _buildTheme(
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
      colorScheme: cs,
      typography: Typography.material2021(platform: platform, colorScheme: cs),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: cs.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          // textStyle: Typography.material2021().bodyMedium,
        ),
      ),
      tabBarTheme: base.tabBarTheme.copyWith(
        labelColor: barFg.withOpacity(0.8),
        unselectedLabelColor: barFg.withOpacity(0.5),
      ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: barBg,
        foregroundColor: barFg,
        iconTheme: IconThemeData(color: barFg),
        actionsIconTheme: IconThemeData(color: barFg),
        surfaceTintColor: barBg,
        // M3 elevation tint :contentReference[oaicite:1]{index=1}
        systemOverlayStyle:
            isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      ),
      cardTheme: CardTheme(
          color: cs.surfaceContainerLow, surfaceTintColor: cs.surfaceTint),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        // alignLabelWithHint: true,
        fillColor: isDark ? cs.surfaceContainerHighest : cs.surface,
        errorStyle: TextStyle(color: SurfaceColors.Error, backgroundColor: SurfaceColors.ErrorContainerHighest),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: SurfaceColors.Error, width: 2),
        ),
        hintStyle: TextStyle(color: cs.onSurfaceVariant),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: cs.outlineVariant, width: 0.5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: cs.primary, width: 1),
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
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        ),
      ),

      // textButtonTheme: TextButtonThemeData(
      //   style: TextButton.styleFrom(
      //     foregroundColor: cs.primary,
      //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      //     textStyle: Typography.material2021().bodyMedium,
      //   ),
      // ),

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

      // bottomSheetTheme: base.bottomSheetTheme.copyWith(
      //   elevation: 2,
      //   surfaceTintColor: cs.surfaceTint,
      //   // backgroundColor: cs.surfaceContainer,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(16),
      //   ),
      // ),

      actionIconTheme: ActionIconThemeData(
        // backButtonIconBuilder: (BuildContext context) {
        //   return const Icon(Icons.arrow_back_ios_new_rounded);
        // },
        drawerButtonIconBuilder: (BuildContext context) {
          return const _CustomDrawerIcon();
        },
        endDrawerButtonIconBuilder: (BuildContext context) {
          return const _CustomEndDrawerIcon();
        },
      ),

      // 1️⃣ Global ChipTheme (applies to basic Chip/ActionChip/InputChip)
      // chipTheme: base.chipTheme.copyWith(
      //   backgroundColor:  cs.surfaceContainerLow,
      //   brightness: brightness,
      //   // selectedColor: DColors.Orange500,
      //   secondarySelectedColor: cs.primaryFixedDim, // label color when selected
      //   secondaryLabelStyle: base.textTheme.bodyMedium!.copyWith(
      //     color: isDark ? cs.onPrimary : cs.onSurface,
      //     fontWeight: FontWeight.w600,
      //   ),
      //   checkmarkColor: isDark ? cs.onPrimary : cs.onSurface,
      //   elevation: 1,
      //   labelStyle: base.textTheme.bodyMedium!.copyWith(
      //     color: isDark ? cs.onSurface : cs.onPrimary,
      //   ),
      //   disabledColor: cs.onSurface.withOpacity(0.12),
      //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(8),
      //     side: BorderSide(color: cs.outline),
      //   ),
      //   labelPadding: const EdgeInsets.symmetric(horizontal: 8),
      // ),
      // focusColor: cs.primary.withOpacity(0.12),
      // hoverColor: cs.primary.withOpacity(0.06),
      // splashColor: cs.primary.withOpacity(0.08),
      // highlightColor: cs.primary.withOpacity(0.1),
      dataTableTheme: DataTableThemeData(
        headingRowColor: WidgetStateProperty.all(cs.primary.withOpacity(0.08)),
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
      // 2️⃣ FilterChip (for “multi‑select” filters)
      // filterChipTheme: FilterChipThemeData(
      //   selectedColor: cs.primary.withOpacity(0.16),
      //   checkmarkColor: cs.primary,
      //   backgroundColor: cs.surfaceVariant,
      //   disabledColor: cs.onSurface.withOpacity(0.12),
      //   labelStyle: base.textTheme.bodyMedium!,
      //   secondaryLabelStyle:
      //       base.textTheme.bodyMedium!.copyWith(color: cs.onPrimary),
      //   side: BorderSide(color: cs.outline),
      //   selectedShadowColor: cs.primary.withOpacity(0.24),
      //   elevation: 0,
      //   pressElevation: 2,
      //   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(8),
      //   ),
      // ),
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

TextTheme _buildShrineTextTheme(TextTheme base) {
  return base
      // .copyWith(
      //   headlineSmall:
      //       base.headlineSmall!.copyWith(fontWeight: FontWeight.w500),
      //   titleLarge: base.titleLarge!.copyWith(fontSize: 18.0),
      //   bodySmall: base.bodySmall!
      //       .copyWith(fontWeight: FontWeight.w400, fontSize: 14.0),
      //   bodyLarge: base.bodyLarge!
      //       .copyWith(fontWeight: FontWeight.w500, fontSize: 16.0),
      //   labelLarge: base.labelLarge!
      //       .copyWith(fontWeight: FontWeight.w500, fontSize: 14.0),
      // )
      .apply(
    fontFamily: 'Rubik', //'Raleway',
  );
}

const ColorScheme kShrineColorScheme = ColorScheme(
  primary: AppColors.primary,
  secondary: DColors.Blue50,
  surface: DColors.NeutralVariant,
  error: DColors.Red600,
  onPrimary: AppColors.onPrimary,
  onInverseSurface: AppColors.onInverseSurface,
  onSurfaceVariant: AppColors.onSurfaceVariant,
  onSecondaryFixed: AppColors.onSecondaryFixed,
  onPrimaryContainer: AppColors.onPrimaryContainer,
  onSecondary: DColors.Blue900,
  onSurface: DColors.Blue900,
  onError: DColors.NeutralVariant,
  brightness: Brightness.light,
);

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
