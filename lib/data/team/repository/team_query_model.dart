import 'package:d2_remote/modules/datarun_shared/utilities/entity_scope.dart';
import 'package:datarunmobile/commons/query_model.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class TeamQueryModel extends QueryModel {
  TeamQueryModel({this.code, this.scope, super.limit, super.offset});

  final String? code;
  final EntityScope? scope;

  @override
  TeamQueryModel copyWith({
    String? code,
    EntityScope? scope,
    int? limit,
    int? offset,
  }) {
    return TeamQueryModel(
      code: code ?? this.code,
      scope: scope ?? this.scope,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object?> get props => super.props + [code, scope];

  @override
  Map<String, dynamic> toMap() {
    final map = {
      'code': this.code,
      'scope': this.scope?.name,
      ...super.toMap()
    };
    return map.lock.removeWhere((k, v) => v == null).unlock;
  }
}
