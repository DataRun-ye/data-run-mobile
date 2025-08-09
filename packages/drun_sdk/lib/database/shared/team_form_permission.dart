import 'package:d_sdk/core/util/parsing_helpers.dart';
import 'package:d_sdk/database/shared/form_permission.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class TeamFormPermission with EquatableMixin {
  final String form;
  final IList<FormPermission> permissions;

  TeamFormPermission(
      {required this.form, Iterable<FormPermission>? permissions})
      : this.permissions = IList.orNull(permissions) ?? IList([]);

  bool hasPermission(FormPermission action) {
    return permissions.any((permission) => permission == action);
  }

  factory TeamFormPermission.fromJson(Map<String, dynamic> json) {
    final permissions = json['permissions'] != null
        ? (parseDynamicJson(json['permissions']) as List)
            .map((permission) => FormPermission.getType(permission)!)
            .toList()
        : <FormPermission>[];

    return TeamFormPermission(
      form: json['form'],
      permissions: permissions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'form': form,
      'permissions': permissions.map((permission) => permission.name).toList(),
    };
  }

  @override
  List<Object?> get props => [form, permissions];
}
