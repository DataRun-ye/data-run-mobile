import 'package:d2_remote/d2_remote.dart';
import 'package:d2_remote/modules/auth/user/entities/d_user.entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.provider.g.dart';

@riverpod
Future<User?> userInfo(UserInfoRef ref) {
  return D2Remote.userModule.user.getOne();
}
