import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarunmobile/commons/query_model.dart';

class AssignmentQueryModel extends QueryModel {
  AssignmentQueryModel(
      {this.activity,
      this.orgUnit,
      this.team,
      this.date,
      this.scope,
      this.status,
      super.limit,
      super.offset});

  final String? activity;
  final String? orgUnit;
  final String? team;
  final String? date;
  final EntityScope? scope;
  final AssignmentStatus? status;

  @override
  AssignmentQueryModel copyWith({
    String? activity,
    String? orgUnit,
    String? team,
    String? date,
    EntityScope? scope,
    AssignmentStatus? status,
    int? limit,
    int? offset,
  }) {
    return AssignmentQueryModel(
      activity: activity ?? this.activity,
      orgUnit: orgUnit ?? this.orgUnit,
      team: team ?? this.team,
      date: date ?? this.date,
      scope: scope ?? this.scope,
      status: status ?? this.status,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object?> get props =>
      super.props + [activity, orgUnit, team, date, scope, status];

  @override
  Map<String, dynamic> toMap() {
    final map = {
      'activity': this.activity,
      'orgUnit': this.orgUnit,
      'team': this.team,
      'date': this.date,
      'scope': this.scope?.name,
      'status': this.status?.name,
      ...super.toMap()
    };
    return map..removeWhere((_, v) => v == null);
  }
}
