// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedBottomsheetGenerator
// **************************************************************************

import 'package:datarunmobile/features/common_ui_element/notice/notice_sheet.dart';
import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';

enum BottomSheetType {
  notice,
}

void setupBottomSheetUi() {
  final bottomsheetService = locator<BottomSheetService>();

  final Map<BottomSheetType, SheetBuilder> builders = {
    BottomSheetType.notice: (context, request, completer) =>
        NoticeSheet(request: request, completer: completer),
  };

  bottomsheetService.setCustomSheetBuilders(builders);
}
