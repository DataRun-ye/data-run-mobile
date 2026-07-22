import 'package:datarunmobile/core/exception/d_error.dart';
import 'package:datarunmobile/core/exception/d_error_code.dart';

class NoCachedAuthenticatedUser extends DError {
  NoCachedAuthenticatedUser({
    String? message,
    super.cause,
    super.errorCode = DRunErrorCode.noUserDetailsFetchedFromServer,
    super.stackTrace,
  }) : super(
            message: 'No cached user ${message != null ? ': $message' : ''}',
            errorComponent: DErrorComponent.SDK);
}
