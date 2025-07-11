import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/app_database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.provider.g.dart';

@riverpod
Future<User?> userInfo(Ref ref) {
  return DSdk.db.managers.users.getSingleOrNull();
}
