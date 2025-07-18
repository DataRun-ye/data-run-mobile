import 'package:d_sdk/database/database.dart';
import 'package:datarunmobile/app/di/injection.dart';
import 'package:drift/drift.dart';
import 'package:stacked/stacked.dart';

class FormSelectionViewmodel extends BaseViewModel {
  FormSelectionViewmodel(this.assignment);

  final List<FormTemplate> forms = [];
  final String assignment;

  Future<void> run() async {
    setError(null);
    setBusy(true);
    List<FormTemplate> assignmentFormTemplates = [];
    try {
      assignmentFormTemplates = await runBusyFuture<List<FormTemplate>>(
          futureToRun(),
          throwException: true);
      forms.addAll(assignmentFormTemplates);
    } catch (error) {
      setError(error);
      setBusy(false);
      notifyListeners();
      rethrow;
    }
  }

  Future<List<FormTemplate>> futureToRun() async {
    final db = appLocator<DbManager>().db;

    db.managers.assignmentForms
        .filter((f) => f.assignment.id(assignment) & f.canAddSubmissions(true));

    final List<(AssignmentForm, $$AssignmentFormsTableReferences)>
        assignmentFormsWithRefs = await db.managers.assignmentForms
            .filter(
                (f) => f.assignment.id(assignment) & f.canAddSubmissions(true))
            .withReferences((prefetch) => prefetch(form: true))
            .get();

    final List<FormTemplate> assignmentFormTemplates =
        assignmentFormsWithRefs.map((assignmentWithRef) {
      final (assignmentForm, ref) = assignmentWithRef;
      return ref.form.prefetchedData!.first;
    }).toList();

    return assignmentFormTemplates;
  }
}
