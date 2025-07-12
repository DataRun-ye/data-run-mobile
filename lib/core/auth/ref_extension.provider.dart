import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/core/auth/auth_manager.dart';
import 'package:datarunmobile/core/user_session/locale_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ref_extension.provider.g.dart';

extension on Ref {
  // We can move the previous logic to a Ref extension.
  // This enables reusing the logic between providers
  NotifierT disposeAndListenChangeNotifier<NotifierT extends ChangeNotifier>(
    NotifierT notifier,
  ) {
    onDispose(notifier.dispose);
    notifier.addListener(notifyListeners);
    // We return the notifier to ease the usage a bit
    return notifier;
  }
}

@riverpod
Raw<AuthManager> authNotifier(Ref ref) {
  return ref.disposeAndListenChangeNotifier(appLocator<AuthManager>());
}

@riverpod
Raw<ChangeNotifier> localeNotifier(Ref ref) {
  return ref.disposeAndListenChangeNotifier(appLocator<LocaleService>());
}
