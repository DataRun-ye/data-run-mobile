import 'dart:convert';

class ImportSummaryModel {
  final List<String> created;
  final List<String> updated;
  final Map<String, dynamic> failed;

  ImportSummaryModel(
      {required this.created, required this.updated, required this.failed});

  factory ImportSummaryModel.empty() {
    return ImportSummaryModel(created: [], updated: [], failed: {});
  }

  factory ImportSummaryModel.fromJson(Map<String, dynamic> json) {
    final created = json['created'] != null
        ? json['created'].runtimeType == String
            ? jsonDecode(json['created']).cast<String>()
            : json['created'].cast<String>()
        : null;

    final updated = json['updated'] != null
        ? json['updated'].runtimeType == String
            ? jsonDecode(json['updated']).cast<String>()
            : json['updated'].cast<String>()
        : null;

    final failed = json['failed'] != null
        ? json['failed'].runtimeType == String
            ? jsonDecode(json['failed'])
            : json['failed']
        : null;
    return ImportSummaryModel(
        created: created, updated: updated, failed: failed);
  }
}
