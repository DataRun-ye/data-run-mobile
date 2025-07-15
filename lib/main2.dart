// // We don't have an actual instance of SharedPreferences, and we can't get one except asynchronously
// import 'package:d_sdk/core/logging/new_app_logging.dart';
// import 'package:datarunmobile/features/login/presentation/login_view.dart';
// import 'package:datarunmobile/features/startup/presentation/loading_screen.dart';
// import 'package:datarunmobile/l10n/app_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// final sharedPreferencesProvider =
//     Provider<SharedPreferences>((ref) => throw UnimplementedError());
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // Show a loading indicator before running the full app (optional)
//   // The platform's loading screen will be used while awaiting if you omit this.
//   runApp(const ProviderScope(child: LoadingScreen()));
//
//   // Get the instance of shared preferences
//   final prefs = await SharedPreferences.getInstance();
//   logDebug('delay for 4 sec');
//   await Future.delayed(const Duration(seconds: 4));
//
//   return runApp(
//     ProviderScope(
//       overrides: [
//         // Override the unimplemented provider with the value gotten from the plugin
//         sharedPreferencesProvider.overrideWithValue(prefs),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// // // main.dart
// // import 'package:datarunmobile/app/di/injection.dart';
// // import 'package:datarunmobile/core/auth/sdk_auth_manager.dart';
// // import 'package:datarunmobile/core/auth/sdk_auth_manager.dart';
// // import 'package:datarunmobile/core/user_session/locale_service.dart';
// // import 'package:datarunmobile/generated/l10n.dart';
// // import 'package:datarunmobile/l10n/app_localization.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_localizations/flutter_localizations.dart';
// // import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// // import 'package:get_it/get_it.dart';
// // import 'package:intl/intl.dart'; // For formatting dates/numbers based on locale
// // import 'package:provider/provider.dart';
// //
// // // Initialize GetIt instance
// // final GetIt getIt = GetIt.instance;
// //
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await configureDependencies();
// //
// //   FlutterError.demangleStackTrace = (StackTrace stack) {
// //     if (stack is stack_trace.Trace) {
// //       return stack.vmTrace;
// //     }
// //     if (stack is stack_trace.Chain) {
// //       return stack.toTrace().vmTrace;
// //     }
// //     return stack;
// //   };
// //
// //   runApp(const ProviderScope(
// //     child: MyApp(key: ValueKey('DATARUN_MAIN_APP')),
// //   ));
// //   // runApp(
// //   //   MultiProvider(
// //   //     providers: [
// //   //       // Provide AuthService globally to manage authentication state
// //   //       ChangeNotifierProvider<AuthManager>(
// //   //         create: (_) => getIt<AuthManager>(),
// //   //       ),
// //   //     ],
// //   //     child: const MyApp(),
// //   //   ),
// //   // );
// // }
// //
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // // Watch the authentication status from AuthService
//     // final authService = appLocator<AuthManager>();
//
//     return MaterialApp(
//       title: 'GetIt Scoped Sessions',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         useMaterial3: true,
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.blueAccent,
//           foregroundColor: Colors.white,
//           centerTitle: true,
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blueAccent,
//             foregroundColor: Colors.white,
//             padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             textStyle:
//                 const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ),
//         inputDecorationTheme: InputDecorationTheme(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//           filled: true,
//           fillColor: Colors.blueGrey[50],
//           contentPadding:
//               const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
//         ),
//       ),
//       // Setup internationalization
//       localizationsDelegates: AppLocalizations.localizationsDelegates,
//       supportedLocales: AppLocalizations.supportedLocales,
//       // Defined in app_localizations.dart
//       home: LoginView(),
//     );
//   }
// }
//
// // l10n/app_en.arb
// // {
// //   "@@locale": "en",
// //   "loginTitle": "Login",
// //   "welcomeMessage": "Welcome to GetIt Scopes Demo!",
// //   "emailLabel": "Email",
// //   "passwordLabel": "Password",
// //   "loginButton": "Login",
// //   "testCredentialsHint": "Use test@example.com and 'password' to log in.",
// //   "loginFailed": "Login failed: {error}",
// //   "@loginFailed": {
// //     "placeholders": {
// //       "error": {}
// //     }
// //   },
// //   "homeTitle": "Home Screen",
// //   "logoutButton": "Logout",
// //   "loggedInAs": "Logged in as {userName}",
// //   "@loggedInAs": {
// //     "placeholders": {
// //       "userName": {}
// //     }
// //   },
// //   "currentLocaleLabel": "Current Locale",
// //   "serverUrlLabel": "Server URL",
// //   "currentDateLabel": "Current Date",
// //   "changeLocaleButton": "Change Locale",
// //   "changeServerUrlButton": "Change Server URL",
// //   "selectLocale": "Select Locale",
// //   "enterNewServerUrl": "Enter New Server URL",
// //   "serverUrlHint": "e.g., https://api.myserver.com",
// //   "cancelButton": "Cancel",
// //   "saveButton": "Save"
// // }
//
// // l10n/app_es.arb
// // {
// //   "@@locale": "es",
// //   "loginTitle": "Iniciar Sesión",
// //   "welcomeMessage": "¡Bienvenido a la demostración de GetIt Scopes!",
// //   "emailLabel": "Correo Electrónico",
// //   "passwordLabel": "Contraseña",
// //   "loginButton": "Iniciar Sesión",
// //   "testCredentialsHint": "Usa test@example.com y 'password' para iniciar sesión.",
// //   "loginFailed": "Fallo al iniciar sesión: {error}",
// //   "@loginFailed": {
// //     "placeholders": {
// //       "error": {}
// //     }
// //   },
// //   "homeTitle": "Pantalla de Inicio",
// //   "logoutButton": "Cerrar Sesión",
// //   "loggedInAs": "Sesión iniciada como {userName}",
// //   "@loggedInAs": {
// //     "placeholders": {
// //       "userName": {}
// //     }
// //   },
// //   "currentLocaleLabel": "Idioma Actual",
// //   "serverUrlLabel": "URL del Servidor",
// //   "currentDateLabel": "Fecha Actual",
// //   "changeLocaleButton": "Cambiar Idioma",
// //   "changeServerUrlButton": "Cambiar URL del Servidor",
// //   "selectLocale": "Seleccionar Idioma",
// //   "enterNewServerUrl": "Ingresar Nueva URL del Servidor",
// //   "serverUrlHint": "ej., https://api.miservidor.com",
// //   "cancelButton": "Cancelar",
// //   "saveButton": "Guardar"
// // }
//
// // l10n/app_fr.arb
// // {
// //   "@@locale": "fr",
// //   "loginTitle": "Connexion",
// //   "welcomeMessage": "Bienvenue dans la démo des Scopes GetIt !",
// //   "emailLabel": "E-mail",
// //   "passwordLabel": "Mot de passe",
// //   "loginButton": "Connexion",
// //   "testCredentialsHint": "Utilisez test@example.com et 'password' pour vous connecter.",
// //   "loginFailed": "Échec de la connexion : {error}",
// //   "@loginFailed": {
// //     "placeholders": {
// //       "error": {}
// //     }
// //   },
// //   "homeTitle": "Écran d'accueil",
// //   "logoutButton": "Déconnexion",
// //   "loggedInAs": "Connecté en tant que {userName}",
// //   "@loggedInAs": {
// //     "placeholders": {
// //       "userName": {}
// //     }
// //   },
// //   "currentLocaleLabel": "Langue Actuelle",
// //   "serverUrlLabel": "URL du Serveur",
// //   "currentDateLabel": "Date Actuelle",
// //   "changeLocaleButton": "Changer de Langue",
// //   "changeServerUrlButton": "Changer l'URL du Serveur",
// //   "selectLocale": "Sélectionner la Langue",
// //   "enterNewServerUrl": "Entrer la Nouvelle URL du Serveur",
// //   "serverUrlHint": "ex., https://api.monserveur.com",
// //   "cancelButton": "Annuler",
// //   "saveButton": "Enregistrer"
// // }
//
// // l10n/app_localizations.dart (Generated file, typically you don't write this manually)
// // To generate this file and others:
// // 1. Add `flutter_localizations` and `intl` to `pubspec.yaml`.
// // 2. Enable `generate: true` under `flutter:` in `pubspec.yaml`.
// // 3. Create `l10n.yaml` in the project root with:
// //    arb-dir: lib/l10n
// //    template-arb-file: app_en.arb
// //    output-localization-file: app_localizations.dart
// // 4. Run `flutter gen-l10n` or `flutter run`.
//
// // Example of how AppLocalizations.dart would look (simplified):
// // import 'package:flutter/widgets.dart';
// // import 'package:flutter/foundation.dart';
// //
// // class AppLocalizations {
// //   AppLocalizations(this.localeName);
// //
// //   final String localeName;
// //
// //   static AppLocalizations? of(BuildContext context) {
// //     return Localizations.of<AppLocalizations>(context, AppLocalizations);
// //   }
// //
// //   static const LocalizationsDelegate<AppLocalizations> delegate =
// //       _AppLocalizationsDelegate();
// //
// //   /// A list of this localizations delegate's supported locales.
// //   static const List<Locale> supportedLocales = <Locale>[
// //     Locale('en'),
// //     Locale('es'),
// //     Locale('fr'),
// //   ];
// //
// //   String get loginTitle {
// //     return Intl.message(
// //       'Login',
// //       name: 'loginTitle',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get welcomeMessage {
// //     return Intl.message(
// //       'Welcome to GetIt Scopes Demo!',
// //       name: 'welcomeMessage',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get emailLabel {
// //     return Intl.message(
// //       'Email',
// //       name: 'emailLabel',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get passwordLabel {
// //     return Intl.message(
// //       'Password',
// //       name: 'passwordLabel',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get loginButton {
// //     return Intl.message(
// //       'Login',
// //       name: 'loginButton',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get testCredentialsHint {
// //     return Intl.message(
// //       'Use test@example.com and \'password\' to log in.',
// //       name: 'testCredentialsHint',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String loginFailed(Object error) {
// //     return Intl.message(
// //       'Login failed: $error',
// //       name: 'loginFailed',
// //       desc: '',
// //       args: [error],
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get homeTitle {
// //     return Intl.message(
// //       'Home Screen',
// //       name: 'homeTitle',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get logoutButton {
// //     return Intl.message(
// //       'Logout',
// //       name: 'logoutButton',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String loggedInAs(Object userName) {
// //     return Intl.message(
// //       'Logged in as $userName',
// //       name: 'loggedInAs',
// //       desc: '',
// //       args: [userName],
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get currentLocaleLabel {
// //     return Intl.message(
// //       'Current Locale',
// //       name: 'currentLocaleLabel',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get serverUrlLabel {
// //     return Intl.message(
// //       'Server URL',
// //       name: 'serverUrlLabel',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get currentDateLabel {
// //     return Intl.message(
// //       'Current Date',
// //       name: 'currentDateLabel',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get changeLocaleButton {
// //     return Intl.message(
// //       'Change Locale',
// //       name: 'changeLocaleButton',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get changeServerUrlButton {
// //     return Intl.message(
// //       'Change Server URL',
// //       name: 'changeServerUrlButton',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get selectLocale {
// //     return Intl.message(
// //       'Select Locale',
// //       name: 'selectLocale',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get enterNewServerUrl {
// //     return Intl.message(
// //       'Enter New Server URL',
// //       name: 'enterNewServerUrl',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get serverUrlHint {
// //     return Intl.message(
// //       'e.g., https://api.myserver.com',
// //       name: 'serverUrlHint',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get cancelButton {
// //     return Intl.message(
// //       'Cancel',
// //       name: 'cancelButton',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// //
// //   String get saveButton {
// //     return Intl.message(
// //       'Save',
// //       name: 'saveButton',
// //       desc: '',
// //       locale: localeName,
// //     );
// //   }
// // }
// //
// // class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
// //   const _AppLocalizationsDelegate();
// //
// //   @override
// //   Future<AppLocalizations> load(Locale locale) {
// //     return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
// //   }
// //
// //   @override
// //   bool isSupported(Locale locale) => AppLocalizations.supportedLocales.contains(locale);
// //
// //   @override
// //   bool shouldReload(_AppLocalizationsDelegate old) => false;
// // }
// //
// // AppLocalizations lookupAppLocalizations(Locale locale) {
// //   // This is a simplified lookup. In a real generated file,
// //   // it would have a switch case or map to return the correct
// //   // AppLocalizations instance based on the locale.
// //   switch (locale.languageCode) {
// //     case 'en':
// //       return AppLocalizations('en');
// //     case 'es':
// //       return AppLocalizations('es');
// //     case 'fr':
// //       return AppLocalizations('fr');
// //     default:
// //       return AppLocalizations('en'); // Fallback
// //   }
// // }
