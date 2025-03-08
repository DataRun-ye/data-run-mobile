// import 'package:datarun/core/auth/auth_service.dart';
// import 'package:datarun/core/auth/user_session_manager.dart';
// import 'package:datarun/data_run/screens/home_screen/drawer/settings_page.dart';
// import 'package:datarun/data_run/screens/home_screen/home_screen.widget.dart';
// import 'package:datarun/data_run/screens/login_screen/login_page.dart';
// import 'package:datarun/data_run/screens/login_screen/reactive_form_state/login_reactive_form_model.dart';
// import 'package:datarun/data_run/screens/sync_screen/sync_screen.widget.dart';
// import 'package:datarun/modular/account/auth_guard.dart';
// import 'package:datarun/modular/sync_guard.dart';
// import 'package:datarun/services/d_authentication_service.dart';
// import 'package:datarun/ui/views/startup/startup_view.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:stacked_services/stacked_services.dart';
//
// class AppModule extends Module {
//   /// Dependencies binding:
//   /// ```dart
//   ///  i.add(XPTOEmail.new);
//   ///  i.add<EmailService>(XPTOEmailService.new);
//   ///  i.addSingleton(Client.new);
//   ///
//   ///  // Register with Key
//   ///  i.addSingleton(Client.new, key: 'OtherClient');
//   ///  ```
//   @override
//   void binds(i) {
//     i.addInstance(UserSessionManager(i.get()));
//     i.addInstance(DAuthenticationService(i.get()));
//     i.addInstance(AuthService(i.get(), i.get()));
//     i.addInstance(LoginReactiveFormModel(i.get(), i.get()));
//     i.addSingleton(NavigationService.new);
//     i.addSingleton(DialogService.new);
//     i.addSingleton(SnackbarService.new);
//     i.addSingleton(BottomSheetService.new);
//   }
//
//   /// **Types of Routing:**
//   ///
//   ///
//   /// - r.child => ChildRoute.
//   /// - r.module => ModuleRoute.
//   /// - r.redirect => RedirectRoute.
//   /// - r.wildcard => WildcardRoute.
//   ///
//   /// **Passing parameters:**
//   /// - r.child('/second/:name', child: (_) => SecondPage(name: r.args.params['name'])),
//   ///
//   /// **Query:**
//   ///
//   /// Like the web environment, we can send parameters using query:
//   /// - ChildRoute('/second', child: (_) => SecondPage(name: r.args.queryParams['name'])),
//   /// ```dart
//   /// Modular.to.navigate('/second?name=jacob');  // args.queryParams['name'] -> 'jacob'
//   /// Modular.to.navigate('/second?name=sara');   // args.queryParams['name'] -> 'sara'
//   /// Modular.to.navigate('/second?name=rie');    // args.queryParams['name'] -> 'rie'
//   /// ```
//   /// **Direct arguments:**
//   ///
//   /// Sometimes, we need to send a complex object and not
//   /// only a String as parameter. So we send the whole object directly in
//   /// the navigation:
//   /// ```dart
//   /// class Person {}
//   ///
//   /// // Use Modular.args.data to receive directly argument.
//   /// ChildRoute('/second', child: (_) => SecondPage(person: r.args.data)),
//   ///
//   /// // Send object
//   /// Modular.to.navigate('/second', arguments: Person());
//   /// ```
//   /// **RedirectRoute:**
//   /// ```dart
//   /// @override
//   /// List<ModularRoute> get routes => [
//   ///   ChildRoute('/', child: (_) => HomePage()),
//   ///   RedirectRoute('/redirect', to: '/'),
//   /// ];
//   /// ```
//   @override
//   void routes(r) {
//     r.child(DRoutes.homeScreen,
//         child: (context) => const HomeScreen(),
//         guards: [AuthGuard(), SyncGuard()]);
//     r.child(DRoutes.startupView, child: (context) => const StartupView());
//     r.child(DRoutes.syncScreen, child: (context) => const SyncScreen());
//     r.child(DRoutes.loginPage, child: (context) => const LoginPage());
//     r.child(DRoutes.settingsPage, child: (context) => const SettingsPage());
//   }
// }
//
// class DRoutes {
//   // static const homeScreen = '/home-screen';
//   static const homeScreen = '/';
//
//   static const syncScreen = '/sync-screen';
//
//   static const loginPage = '/login-page';
//
//   static const startupView = '/startup-view';
//
//   static const settingsPage = '/settings-page';
//
//   static const all = <String>{
//     homeScreen,
//     syncScreen,
//     loginPage,
//     startupView,
//     settingsPage,
//   };
// }
