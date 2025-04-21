import 'package:datarunmobile/di/injection.dart';
import 'package:datarunmobile/features/bottom_sheet/application/bottom_sheet_service.dart';
import 'package:datarunmobile/features/custom/presentation/notice/notice_sheet.dart';

enum BottomSheetType {
  notice,
}

void setupBottomSheetUi() {
  final bottomsheetService = appLocator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.notice: (context, request, completer) =>
        NoticeSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
