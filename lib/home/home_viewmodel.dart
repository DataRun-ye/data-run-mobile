import 'package:d_sdk/database/database.dart';
import 'package:datarunmobile/core/network/connectivy_service.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends BaseViewModel {
  final _cancelToken = appLocator<CancelToken>();

  bool _isOnline = false;

  bool get isOnline => _isOnline;

  User? get user => appLocator<User>();

  Future<void> checkOnline() async {
    _cancelToken.cancel();
    setBusyForObject(isOnline, true);
    _isOnline =
        await appLocator<NetworkUtil>().isOnline();
    setBusyForObject(isOnline, false);
  }

  void cancelToken() {
    _cancelToken.cancel();
  }

  @override
  void dispose() {
    super.dispose();
    _cancelToken.cancel();
  }
}
