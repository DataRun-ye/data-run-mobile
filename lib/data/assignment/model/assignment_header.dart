import 'package:d2_remote/modules/metadatarun/org_unit/entities/org_unit.entity.dart';
import 'package:datarunmobile/core/models/d_run_identifiable.dart';
import 'package:equatable/equatable.dart';

class AssignmentHeaderState with EquatableMixin {
  AssignmentHeaderState({
    required this.title,
    required this.orgUnit,
    required this.startDate,
  });

  final String title;
  final DRunIdentifiable<OrgUnit> orgUnit;
  final DateTime? startDate;

  @override
  List<Object?> get props => [title, orgUnit, startDate];
}
