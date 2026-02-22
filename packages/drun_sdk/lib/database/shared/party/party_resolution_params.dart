import 'package:equatable/equatable.dart';

class PartyResolutionParams extends Equatable {
  final String assignmentId;
  final String? vocabularyId;
  final String roleName;

  /// For filtering the results
  final String? searchQuery;

  const PartyResolutionParams({
    required this.assignmentId,
    this.vocabularyId,
    required this.roleName,
    this.searchQuery,
  });

  @override
  List<Object?> get props =>
      [assignmentId, vocabularyId, roleName, searchQuery];
}
