// // main.dart
// import 'package:datarunmobile/app/di/injection.dart';
// import 'package:datarunmobile/core/auth/auth_manager.dart';
// import 'package:datarunmobile/core/auth/sdk_auth_manager.dart';
// import 'package:datarunmobile/core/user_session/locale_service.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:datarunmobile/l10n/app_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get_it/get_it.dart';
// import 'package:intl/intl.dart'; // For formatting dates/numbers based on locale
// import 'package:provider/provider.dart';
//
// // Initialize GetIt instance
// final GetIt getIt = GetIt.instance;
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   WidgetsFlutterBinding.ensureInitialized();
//   await configureDependencies();
//
//   FlutterError.demangleStackTrace = (StackTrace stack) {
//     if (stack is stack_trace.Trace) {
//       return stack.vmTrace;
//     }
//     if (stack is stack_trace.Chain) {
//       return stack.toTrace().vmTrace;
//     }
//     return stack;
//   };
//
//   runApp(const ProviderScope(
//     child: MyApp(key: ValueKey('DATARUN_MAIN_APP')),
//   ));
//   // runApp(
//   //   MultiProvider(
//   //     providers: [
//   //       // Provide AuthService globally to manage authentication state
//   //       ChangeNotifierProvider<AuthManager>(
//   //         create: (_) => getIt<AuthManager>(),
//   //       ),
//   //     ],
//   //     child: const MyApp(),
//   //   ),
//   // );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Watch the authentication status from AuthService
//     final authService = appLocator<AuthManager>();
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
//       // Dynamically set locale based on the LocaleService (if authenticated)
//       localeResolutionCallback:
//           (Locale? locale, Iterable<Locale> supportedLocales) {
//         if (authService.status == AuthStatus.authenticated) {
//           final userLocale = getIt<LocaleService>().currentLocale;
//           if (userLocale != null) {
//             // If the user has a specific locale set, use that
//             return userLocale;
//           }
//         }
//         // Otherwise, use the device locale or default to English
//         for (var supportedLocale in supportedLocales) {
//           if (supportedLocale.languageCode == locale?.languageCode) {
//             return supportedLocale;
//           }
//         }
//         return supportedLocales
//             .first; // Fallback to the first supported locale (e.g., en)
//       },
//       // Defined in app_localizations.dart
//       home: Builder(
//         builder: (context) {
//           // Based on the authentication status, show the appropriate screen
//           switch (authService.status) {
//             case AuthStatus.unknown:
//               return const SplashScreen(); // Show splash while checking auth
//             case AuthStatus.unauthenticated:
//               return const LoginScreen(); // Show login if not authenticated
//             case AuthStatus.authenticated:
//               // If authenticated, provide session-scoped services to the Home screen
//               // This ensures LocaleService and ServerUrlService are available
//               // only when a user is logged in.
//               return MultiProvider(
//                 providers: [
//                   ChangeNotifierProvider<LocaleService>(
//                     create: (_) => getIt<LocaleService>(),
//                   ),
//                   ChangeNotifierProvider<ServerUrlService>(
//                     create: (_) => getIt<ServerUrlService>(),
//                   ),
//                 ],
//                 child: const HomeScreen(),
//               );
//           }
//         },
//       ),
//     );
//   }
// }
//
// /// A simple splash screen displayed while the app is checking authentication status.
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
//             ),
//             SizedBox(height: 20),
//             Text(
//               'Checking session...',
//               style: TextStyle(fontSize: 18, color: Colors.blueGrey),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// /// The login screen where users can enter their credentials.
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController =
//       TextEditingController(text: 'test@example.com');
//   final TextEditingController _passwordController =
//       TextEditingController(text: 'password');
//   bool _isLoading = false;
//
//   Future<void> _login() async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       await Provider.of<AuthService>(context, listen: false).login(
//         _emailController.text,
//         _passwordController.text,
//       );
//       // Login successful, UI will automatically navigate to HomeScreen via MyApp's consumer
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content:
//               Text(AppLocalizations.of(context)!.loginFailed(e.toString())),
//           // Localized message
//           backgroundColor: Colors.red,
//         ),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final appLocalizations =
//         AppLocalizations.of(context)!; // Get localized strings
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(appLocalizations.loginTitle), // Localized title
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24.0),
//           child: Card(
//             elevation: 8,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             child: Padding(
//               padding: const EdgeInsets.all(24.0),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     appLocalizations.welcomeMessage, // Localized welcome
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Theme.of(context).primaryColor,
//                     ),
//                   ),
//                   const SizedBox(height: 30),
//                   TextField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       labelText: appLocalizations.emailLabel, // Localized label
//                       prefixIcon: const Icon(Icons.email),
//                     ),
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   const SizedBox(height: 20),
//                   TextField(
//                     controller: _passwordController,
//                     decoration: InputDecoration(
//                       labelText: appLocalizations.passwordLabel,
//                       // Localized label
//                       prefixIcon: const Icon(Icons.lock),
//                     ),
//                     obscureText: true,
//                   ),
//                   const SizedBox(height: 30),
//                   _isLoading
//                       ? const CircularProgressIndicator()
//                       : ElevatedButton(
//                           onPressed: _login,
//                           child: Text(appLocalizations
//                               .loginButton), // Localized button text
//                         ),
//                   const SizedBox(height: 20),
//                   Text(
//                     appLocalizations.testCredentialsHint, // Localized hint
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // Get the GetIt instance
// final GetIt getIt = GetIt.instance;
//
// /// The home screen displayed after successful authentication.
// /// It displays user-specific data managed by session-scoped services.
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // Access AuthService for logout functionality
//     final authService = Provider.of<AuthService>(context, listen: false);
//     // Access session-scoped services using Provider.of or context.watch
//     // These services are provided by the MultiProvider in main.dart when authenticated
//     final localeService = Provider.of<LocaleService>(context);
//     final serverUrlService = Provider.of<ServerUrlService>(context);
//
//     // Access the current user from GetIt's session scope
//     final User currentUser = getIt<User>(instanceName: 'currentUser');
//
//     final appLocalizations =
//         AppLocalizations.of(context)!; // Get localized strings
//
//     // Example of using intl for date formatting based on the current locale
//     final formattedDate =
//         DateFormat.yMMMd(localeService.currentLocale?.languageCode)
//             .format(DateTime.now());
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(appLocalizations.homeTitle),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.logout),
//             tooltip: appLocalizations.logoutButton,
//             onPressed: () async {
//               await authService.logout();
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Column(
//                     children: [
//                       Text(
//                         appLocalizations.loggedInAs(currentUser.name),
//                         style: const TextStyle(
//                             fontSize: 24, fontWeight: FontWeight.bold),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 10),
//                       Text(
//                         '${appLocalizations.emailLabel}: ${currentUser.email}',
//                         style:
//                             const TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                       const SizedBox(height: 20),
//                       Divider(color: Colors.grey[300]),
//                       const SizedBox(height: 20),
//                       // Display session-scoped locale
//                       _buildInfoRow(
//                         context,
//                         Icons.language,
//                         appLocalizations.currentLocaleLabel,
//                         localeService.currentLocale?.languageCode
//                                 .toUpperCase() ??
//                             'N/A',
//                       ),
//                       const SizedBox(height: 10),
//                       // Display session-scoped server URL
//                       _buildInfoRow(
//                         context,
//                         Icons.cloud,
//                         appLocalizations.serverUrlLabel,
//                         serverUrlService.currentUrl ?? 'N/A',
//                       ),
//                       const SizedBox(height: 10),
//                       _buildInfoRow(
//                         context,
//                         Icons.calendar_today,
//                         appLocalizations.currentDateLabel,
//                         formattedDate,
//                       ),
//                       const SizedBox(height: 30),
//                       Text(
//                         appLocalizations.changeSettingsHint,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30),
//               // Buttons to change session-scoped data
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton.icon(
//                     icon: const Icon(Icons.translate),
//                     label: Text(appLocalizations.changeLocaleButton),
//                     onPressed: () {
//                       _showLocaleChangeDialog(context, localeService);
//                     },
//                   ),
//                   ElevatedButton.icon(
//                     icon: const Icon(Icons.settings_ethernet),
//                     label: Text(appLocalizations.changeServerUrlButton),
//                     onPressed: () {
//                       _showServerUrlChangeDialog(context, serverUrlService);
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(
//       BuildContext context, IconData icon, String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Icon(icon, color: Theme.of(context).primaryColor, size: 20),
//               const SizedBox(width: 10),
//               Text(
//                 label,
//                 style:
//                     const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
//               ),
//             ],
//           ),
//           Flexible(
//             child: Text(
//               value,
//               style: const TextStyle(fontSize: 16, color: Colors.black87),
//               textAlign: TextAlign.right,
//               overflow: TextOverflow.ellipsis,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Shows a dialog to change the current locale.
//   void _showLocaleChangeDialog(
//       BuildContext context, LocaleService localeService) {
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: Text(AppLocalizations.of(context)!.selectLocale),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: AppLocalizations.supportedLocales.map((locale) {
//               return ListTile(
//                 title: Text(locale.languageCode.toUpperCase()),
//                 onTap: () {
//                   localeService.setLocale(locale);
//                   // To immediately reflect the locale change in the entire app,
//                   // we need to rebuild the MaterialApp. This is handled by
//                   // the localeResolutionCallback in main.dart reacting to LocaleService updates.
//                   Navigator.of(dialogContext).pop();
//                 },
//               );
//             }).toList(),
//           ),
//         );
//       },
//     );
//   }
//
//   /// Shows a dialog to change the current server URL.
//   void _showServerUrlChangeDialog(
//       BuildContext context, ServerUrlService serverUrlService) {
//     final TextEditingController urlController =
//         TextEditingController(text: serverUrlService.currentUrl);
//     showDialog(
//       context: context,
//       builder: (BuildContext dialogContext) {
//         return AlertDialog(
//           title: Text(AppLocalizations.of(context)!.enterNewServerUrl),
//           content: TextField(
//             controller: urlController,
//             decoration: InputDecoration(
//               hintText: AppLocalizations.of(context)!.serverUrlHint,
//               border: const OutlineInputBorder(),
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text(AppLocalizations.of(context)!.cancelButton),
//               onPressed: () {
//                 Navigator.of(dialogContext).pop();
//               },
//             ),
//             ElevatedButton(
//               child: Text(AppLocalizations.of(context)!.saveButton),
//               onPressed: () {
//                 serverUrlService.setServerUrl(urlController.text);
//                 Navigator.of(dialogContext).pop();
//               },
//             ),
//           ],
//         );
//       },
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
