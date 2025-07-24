// a StreamProvider.family keyed by elementPath:

import 'package:datarunmobile/features/form_submission/application/element/form_element_state.dart';
import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'element_properties.provider.g.dart';

@riverpod
Stream<FormElementState<dynamic>> elementPropertiesStream(Ref ref,
    {required String path, required FormMetadata formMetadata}) {
  return ref
      .watch(formInstanceProvider(formMetadata: formMetadata))
      .requireValue
      .forElementMap[path]!
      .propertiesChanged;
}
