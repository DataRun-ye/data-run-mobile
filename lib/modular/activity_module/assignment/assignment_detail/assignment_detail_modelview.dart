import 'package:d2_remote/shared/enumeration/assignment_status.dart';
import 'package:datarun/core/models/d_run_identifiable.dart';
import 'package:datarun/modular/activity_module/assignment/assignment_detail/assignment_detail_model.dart';
import 'package:stacked/stacked.dart';

// Assume Assignment and related models are defined elsewhere
class AssignmentDetailViewModel extends BaseViewModel {
  AssignmentDetailViewModel();

  late final AssignmentDetail assignment;

  late final DRunIdentifiable activity;

  late final DRunIdentifiable orgUnit;

  late final DRunIdentifiable team;

  late final List<DRunIdentifiable> linkedForms;

  late final int? startDay;

  late final String? startDate;

  late AssignmentStatus? status;

  // Additional details such as linked forms, timeline data, etc.
  late final List<AssignmentDetail> childAssignments = [];

  Future<void> loadAssignmentDetails() async {
    // TODO: Fetch detailed info including linked forms and hierarchy data.
    notifyListeners();
  }
}
