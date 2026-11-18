import 'package:datarunmobile/app/di/injection.dart';
import 'package:get_it/get_it.dart';
import 'package:synchronized/synchronized.dart';

// Each open form keeps its objects (template, form instance, field registry)
// in a service-locator scope named by its submission id.
//
// A form screen closes its scope when it is disposed, at the end of its close
// animation; by then the user may already have opened the next form, whose
// scope sits above. Closing therefore drops only that one scope, never the
// scopes above it (which left the next form without its objects), and waits
// for a scope still being opened, because GetIt refuses to drop scopes during
// another scope's init. Reopening the same submission replaces its scope; the
// token stops the old screen from closing the new one.

final _scopeLock = Lock();
final _openScopes = <String, Object>{};

/// Opens the scope for [submissionId], replacing one already open for it.
Future<void> openFormScope(
  String submissionId,
  Future<void> Function(GetIt getIt) init,
) {
  return _scopeLock.synchronized(() async {
    await _drop(submissionId);
    await appLocator.pushNewScopeAsync(scopeName: submissionId, init: init);
    _openScopes[submissionId] = Object();
  });
}

/// Identifies the scope now open for [submissionId]. A screen takes it when
/// it starts and gives it to [closeFormScope], so it closes only its own.
Object? formScopeToken(String submissionId) => _openScopes[submissionId];

/// Drops the scope of [submissionId] and nothing above it. With a [token],
/// only while that scope is still the one the token was taken from.
Future<void> closeFormScope(String submissionId, {Object? token}) {
  return _scopeLock.synchronized(() async {
    if (token != null && !identical(_openScopes[submissionId], token)) return;
    await _drop(submissionId);
  });
}

Future<void> _drop(String submissionId) async {
  _openScopes.remove(submissionId);
  if (appLocator.hasScope(submissionId)) {
    await appLocator.dropScope(submissionId);
  }
}
