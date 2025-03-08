// import 'package:datarun/modular/app.module.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
//
// void main() {
//   return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
// }
//
// class AppWidget extends StatelessWidget {
//   const AppWidget();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'My Smart App',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       routerConfig: Modular.routerConfig,
//     ); //added by extension
//   }
// }
//
// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Home Page')),
//       body: const Center(
//         child: Text('This is initial page'),
//       ),
//     );
//   }
// }
