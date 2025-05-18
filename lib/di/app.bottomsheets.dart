import 'package:datarunmobile/core/models/overlay_response.dart';
import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/features/bottom_sheet/application/bottom_sheet_service.dart';
import 'package:datarunmobile/features/custom/presentation/notice/notice_sheet.dart';
import 'package:datarunmobile/features/shared/domain/form_selection_response.dart';
import 'package:datarunmobile/features/shared/presentation/form_selection/form_selection_sheet.dart';

enum BottomSheetType { notice, createSubmission }

void setupBottomSheetUi() {
  final bottomsheetService = appLocator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.notice: (context, request, completer) =>
        NoticeSheet(request: request, completer: completer),
    BottomSheetType.createSubmission: (context, request, completer) =>
        FormSelectionSheet(
          assignment: request.data as String,
          onComplete: (formVersion, assignment) => completer(
              SheetResponse<FormSelectionResponse>(
                  data: FormSelectionResponse(
                      assignment: assignment, formVersion: formVersion))),
        ),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
