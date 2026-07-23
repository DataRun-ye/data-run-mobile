import 'dart:async';

import 'package:datarunmobile/di/app_environment.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/app/stacked/app.router.dart';
import 'package:datarunmobile/core/main_constants.dart';
import 'package:datarunmobile/core/telemetry/app_telemetry.dart';
import 'package:datarunmobile/core/user_session/app_locale_policy.dart';
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
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SentryFlutter.init(
    AppTelemetry.configure,
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await configureDependencies();

      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
      ));

      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

      FlutterError.demangleStackTrace = (StackTrace stack) {
        if (stack is stack_trace.Trace) {
          return stack.vmTrace;
        }
        if (stack is stack_trace.Chain) {
          return stack.toTrace().vmTrace;
        }
        return stack;
      };

      timeago.setLocaleMessages('ar', timeago.ArMessages());
      timeago.setLocaleMessages('en', timeago.EnMessages());

      runApp(SentryWidget(
        child: const ProviderScope(
          child: App(key: ValueKey('DATARUN_MAIN_APP')),
        ),
      ));
    },
  );
}

class App extends ConsumerWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language =
        ref.watch(preferenceProvider(Preference.language)) as String;

    final seed = ref.watch(preferenceProvider(Preference.colorSeed));
    final mode = ref.watch(preferenceProvider(Preference.themeMode));
    final colorSeed = ColorSeed.values[seed];
    final themeMode = ThemeMode.values[mode];

    return MaterialApp(
      restorationScopeId: 'Test__',
      navigatorKey: StackedService.navigatorKey,
      title: 'Datarun',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: buildTheme(
          colorSeed: colorSeed,
          base: ThemeData.light(useMaterial3: true),
          platform: Theme.of(context).platform),
      darkTheme: buildTheme(
          colorSeed: colorSeed,
          base: ThemeData.dark(useMaterial3: true),
          platform: Theme.of(context).platform,
          brightness: Brightness.dark),
      locale: AppLocalePolicy.explicitLocale(language, supportedLocales),
      localizationsDelegates: localizationsDelegates,
      supportedLocales: supportedLocales,
      localeListResolutionCallback: (deviceLocales, supportedLocales) =>
          AppLocalePolicy.resolveDeviceOrFallback(
        deviceLocales: deviceLocales,
        supportedLocales: supportedLocales,
        buildFallbackLanguage: AppEnvironment.defaultLocale,
      ),
      // stacked
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorObservers: [
        SentryNavigatorObserver(), // Automatically tracks screen navigation breadcrumbs
        StackedService.routeObserver,
      ],
      //
      initialRoute: Routes.splashView,
    );
  }

  final supportedLocales = const <Locale>[
    Locale('en'),
    Locale('ar'),
  ];

  final localizationsDelegates = const <LocalizationsDelegate<dynamic>>[
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  ThemeData buildTheme(
      {required ColorSeed colorSeed,
      required ThemeData base,
      required TargetPlatform platform,
      Brightness brightness = Brightness.light}) {
    final cs = ColorScheme.fromSeed(
        seedColor: colorSeed.color, brightness: brightness, contrastLevel: 0.5);

    final bool isDark = brightness == Brightness.dark;

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
        ),
      ),
      dividerTheme: DividerThemeData(
        color: cs.primary,
        thickness: 0.3,
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
      chipTheme: base.chipTheme.copyWith(
        secondarySelectedColor: cs.primaryFixedDim,
        checkmarkColor: DColors.Orange600,
        elevation: 2,
        pressElevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: cs.outline.withValues(alpha: .3)),
        ),
      ),
      splashColor: cs.primary.withValues(alpha: 0.08),
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
