import 'package:d_sdk/database/shared/d_identifiable_model.dart';
import 'package:d_sdk/database/shared/submission_sync_status_model.dart';

class FormListItemModel extends IdentifiableModel {
  FormListItemModel({
    required super.id,
    required super.name,
    super.description,
    super.label,
    super.properties,
    super.code,
    required this.versionNumber,
    required this.versionUid,
    this.syncStatuses = const [],
  });

  final int versionNumber;
  final String versionUid;
  final List<SubmissionSyncStatusModel> syncStatuses;

  @override
  List<Object?> get props => super.props + [versionNumber];
}
