import 'package:datarunmobile/core/exception/http_errors.dart';

bool isCredentialRejection(Object error) =>
    error is NetworkHttpError &&
    (error.httpErrorCode == 401 || error.httpErrorCode == 403);
