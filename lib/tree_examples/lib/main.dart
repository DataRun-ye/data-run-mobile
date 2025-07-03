import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

main() {
  ///      Pattern                           Result
  ///      ----------------                  -------
  initializeDateFormatting('ar').then((_) {
   final now = DateTime.now();
   final locale = 'ar_jr';
   final localeEn = 'en';
   final parsed = DateTime.parse('2025-07-02');
   print('parsed:                     $parsed');
   print('DateFormat.y().add_Md():    ${DateFormat.y('ar').add_Md().format(now)}');
   print('parsed.yMMd():  ${DateFormat('yMMMd', locale).format(parsed)}');
   print('DateFormat.d().add_yM():    ${DateFormat.d().add_yM().format(now)}');
  });
 final yMd = DateFormat.yMd(); //-> 7/10/1996
 final yMMMMd = DateFormat.yMMMMd();
 final now = DateTime.now();
 // print('DateFormat.y().add_Md():    ${DateFormat.y('ar').add_Md().format(now)}');
 // print('DateFormat.yMd().add_jm():  ${DateFormat.yMd().add_jm().format(now)}');
 // print('DateFormat.d().add_yM():    ${DateFormat.d().add_yM().format(now)}');
 // print('DateFormat.y().add_Md():    ${DateFormat.y().add_Md().format(now)}');
 // print('DateFormat.y().add_Md():    ${DateFormat.y().add_Md().format(now)}');
 // print('DateFormat.y().add_Md():    ${DateFormat.y().add_Md().format(now)}');
 // print('DateFormat.y().add_Md():    ${DateFormat.y().add_Md().format(now)}');

  DateFormat('yMd'); //-> 7/10/1996
  DateFormat.y().add_Md(); //-> July 10, 1996
  DateFormat.jm(); //-> 5:08 PM
  DateFormat.yMd().add_jm(); //-> 7/10/1996 5:08 PM
  DateFormat.Hm(); //-> 17:08 // force 24 hour time
}

// import 'package:datarunmobile/tree_examples/lib/material/bottom_sheets.dart';
// import 'package:datarunmobile/tree_examples/lib/material/modals.dart';
// import 'package:datarunmobile/tree_examples/lib/user_model.dart';
// import 'package:dio/dio.dart';
// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
//
// import 'material/dialogs.dart';
// import 'material/menus.dart';
//
// void main() => runApp(MyApp());
//
// Future<List<UserModel>> getData(filter) async {
//   var response = await Dio().get(
//     'https://63c1210999c0a15d28e1ec1d.mockapi.io/users',
//     queryParameters: {'filter': filter},
//   );
//
//   final data = response.data;
//   if (data != null) {
//     return UserModel.fromJsonList(data);
//   }
//
//   return [];
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'dropdownSearch Demo',
//       //enable this line if you want test Dark Mode
//       theme: ThemeData.dark(),
//       home: MyHomePage(),
//     );
//   }
// }
//
// enum UiMode { adaptive, material, cupertino }
//
// class MyHomePage extends StatelessWidget {
//   final dropDownKey = GlobalKey<DropdownSearchState<PopupMode>>();
//   final dropDownUiModeKey = GlobalKey<DropdownSearchState<UiMode>>();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('examples mode')),
//       body: ListView(
//         padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: DropdownSearch<PopupMode>(
//                   key: dropDownKey,
//                   selectedItem: PopupMode.menu,
//                   itemAsString: (item) => item.name,
//                   compareFn: (i1, i2) => i1 == i2,
//                   items: (filter, infiniteScrollProps) => PopupMode.values,
//                   decoratorProps: DropDownDecoratorProps(
//                     decoration: InputDecoration(
//                       labelText: 'Examples for: ',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   popupProps: PopupProps.menu(
//                       fit: FlexFit.loose, constraints: BoxConstraints()),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.only(right: 16)),
//               Expanded(
//                 child: DropdownSearch<UiMode>(
//                   key: dropDownUiModeKey,
//                   selectedItem: UiMode.material,
//                   itemAsString: (item) => item.name,
//                   compareFn: (i1, i2) => i1 == i2,
//                   items: (filter, infiniteScrollProps) => UiMode.values,
//                   decoratorProps: DropDownDecoratorProps(
//                     decoration: InputDecoration(
//                       labelText: 'ui mode: ',
//                       border: OutlineInputBorder(),
//                     ),
//                   ),
//                   popupProps: PopupProps.menu(
//                       fit: FlexFit.loose, constraints: BoxConstraints()),
//                 ),
//               ),
//               Padding(padding: EdgeInsets.only(right: 16)),
//               FilledButton(
//                 onPressed: () {
//                   final uiMode =
//                       dropDownUiModeKey.currentState?.getSelectedItem;
//                   switch (dropDownKey.currentState?.getSelectedItem) {
//                     case PopupMode.menu:
//                       if (uiMode == UiMode.adaptive) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MaterialMenuExamplesPage()));
//                       } else if (uiMode == UiMode.cupertino) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MaterialMenuExamplesPage()));
//                       } else {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MaterialMenuExamplesPage()));
//                       }
//                       break;
//                     case PopupMode.modalBottomSheet:
//                       if (uiMode == UiMode.adaptive) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MaterialMenuExamplesPage()));
//                       } else if (uiMode == UiMode.cupertino) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MaterialMenuExamplesPage()));
//                       } else {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MaterialModalsExamplesPage()));
//                       }
//                       break;
//                     case PopupMode.bottomSheet:
//                       if (uiMode == UiMode.adaptive) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MaterialMenuExamplesPage()));
//                       } else if (uiMode == UiMode.cupertino) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MaterialMenuExamplesPage()));
//                       } else {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MaterialBottomSheetExamplesPage()));
//                       }
//                       break;
//                     case PopupMode.dialog:
//                       if (uiMode == UiMode.adaptive) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MaterialMenuExamplesPage()));
//                       } else if (uiMode == UiMode.cupertino) {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MaterialMenuExamplesPage()));
//                       } else {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) =>
//                                     MaterialDialogExamplesPage()));
//                       }
//                       break;
//                     case null:
//                       throw UnimplementedError();
//                   }
//                 },
//                 child: Text('Go'),
//               )
//             ],
//           ),
//           Padding(padding: EdgeInsets.all(8)),
//           RichText(
//             text: TextSpan(
//               style: const TextStyle(fontSize: 14.0, color: Colors.black),
//               children: [
//                 TextSpan(text: 'we used '),
//                 TextSpan(
//                     text: 'fit: FlexFit.loose',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 TextSpan(text: ' and '),
//                 TextSpan(
//                     text: 'constraints: BoxConstraints() ',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 TextSpan(
//                     text:
//                         'to fit the height of menu automatically to the length of items'),
//               ],
//             ),
//           ),
//           Padding(padding: EdgeInsets.only(top: 20)),
//           Text(
//             'DropdownSearch Anatomy',
//             style: TextStyle(
//                 fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
//             textAlign: TextAlign.center,
//           ),
//           Image.asset('assets/images/anatomy.png',
//               alignment: Alignment.topCenter, height: 1024)
//         ],
//       ),
//     );
//   }
// }
