import 'package:d_sdk/core/util/list_extensions.dart';
import 'package:equatable/equatable.dart';

enum CombineMode { UNION, INTERSECT }

class AssignmentBinding with EquatableMixin {
  /// `Null` if global for assignment
  final String? templateUid;

  final String roleName;

  final String partySetId;

  /// For debugging/audit: "Role Binding (Team X)", "Assignment Default", etc.
  final String provenance;

  final CombineMode combineMode;

  AssignmentBinding(
      {this.templateUid,
      required this.roleName,
      required this.provenance,
      required this.partySetId,
      required this.combineMode});

  @override
  List<Object?> get props =>
      [templateUid, roleName, provenance, partySetId, combineMode];

  Map<String, dynamic> toJson() {
    return {
      'templateUid': this.templateUid,
      'roleName': this.roleName,
      'partySetId': partySetId,
      'provenance': this.provenance,
      'combineMode': this.combineMode.name,
    };
  }

  factory AssignmentBinding.fromJson(Map<String, dynamic> json) {
    return AssignmentBinding(
      templateUid: json['rootId'],
      roleName: json['depth'],
      partySetId: json['partySetId'],
      provenance: json['provenance'],
      combineMode: CombineMode.values
              .firstOrNullWhere((f) => f.name == json['combineMode']) ??
          CombineMode.UNION,
    );
  }
}
