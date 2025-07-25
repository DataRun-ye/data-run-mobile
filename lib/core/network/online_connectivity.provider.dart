import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/network/network_util.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'online_connectivity.provider.g.dart';

@riverpod
class IsOnline extends _$IsOnline {
  @override
  Future<bool> build() {
    return appLocator<NetworkUtil>().isOnline();
  }

  void check() async {
    await future;
    state = AsyncData(await appLocator<NetworkUtil>().isOnline());
  }
}
