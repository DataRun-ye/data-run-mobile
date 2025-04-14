import 'package:d_sdk/d_sdk.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'online_connectivity.provider.g.dart';

@riverpod
class IsOnline extends _$IsOnline {
  @override
  Future<bool> build() {
    return DSdk.connectivity.checkInternetConnection();
  }

  void check() async {
    await future;
    state = AsyncData(
        await DSdk.connectivity.checkInternetConnection());
  }
}
