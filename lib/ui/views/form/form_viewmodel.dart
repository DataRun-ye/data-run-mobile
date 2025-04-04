import 'package:datarunmobile/app/app.locator.dart';
import 'package:datarunmobile/core/common/state.dart';
import 'package:datarunmobile/data/assignment/assignment.dart';
import 'package:datarunmobile/data/assignment/model/assignment_model_new.dart';
import 'package:datarunmobile/data/assignment/model/assignment_resource_service.dart';
import 'package:datarunmobile/data/assignment/model/timeline_service.dart';
import 'package:datarunmobile/data/form/form.dart';
import 'package:datarunmobile/data/form_submission/model/form_submission_list.service.dart';
import 'package:stacked/stacked.dart';

class FormViewModel extends ReactiveViewModel {
  final AssignmentListService _assignmentService =
      locator<AssignmentListService>();
  final FormListService _formsListService = locator<FormListService>();
  final FormSubmissionListService _submissionService =
      locator<FormSubmissionListService>();

  FormVersionModel? form;

  Map<SyncStatus, int> submissionCountOfForm = {};

  bool isLoading = true;
  String? errorMessage;

  Future<void> load(String assignmentId) async {
    try {
      isLoading = true;
      notifyListeners();
      form = await _formsListService.getById(assignmentId);
      submissionCountOfForm;

      // Count by status
      _submissionService.get(query: AssignmentQueryModel(form: form!.id!));
      errorMessage = null;
    } catch (e) {
      errorMessage = 'Failed to load data: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
