import 'package:equatable/equatable.dart';

class FormListFilter with EquatableMixin {
  factory FormListFilter.fromMap(Map<String, dynamic> map) {
    return FormListFilter(
      assignment: map['assignment'] as String?,
      team: map['team'] as String?,
    );
  }

  const FormListFilter({
    this.assignment,
    this.team,
  });

  final String? assignment;
  final String? team;

  FormListFilter copyWith({
    String? activity,
    String? assignment,
    String? team,
  }) {
    return FormListFilter(
      assignment: assignment ?? this.assignment,
      team: team ?? this.team,
    );
  }

  @override
  List<Object?> get props => [assignment, team];
}
