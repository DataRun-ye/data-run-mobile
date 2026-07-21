import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/network/reactive_connectivity_service.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'if_online_abstract.provider.g.dart';

/// a StreamProvider that emits true/false as the internet comes and goes
@riverpod
Stream<bool> isOnline(Ref ref) {
  final conn = appLocator<ConnectivityService>();
  return conn.onStatusChange
      .map((status) => status == InternetStatus.connected);
}
