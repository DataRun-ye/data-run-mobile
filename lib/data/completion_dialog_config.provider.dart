import 'package:datarunmobile/features/form_submission/application/element/form_metadata.dart';
import 'package:datarunmobile/features/form_submission/application/form_instance.provider.dart';
import 'package:datarunmobile/features/form_submission/application/configure_form_completion_dialog.dart';
import 'package:datarunmobile/features/form_submission/presentation/widgets/form_completion_dialog.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'completion_dialog_config.provider.g.dart';

@riverpod
FormCompletionDialog formCompletionBottomSheet(Ref ref,
    {required FormMetadata formMetadata}) {
  final formInstance =
      ref.watch(formInstanceProvider(formMetadata: formMetadata)).requireValue;

  final configurator = const ConfigureFormCompletionDialog();

  return configurator(formInstance.formSection);
}
