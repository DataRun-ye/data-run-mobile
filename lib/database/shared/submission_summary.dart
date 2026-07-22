import 'package:datarunmobile/core/data_instance/field_value.dart';
import 'package:datarunmobile/database/shared/d_identifiable_model.dart';
import 'package:datarunmobile/database/shared/submission_status.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class SubmissionSummary with EquatableMixin {
  SubmissionSummary(
      {required this.id,
      this.assignment,
      required this.form,
      required this.formVersionId,
      required this.syncStatus,
      this.createdDate,
      this.lastModifiedDate,
      this.lastSyncMessage,
      required this.deleted,
      IMap<String, FieldValue>? formData})
      : this.formData = formData ?? const IMapConst({});

  final String id;
  final String? assignment;
  final IdentifiableModel form;
  final String formVersionId;
  final InstanceSyncStatus syncStatus;
  final IMap<String, FieldValue> formData;
  final DateTime? createdDate;
  final DateTime? lastModifiedDate;
  final bool deleted;
  final String? lastSyncMessage;

  @override
  List<Object?> get props => [
        id,
        form,
        formVersionId,
        syncStatus,
        formData,
        createdDate,
        lastModifiedDate,
        assignment,
        lastSyncMessage,
        deleted,
      ];
}
