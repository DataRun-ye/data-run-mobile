import 'package:d2_remote/modules/datarun_shared/queries/syncable.query.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mass_pro/commons/constants.dart';
import 'package:mass_pro/data_run/form/form.dart';
import 'package:mass_pro/data_run/screens/shared_widgets/bottom_sheet/q_bottom_sheet_dialog_ui_model.dart';
import 'package:mass_pro/main/usescases/bundle/bundle.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'form_screen_repository.g.dart';

@riverpod
FormScreenRepository formScreenRepository(FormScreenRepositoryRef ref) {
  final Bundle eventBundle = Get.arguments as Bundle;
  final String syncableUid = eventBundle.getString(SYNCABLE_UID)!;
  final String formCode = eventBundle.getString(FORM_CODE)!;
  final SyncableQuery d2SyncableQuery =
      ref.watch(databaseSyncableQueryProvider(formCode)).provideQuery();

  return FormScreenRepository(
      ref: ref, entityUid: syncableUid, d2SyncableQuery: d2SyncableQuery);
}

class FormScreenRepository {
  FormScreenRepository(
      {required this.ref,
      required String entityUid,
      required SyncableQuery d2SyncableQuery})
      : _entityUid = entityUid,
        _d2SyncableQuery = d2SyncableQuery;

  final String _entityUid;
  final SyncableQuery _d2SyncableQuery;
  final FormScreenRepositoryRef ref;

  Future<bool> canEditForm() async {
    return _d2SyncableQuery.byId(_entityUid).canEdit();
  }

  Future<QBottomSheetDialogUiModel> getBottomSheetModel() async {
    return QBottomSheetDialogUiModel(
      title: 'Final Data',
      subtitle: 'Make the form Final before exiting.',
      iconResource: Icons.info,
      mainButton: QDialogButtonStyle.completeButton(),
      secondaryButton:
          QDialogButtonStyle.neutralButton(textResource: 'Not Now'),
    );
  }
}
