// import 'package:flutter/material.dart';
//
// /// Stacked comes with different ViewModel types. In Stacked, you have
// /// BaseViewModels, ReactiveViewModels, FutureViewModels, StreamViewModels,
// /// and MultipleFutureViewModels. Use each one based on your current need.
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   await Hive.initFlutter();
//   Hive.registerAdapter(TodoAdapter());
//   await Hive.openBox('todos');
//
//   setupLocator();
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: const TodosScreenView(),
//       theme: ThemeData.dark(),
//       title: 'Flutter Stacked Todos',
//     );
//   }
// }
