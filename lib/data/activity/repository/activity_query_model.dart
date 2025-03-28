import 'package:datarunmobile/commons/query_model.dart';

class ActivityQueryModel extends QueryModel {
  ActivityQueryModel({this.project, super.limit, super.offset});

  final String? project;

  @override
  ActivityQueryModel copyWith({
    String? project,
    int? limit,
    int? offset,
  }) {
    return ActivityQueryModel(
      project: project ?? this.project,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object?> get props => super.props + [project];

  @override
  Map<String, dynamic> toMap() {
    final map = {'project': this.project, ...super.toMap()};
    return map..removeWhere((_, v) => v == null);
  }
}
