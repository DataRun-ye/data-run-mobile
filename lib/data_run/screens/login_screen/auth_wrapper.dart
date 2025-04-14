import 'package:datarunmobile/data_run/screens/home_screen/home_screen.widget.dart';
import 'package:datarunmobile/data_run/screens/login_screen/login_page.dart';
import 'package:datarunmobile/ui/views/sync_with_server/sync_with_server_view.dart';
import 'package:flutter/material.dart';

class AuthSyncWrapper extends StatelessWidget {
  const AuthSyncWrapper({
    Key? key,
    required this.isAuthenticated,
    required this.needsSync,
  }) : super(key: key);
  final bool isAuthenticated;
  final bool needsSync;

  @override
  Widget build(BuildContext context) {
    return isAuthenticated
        ? (needsSync ? const SyncProgressView() : const HomeScreen())
        : const LoginPage();
  }
}
