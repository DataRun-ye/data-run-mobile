import 'package:datarunmobile/app/di/injection.dart';

Future<void> closeFormScope(String submissionId) async {
  if (appLocator.hasScope(submissionId)) {
    await appLocator.popScopesTill(submissionId);
  }
}
