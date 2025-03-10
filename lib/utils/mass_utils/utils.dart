import 'package:intl/intl.dart';

export './colors.dart';
export './formatting.dart';
export './platforms.dart';
export './strings.dart';

String L(String stringResource) {
  return Intl.message(
    stringResource,
    name: stringResource,
    desc: '',
    args: <Object>[],
  );
}
