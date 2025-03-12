import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'password_visibility.provider.g.dart';

@riverpod
class PasswordVisibility extends _$PasswordVisibility {
  @override
  bool build() {
    return true;
  }

  void toggle() {
    state = !state;
  }
}
