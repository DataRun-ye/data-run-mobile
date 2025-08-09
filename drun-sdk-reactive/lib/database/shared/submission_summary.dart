import 'package:d_sdk/core/data_instance/form_data_util.dart';
import 'package:d_sdk/d_sdk.dart';
import 'package:d_sdk/database/shared/shared.dart';
import 'package:d_sdk/core/data_instance/field_value.dart';
import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class SubmissionSummary with EquatableMixin {
  SubmissionSummary(
      {required this.id,
      this.assignment,
      required this.orgUnit,
      required this.form,
      required this.formVersionId,
      required this.versionNumber,
      required this.syncStatus,
      this.progress,
      this.submittedAt,
      this.createdDate,
      this.lastModifiedDate,
      this.isToUpdate = false,
      this.lastSyncMessage,
      required this.deleted,
      IMap<String, dynamic>? dataMap,
      IMap<String, FieldValue>? formData})
      : this.formData = formData ?? const IMapConst({}),
        this.dataMap = dataMap ?? const IMapConst({});

  final String id;
  final String? assignment;
  final IdentifiableModel form;
  final IdentifiableModel orgUnit;
  final String formVersionId;
  final int versionNumber;
  final AssignmentStatus? progress;
  final InstanceSyncStatus syncStatus;
  final DateTime? submittedAt;
  final IMap<String, FieldValue> formData;
  final IMap<String, dynamic> dataMap;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;
  final bool isToUpdate;
  final bool deleted;
  final String? lastSyncMessage;

  SubmissionSummary copyWith({
    String? id,
    IdentifiableModel? form,
    IdentifiableModel? orgUnit,
    String? formVersionId,
    int? versionNumber,
    AssignmentStatus? progress,
    InstanceSyncStatus? syncStatus,
    DateTime? submittedAt,
    IMap<String, FieldValue>? formDate,
    IMap<String, dynamic>? dataMap,
    DateTime? createdDate,
    DateTime? lastModifiedDate,
    bool? isToUpdate,
    String? assignment,
    String? lastSyncMessage,
    bool? deleted,
  }) {
    return SubmissionSummary(
      id: id ?? this.id,
      form: form ?? this.form,
      orgUnit: orgUnit ?? this.orgUnit,
      formVersionId: formVersionId ?? this.formVersionId,
      versionNumber: versionNumber ?? this.versionNumber,
      progress: progress ?? this.progress,
      syncStatus: syncStatus ?? this.syncStatus,
      submittedAt: submittedAt ?? this.submittedAt,
      formData: formDate ?? this.formData,
      dataMap: dataMap ?? this.dataMap,
      createdDate: createdDate ?? this.createdDate,
      lastModifiedDate: lastModifiedDate ?? this.lastModifiedDate,
      isToUpdate: isToUpdate ?? this.isToUpdate,
      assignment: assignment ?? this.assignment,
      lastSyncMessage: lastSyncMessage ?? this.lastSyncMessage,
      deleted: deleted ?? this.deleted,
    );
  }

  @override
  List<Object?> get props => [
        id,
        form,
        orgUnit,
        formVersionId,
        versionNumber,
        progress,
        submittedAt,
        syncStatus,
        formData,
        dataMap,
        createdDate,
        lastModifiedDate,
        isToUpdate,
        assignment,
        lastSyncMessage,
        deleted,
      ];

  factory SubmissionSummary.fromDrift(TypedResult row) {
    final dao = DSdk.db.dataInstancesDao;
    final submission = row.readTable(dao.dataInstances);
    final orgUnit = row.readTable(dao.orgUnits);
    final form = row.readTable(dao.formTemplates);
    final formVersion = row.readTable(dao.formTemplateVersions);

    return SubmissionSummary(
        id: submission.id,
        assignment: submission.assignment,
        form: IdentifiableModel(
          id: form.id,
          name: form.name,
          label: form.label,
        ),
        versionNumber: form.versionNumber,
        orgUnit: IdentifiableModel(
          id: orgUnit.id,
          code: orgUnit.code,
          name: orgUnit.name,
          label: orgUnit.label,
        ),
        submittedAt: submission.createdDate,
        syncStatus: submission.syncState,
        formVersionId: formVersion.id,
        createdDate: submission.createdDate,
        lastModifiedDate: submission.lastModifiedDate,
        dataMap: (submission.formData ?? {}).lock,
        deleted: submission.deleted,
        lastSyncMessage: submission.lastSyncMessage,
        formData: FormDataUtil.extractTemplateValue(
                submission.formData ?? {}, formVersion.fields)
            .lock);
  }
}
