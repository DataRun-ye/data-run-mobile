import 'package:d_sdk/database/shared/value_type.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:datarunmobile/features/form/application/map_value_to_display.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'value_display.provider.g.dart';

@riverpod
FutureOr<String?> valueDisplay(Ref ref,
    {required ValueType valueType, dynamic value}) {
  return appLocator<MapValueToDisplay>().map(valueType, value);
}
