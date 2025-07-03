// import 'package:datarunmobile/app_routes/app_router_new.dart';
// import 'package:flutter/material.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
//
// class SplashScreen extends StatelessWidget {
//   SplashScreen({Key? key}) : super(key: key);
//   final _appRouter = AppRouter();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'My Splash App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: AnimatedSplashScreen.withScreenRouteFunction(
//         animationDuration: const Duration(seconds: 2),
//         splashTransition: SplashTransition.slideTransition,
//         splash: Icons.code,
//         nextScreen: MaterialApp.router(
//           routeInformationParser: _appRouter.defaultRouteParser(),
//           routerDelegate: _appRouter.delegate(),
//         ), screenRouteFunction: () {  },
//       ),
//     );
//   }
// }