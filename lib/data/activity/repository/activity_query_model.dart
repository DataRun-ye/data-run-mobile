import 'package:datarunmobile/commons/query/query_model.dart';

class ActivityQueryModel extends QueryModel {
  ActivityQueryModel(
      {this.project,
      this.disabled = false,
      super.limit,
      super.offset,
      super.orderBy});

  final String? project;
  final bool disabled;

  @override
  List<Object?> get props => super.props + [project, disabled];

  @override
  Map<String, dynamic> toMap() {
    final map = {'project': this.project, ...super.toMap()};
    return map..removeWhere((_, v) => v == null);
  }
}
