import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:datarunmobile/data/repository/identifiable.repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AssignmentDetailService {
  AssignmentDetailService(this._assignmentListLocalRepositories);

  final IdentifiableRepository<Assignment> _assignmentListLocalRepositories;
}
