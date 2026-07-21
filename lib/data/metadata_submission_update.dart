import 'dart:convert';

import 'package:d_sdk/database/shared/metadata_resource_type.dart';

class MetadataSubmissionUpdate {
  // final DateTime createdAt;
  // final String avatar;

  MetadataSubmissionUpdate({
    required this.submissionId,
    required this.metadataSubmission,
    required this.resourceId,
    required this.resourceType,
    // required this.parentId,
    required this.id,
    required this.updated,
    required this.created,
    Map<String, dynamic> formData = const {},
    String? createdDate,
    String? lastModifiedDate,
  }) {
    this.formData.addAll(formData);
  }

  factory MetadataSubmissionUpdate.fromJson(Map<String, dynamic> json) {
    final resourceType = MetadataResourceType.getType(json['resourceType']);

    Map<String, dynamic> parseFormData(dynamic data) {
      if (data == null || (data is String && data.isEmpty)) {
        return {};
      }
      return Map<String, dynamic>.from(
          data is String ? jsonDecode(data) : data);
    }

    final formData = parseFormData(json['formData']);

    return MetadataSubmissionUpdate(
      metadataSubmission: json['metadataSubmission'],
      resourceId: json['resourceId'],
      submissionId: json['submissionId'],
      resourceType: resourceType,
      // parentId: json['parentId'],
      updated: json['updated'] ?? false,
      created: json['created'] ?? false,
      id: json['id'],
      formData: formData,
    );
  }
  final String id;
  final String submissionId;
  final String? metadataSubmission;
  final String? resourceId;
  final MetadataResourceType? resourceType;
  final bool? updated;
  final bool? created;
  final Map<String, dynamic> formData = {};

  int? get householdHeadSerialNumber =>
      formData['householdHeadSerialNumber'] as int?;

  int? get updatedHouseholdHeadSerialNumber =>
      formData['updatedHouseholdHeadSerialNumber'] as int?;

  String? get householdName => formData['householdName'] as String?;

  @override
  String toString() => householdName ?? '';
}
//
// extension MetadataSubmissionHouseholds on MetadataSubmission {
//   Map<String, dynamic> toContext() {
//     return {
//       'metadataSubmission': id,
//       'createdDate': createdDate,
//       'lastModifiedDate': lastModifiedDate,
//       'metadataSchema': metadataSchema,
//       'resourceType': resourceType.name,
//       'resourceId': resourceId,
//       'households': formData?['households'],
//     };
//   }
// }
