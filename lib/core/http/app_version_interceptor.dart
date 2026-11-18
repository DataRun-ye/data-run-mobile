import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Sends the installed app version, for example `6.1.0+55`, with every
/// request as [header], so the server can record which build each user runs.
///
/// A request is never held back for this: when the version cannot be read,
/// it goes out without the header.
class AppVersionInterceptor extends Interceptor {
  AppVersionInterceptor({Future<String> Function()? readVersion})
      : _readVersion = readVersion ?? _installedVersion;

  static const header = 'X-App-Version';

  final Future<String> Function() _readVersion;
  Future<String?>? _version;

  static Future<String> _installedVersion() async {
    final info = await PackageInfo.fromPlatform();
    return info.buildNumber.isEmpty
        ? info.version
        : '${info.version}+${info.buildNumber}';
  }

  Future<String?> _resolveVersion() async {
    try {
      final version = await _readVersion();
      return version.isEmpty ? null : version;
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final version = await (_version ??= _resolveVersion());
    if (version != null) {
      options.headers[header] = version;
    }
    handler.next(options);
  }
}
