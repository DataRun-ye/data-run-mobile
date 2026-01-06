import 'package:d_sdk/database/shared/d_identifiable_model.dart';
import 'package:equatable/equatable.dart';

class ActivityModel extends IdentifiableModel with EquatableMixin {
  ActivityModel({
    required super.id,
    super.code,
    required super.name,
    super.label,
    super.properties,
    this.disabled = false,
    this.managedTeams = const [],
    this.assignedAssignments = 0,
    this.managedAssignments = 0,
    this.assignedTeam,
    this.startDate,
    this.endDate,
  });

  final List<IdentifiableModel> managedTeams;

  final IdentifiableModel? assignedTeam;
  final DateTime? startDate;
  final DateTime? endDate;
  final bool disabled;
  final int assignedAssignments;
  final int managedAssignments;

  @override
  List<Object?> get props =>
      [id, managedTeams, assignedTeam, assignedAssignments, managedAssignments];

  ActivityModel copyWith({
    String? id,
    String? code,
    String? name,
    Map<String, dynamic>? label,
    Map<String, dynamic>? properties,
    List<IdentifiableModel>? managedTeams,
    IdentifiableModel? assignedTeam,
    DateTime? startDate,
    DateTime? endDate,
    bool? disabled,
    int? assignedAssignments,
    int? managedAssignments,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      label: label ?? this.label,
      disabled: disabled ?? this.disabled,
      properties: properties ?? this.properties,
      managedTeams: managedTeams ?? this.managedTeams,
      assignedTeam: assignedTeam ?? this.assignedTeam,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      assignedAssignments: assignedAssignments ?? this.assignedAssignments,
      managedAssignments: managedAssignments ?? this.managedAssignments,
    );
  }
}
