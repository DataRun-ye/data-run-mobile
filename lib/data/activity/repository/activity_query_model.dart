import 'package:datarunmobile/commons/query_model.dart';

class ActivityQueryModel extends QueryModel {
  ActivityQueryModel(
      {this.project, this.disabled = false, super.limit, super.offset});

  final String? project;
  final bool disabled;

  @override
  ActivityQueryModel copyWith({
    String? project,
    bool? disabled,
    int? limit,
    int? offset,
  }) {
    return ActivityQueryModel(
      project: project ?? this.project,
      disabled: disabled ?? this.disabled,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object?> get props => super.props + [project, disabled];

  @override
  Map<String, dynamic> toMap() {
    final map = {'project': this.project, ...super.toMap()};
    return map..removeWhere((_, v) => v == null);
  }
}
