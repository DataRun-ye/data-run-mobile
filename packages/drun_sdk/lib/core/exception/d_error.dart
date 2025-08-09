import 'package:d_sdk/core/exception/exception.dart';
import 'package:d_sdk/core/util/date_helper.dart';

class DError implements DException {
  DError(
      {this.url,
      this.errorComponent,
      this.cause,
      this.errorCode,
      this.message,
      this.httpErrorCode,
      this.stackTrace,
      this.shouldShowMessage = true})
      : this.time = DateTime.now();

  final String? url;
  final DErrorComponent? errorComponent;
  final DRunErrorCode? errorCode;
  final String? message;
  final int? httpErrorCode;
  final Object? cause;
  final DateTime? time;
  final StackTrace? stackTrace;
  final bool shouldShowMessage;

  Map<String, dynamic> toMap() {
    return {
      'url': this.url,
      'errorComponent': this.errorComponent,
      'errorCode': this.errorCode,
      'message': this.message,
      'httpErrorCode': this.httpErrorCode,
      'cause': this.cause,
      'time': DateHelper.formatForUi(DateTime.now(), includeTime: true),
      'shouldShowMessage': this.shouldShowMessage,
    };
  }

  @override
  String toString() {
    return (StringBuffer('Error(')
          ..write('url: $url, ')
          ..write('errorCode: $errorCode, ')
          ..write('message: $message ')
          ..write(')'))
        .toString();
  }
}
