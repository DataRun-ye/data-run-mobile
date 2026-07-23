import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/user_session/app_locale_policy.dart';
import 'package:datarunmobile/core/user_session/preference.provider.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const supportedLocales = <Locale>[
    Locale('en'),
    Locale('ar'),
  ];

  late SharedPreferences preferences;
  late ProviderContainer container;

  setUp(() async {
    await appLocator.reset();
    SharedPreferences.setMockInitialValues({});
    preferences = await SharedPreferences.getInstance();
    appLocator.registerSingleton<SharedPreferences>(preferences);
    container = ProviderContainer();
  });

  tearDown(() async {
    container.dispose();
    await appLocator.reset();
  });

  test('explicit supported preference is the only forced locale', () {
    expect(
      AppLocalePolicy.explicitLocale('ar', supportedLocales),
      const Locale('ar'),
    );
    expect(
      AppLocalePolicy.explicitLocale('en_US', supportedLocales),
      const Locale('en'),
    );
    expect(
      AppLocalePolicy.explicitLocale(
        AppLocalePolicy.noExplicitPreference,
        supportedLocales,
      ),
      isNull,
    );
    expect(
      AppLocalePolicy.explicitLocale('unsupported', supportedLocales),
      isNull,
    );
  });

  test('supported device locale wins before the build fallback', () {
    expect(
      AppLocalePolicy.resolveDeviceOrFallback(
        deviceLocales: const [Locale('ar', 'YE'), Locale('en', 'US')],
        supportedLocales: supportedLocales,
        buildFallbackLanguage: 'en',
      ),
      const Locale('ar'),
    );
  });

  test('build fallback is used for unsupported or absent device locales', () {
    expect(
      AppLocalePolicy.resolveDeviceOrFallback(
        deviceLocales: const [Locale('fr', 'FR')],
        supportedLocales: supportedLocales,
        buildFallbackLanguage: 'en',
      ),
      const Locale('en'),
    );
    expect(
      AppLocalePolicy.resolveDeviceOrFallback(
        deviceLocales: null,
        supportedLocales: supportedLocales,
        buildFallbackLanguage: 'ar',
      ),
      const Locale('ar'),
    );
  });

  test('invalid build fallback fails safely to Arabic', () {
    expect(
      AppLocalePolicy.resolveDeviceOrFallback(
        deviceLocales: const [Locale('fr')],
        supportedLocales: supportedLocales,
        buildFallbackLanguage: 'invalid',
      ),
      const Locale('ar'),
    );
  });

  test('explicit language choice survives a provider restart', () async {
    expect(
      container.read(preferenceProvider(Preference.language)),
      AppLocalePolicy.noExplicitPreference,
    );

    await container
        .read(preferenceProvider(Preference.language).notifier)
        .update('en');

    expect(preferences.getString(Preference.language.key), 'en');

    container.dispose();
    container = ProviderContainer();

    expect(
      container.read(preferenceProvider(Preference.language)),
      'en',
    );
  });
}
