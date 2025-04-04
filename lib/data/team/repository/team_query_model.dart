import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:datarunmobile/commons/query/query_model.dart';

class TeamQueryModel extends QueryModel {
  TeamQueryModel(
      {this.code,
      this.activity,
      this.disabled = false,
      this.scope,
      super.limit,
      super.offset,
      super.orderBy});

  final String? code;
  final bool disabled;
  final String? activity;
  final EntityScope? scope;

  @override
  List<Object?> get props => super.props + [activity, disabled, code, scope];

  @override
  Map<String, dynamic> toMap() {
    final map = {
      'code': this.code,
      'activity': this.activity,
      'disabled': this.disabled,
      'scope': this.scope?.name,
      ...super.toMap()
    };
    return map..removeWhere((k, v) => v == null);
  }
}
