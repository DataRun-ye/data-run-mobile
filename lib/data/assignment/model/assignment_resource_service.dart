import 'package:d2_remote/modules/metadatarun/assignment/entities/d_assignment.entity.dart';
import 'package:datarunmobile/commons/identifiable.repository.dart';
import 'package:datarunmobile/data/assignment/model/assignment_model_new.dart';
import 'package:datarunmobile/data/assignment/model/assignment_header.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AssignmentResourceService {
  AssignmentResourceService(this._assignmentRepository);

  final DRunBaseRepository<Assignment> _assignmentRepository;

  Map<String, num>? processResources(AssignmentModelNew assignment) {
    throw UnimplementedError();
  }
}
