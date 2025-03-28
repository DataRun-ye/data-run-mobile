import 'package:datarunmobile/data/form/form_instance.provider.dart';
import 'package:datarunmobile/data_run/screens/form/element/form_metadata.dart';
import 'package:datarunmobile/data_run/screens/form_ui_elements/bottom_sheet/form_completion_dialog_config/configure_form_completion_dialog.dart';
import 'package:datarunmobile/data_run/screens/form_ui_elements/bottom_sheet/form_completion_dialog_config/form_completion_dialog.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'completion_dialog_config.provider.g.dart';

@riverpod
FormCompletionDialog formCompletionBottomSheet(FormCompletionBottomSheetRef ref,
    {required FormMetadata formMetadata}) {
  final formInstance =
      ref.watch(formInstanceProvider(formMetadata: formMetadata)).requireValue;

  final configurator = const ConfigureFormCompletionDialog();

  return configurator(formInstance.formSection);
}
