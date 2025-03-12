import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_about_info.provider.g.dart';

@riverpod
Future<AppAbout> appAboutInfo(AppAboutInfoRef ref) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return AppAbout(
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      version: packageInfo.version,
      buildNumber: packageInfo.buildNumber);
}

class AppAbout {
  AppAbout(
      {required this.appName,
      required this.packageName,
      required this.version,
      required this.buildNumber});

  final String appName; // App name
  final String packageName; // Package name (e.g., org.datarun.app)
  final String version; // Version name (e.g., 1.0.0)
  final String buildNumber; // Build number (e.g., 1)
}
