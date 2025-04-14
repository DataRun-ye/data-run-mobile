import 'dart:convert';

import 'package:d_sdk/database/app_database.dart';
import 'package:d_sdk/database/shared/shared.dart';

class MetadataSubmissionUpdate {
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

  static List<MetadataSubmissionUpdate> fromJsonList(
    List<dynamic> list, {
    required String resourceId,
    required String metadataSubmission,
    required MetadataResourceType resourceType,
    required String submissionId,
  }) {
    return list
        .map((item) => MetadataSubmissionUpdate.fromJson({
              ...item,
              'resourceId': resourceId,
              'submissionId': resourceId,
              'resourceType': resourceType.name,
              'metadataSubmission': metadataSubmission,
              'formData': {
                '_id': item['_id'],
                'submissionId': item['submissionId'],
                'householdName': item['householdName'],
                'householdHeadSerialNumber': item['householdHeadSerialNumber'],
                'resourceType': resourceType.name,
                'resourceId': resourceId,
              },
            }))
        .toList();
  }

  ///this method will prevent the override of toString
  String resourceAsString() {
    return '#$householdHeadSerialNumber $householdName';
  }

  ///this method will prevent the override of toString
  bool userFilterBySerialName(String filter) {
    return resourceAsString().contains(filter);
  }

  ///custom comparing function to check if two users are equal
  bool isEqual(MetadataSubmissionUpdate model) {
    return householdHeadSerialNumber == model.householdHeadSerialNumber &&
        householdName == model.householdName &&
        resourceId == model.resourceId;
  }

  @override
  String toString() => householdName ?? '';
}

extension MetadataSubmissionHouseholds on MetadataSubmission {
  Map<String, dynamic> toContext() {
    return {
      'metadataSubmission': id,
      'createdDate': createdDate,
      'lastModifiedDate': lastModifiedDate,
      'metadataSchema': metadataSchema,
      'resourceType': resourceType.name,
      'resourceId': resourceId,
      'households': formData?['households'],
    };
  }
}
