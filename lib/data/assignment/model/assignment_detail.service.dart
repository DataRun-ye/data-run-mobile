import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:datarunmobile/commons/identifiable.repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AssignmentDetailService {
  AssignmentDetailService(this._repository);

  final IdentifiableRepository<Assignment> _repository;
}
