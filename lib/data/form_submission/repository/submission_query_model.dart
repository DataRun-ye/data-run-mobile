import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarunmobile/commons/query_model.dart';

class SubmissionQueryModel extends QueryModel {
  SubmissionQueryModel({
    this.deleted,
    this.synced,
    this.syncFailed,
    this.isFinal,
    this.lastSyncDate,
    this.version,
    this.form,
    required this.formVersion,
    this.assignment,
    this.status,
    required this.team,
    this.orgUnit,
  });

  final bool? deleted;
  final bool? synced;
  final bool? syncFailed;
  final bool? isFinal;
  final String? lastSyncDate;
  final int? version;
  final String? form;
  final String formVersion;
  final String? assignment;
  final AssignmentStatus? status;
  final String team;
  final String? orgUnit;

  @override
  List<Object?> get props =>
      super.props +
      [
        deleted,
        synced,
        syncFailed,
        isFinal,
        lastSyncDate,
        version,
        form,
        formVersion,
        assignment,
        status,
        team,
        orgUnit
      ];

  Map<String, dynamic> toMap() {
    final map = {
      'deleted': this.deleted,
      'synced': this.synced,
      'syncFailed': this.syncFailed,
      'isFinal': this.isFinal,
      'lastSyncDate': this.lastSyncDate,
      'version': this.version,
      'form': this.form,
      'formVersion': this.formVersion,
      'assignment': this.assignment,
      'status': this.status,
      'team': this.team,
      'orgUnit': this.orgUnit,
    };
    return map..removeWhere((_, v) => v == null);
  }
}
