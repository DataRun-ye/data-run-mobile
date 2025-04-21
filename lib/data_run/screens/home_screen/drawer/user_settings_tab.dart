// import 'package:d_sdk/auth/auth_manager.dart';
// import 'package:d_sdk/d_sdk.dart';
// import 'package:datarunmobile/data/preference2.provider.dart';
// import 'package:datarunmobile/di/injection.dart';
// import 'package:datarunmobile/generated/l10n.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
//
// class UserSettingsTab extends ConsumerWidget {
//   const UserSettingsTab({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authManager = appLocator<AuthManager>();
//     final currentAuthUser = DSdk.sessionManager;
//     final language = ref.watch(preferenceNotifierProvider(Preference.language));
//     return ListView(
//       padding: const EdgeInsets.all(16.0),
//       children: [
//         // Account Information Section
//         Text(
//           S.of(context).accountInformation,
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         const SizedBox(height: 10),
//         Card(
//           child: ListTile(
//             leading: Icon(MdiIcons.accountArrowLeft),
//             title: Text(S.of(context).loginUsername),
//             subtitle: Text(currentAuthUser.username),
//           ),
//         ),
//         Card(
//           child: ListTile(
//             leading: Icon(MdiIcons.faceMan),
//             title: Text(S.of(context).personInformation),
//             subtitle: Text(currentAuthUser.firstname),
//             trailing: IconButton(
//               icon: const Icon(Icons.edit),
//               onPressed: () {},
//             ),
//           ),
//         ),
//         Card(
//           child: ListTile(
//             leading: Icon(MdiIcons.phoneSettings),
//             title: Text(S.of(context).mobile),
//             subtitle: Text(currentAuthUser.mobile),
//             trailing: IconButton(
//               icon: const Icon(Icons.edit),
//               onPressed: () {},
//             ),
//           ),
//         ),
//         Card(
//           child: ListTile(
//             leading: const Icon(
//               Icons.lock_outline,
//             ),
//             title: Text(S.of(context).changePassword),
//             trailing: IconButton(
//               icon: const Icon(Icons.edit),
//               onPressed: () {},
//             ),
//           ),
//         ),
//
//         // Preferences Section
//         const SizedBox(height: 24),
//         Text(
//           S.of(context).preferences,
//           style: Theme.of(context).textTheme.titleLarge,
//         ),
//         const SizedBox(height: 10),
//         Card(
//           child: ListTile(
//             leading: const Icon(
//               Icons.language,
//             ),
//             title: Text(S.of(context).language),
//             subtitle: Text(language),
//             trailing: DropdownButton<String>(
//               value: language,
//               onChanged: (String? newValue) {
//                 if (newValue != null) {
//                   {
//                     ref
//                         .read(preferenceNotifierProvider(Preference.language)
//                             .notifier)
//                         .update(newValue);
//                   }
//                 }
//               },
//               items: <String>['ar', 'en']
//                   .map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(value),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//
//         // Logout Button
//         const SizedBox(height: 20),
//         Card(
//           color: Theme.of(context).colorScheme.errorContainer,
//           child: ListTile(
//             leading: Icon(MdiIcons.logout,
//                 color: Theme.of(context).colorScheme.onErrorContainer),
//             title: Text(
//               S.of(context).logout,
//               style: TextStyle(
//                   color: Theme.of(context).colorScheme.onErrorContainer),
//             ),
//             subtitle: Text(
//               S.of(context).logoutNote,
//               style: TextStyle(
//                   color: Theme.of(context).colorScheme.onErrorContainer),
//               overflow: TextOverflow.ellipsis,
//             ),
//             onTap: () async {
//               await authManager.logout();
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
