// import 'package:datarunmobile/app/app_environment.dart';
// import 'package:datarunmobile/ui/common/ui_helpers.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';
//
// import 'login_viewmodel.dart';
//
// class LoginView extends StackedView<LoginViewModel> {
//   const LoginView({Key? key}) : super(key: key);
//
//   @override
//   Widget builder(
//     BuildContext context,
//     LoginViewModel viewModel,
//     Widget? child,
//   ) {
//     final _usernameController = TextEditingController();
//     final _passwordController = TextEditingController();
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         padding: const EdgeInsets.only(left: 25.0, right: 25.0),
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 32),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 verticalSpaceLarge,
//                 // Instagram logo
//                 Image.asset('assets/post/login_logo.jpg', height: 80),
//                 verticalSpaceLarge,
//                 // Username text field
//                 TextField(
//                   controller: _usernameController,
//                   decoration: InputDecoration(
//                     hintText: 'Username',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     filled: true,
//                     contentPadding: const EdgeInsets.all(16),
//                   ),
//                 ),
//
//                 verticalSpaceSmall,
//                 // Password text field
//                 TextField(
//                   controller: _passwordController,
//                   obscureText: true,
//                   decoration: InputDecoration(
//                     hintText: 'Password',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     filled: true,
//                     contentPadding: const EdgeInsets.all(16),
//                   ),
//                 ),
//                 verticalSpaceSmall,
//                 // Login button
//                 ElevatedButton(
//                   onPressed: () {
//                     viewModel.userLogin(
//                         _usernameController.text, _passwordController.text);
//                   },
//                   child: const Text('Log In'),
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                 ),
//
//                 verticalSpaceLarge,
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   LoginViewModel viewModelBuilder(
//     BuildContext context,
//   ) =>
//       LoginViewModel();
// }
