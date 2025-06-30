import 'dart:async';

import 'package:d2_remote/modules/datarun/form/shared/value_type.dart';
import 'package:datarunmobile/core/form/data/form_repository.dart';
import 'package:datarunmobile/core/form/model/action_type.dart';
import 'package:datarunmobile/core/form/model/form_command.dart';
import 'package:datarunmobile/core/form/model/store_result.dart';
import 'package:datarunmobile/core/form/model/value_store_result.dart';
import 'package:datarunmobile/core/form/ui/intent/command.dart';
import 'package:injectable/injectable.dart';

@injectable
class FormCommandHandler {
  FormCommandHandler({required this.repository});

  final FormRepository repository;

  FutureOr<StoreResult> handleCommand(FormCommand action) async {
    return switch (action.type) {
      CommandType.ON_SAVE => _handleSaveCmd(action),
      CommandType.ON_FOCUS ||
      CommandType.ON_NEXT =>
        _handleFocusOrNextCmd(action),
      CommandType.ON_TEXT_CHANGE => _handleTextChangeCmd(action),
      CommandType.ON_SECTION_CHANGE => _handleSectionChangeCmd(action),
      CommandType.ON_FINISH => _handleFinishCmd(action),
      CommandType.ON_REQUEST_COORDINATES =>
        _handleRequestCoordinatesCmd(action),
      CommandType.ON_CANCEL_REQUEST_COORDINATES =>
        _handleCancelRequestCoordinatesCmd(action),

      // ActionType.ON_ADD_IMAGE_FINISHED => _handleOnAddImageFinishedAction(action),
      // ActionType.ON_STORE_FILE => _handleOnStoreFileAction(action),
      CommandType.ON_FETCH_OPTIONS => _handleFetchOptionsCmd(action),
    };
  }

  Future<StoreResult> _handleFetchOptionsCmd(FormCommand action) async {
    repository.fetchOptions(action.uid, action.extraData!);
    return StoreResult(
      uid: action.uid,
      valueStoreResult: ValueStoreResult.VALUE_CHANGED,
    );
  }

  Future<StoreResult> _handleSaveCmd(FormCommand action) async {
    if (action.valueType == ValueType.Coordinate) {
      repository.setFieldRequestingCoordinates(action.uid, false);
    }

    repository.updateErrorList(action);
    if (action.error != null) {
      return StoreResult(
        uid: action.uid,
        valueStoreResult: ValueStoreResult.VALUE_UNCHANGED,
      );
    }

    final saveResult =
        await repository.save(action.uid, action.value, action.extraData);
    if (saveResult?.valueStoreResult != ValueStoreResult.ERROR_UPDATING_VALUE) {
      if (action.isEventDetailsRow) {
        await repository.fetchFormItems();
      } else {
        repository.updateValueOnList(
            action.uid, action.value, action.valueType);
      }
    } else {
      repository.updateErrorList(
        action.copyWith(
          error: Throwable(saveResult.valueStoreResultMessage),
        ),
      );
    }
    return saveResult ??
        StoreResult(
          uid: action.uid,
          valueStoreResult: ValueStoreResult.VALUE_CHANGED,
        );
  }

  Future<StoreResult> _handleFocusOrNextCmd(FormCommand action) async {
    final storeResult = await saveLastFocusedItem(action);
    repository.setFocusedItem(action);
    previousActionItem = action;
    return storeResult;
  }

  Future<StoreResult> _handleTextChangeCmd(FormCommand action) async {
    await repository.updateValueOnList(
        action.uid, action.value, action.valueType);
    return StoreResult(
      uid: action.uid,
      valueStoreResult: ValueStoreResult.TEXT_CHANGING,
    );
  }

  FutureOr<StoreResult> _handleSectionChangeCmd(FormCommand action) {
    repository.updateSectionOpened(action);
    return StoreResult(
      uid: action.uid,
      valueStoreResult: ValueStoreResult.VALUE_UNCHANGED,
    );
  }

  FutureOr<StoreResult> _handleFinishCmd(FormCommand action) async {
    repository.setFocusedItem(action);
    return StoreResult(
      uid: '',
      valueStoreResult: ValueStoreResult.FINISH,
    );
  }

  FutureOr<StoreResult> _handleRequestCoordinatesCmd(
      FormCommand action) async {
    repository.setFieldRequestingCoordinates(action.uid, true);
    return StoreResult(
      uid: action.uid,
      valueStoreResult: ValueStoreResult.VALUE_UNCHANGED,
    );
  }

  FutureOr<StoreResult> _handleCancelRequestCoordinatesCmd(
      FormCommand action) async {
    repository.setFieldRequestingCoordinates(action.uid, false);
    return StoreResult(
      uid: action.uid,
      valueStoreResult: ValueStoreResult.VALUE_UNCHANGED,
    );
  }

  // Future<StoreResult> _handleOnAddImageFinishedAction(FormCommand action) async {
  //   await repository.setFieldAddingImage(action.uid, false);
  //   return StoreResult(
  //     uid: action.uid,
  //     valueStoreResult: ValueStoreResult.VALUE_HAS_NOT_CHANGED,
  //   );
  // }

// Future<StoreResult> _handleOnStoreFileAction(FormCommand action) async {
//   final saveResult = await repository.storeFile(action.uid, action.value);
//   return switch (saveResult?.valueStoreResult) {
//     ValueStoreResult.FILE_SAVED => processUserAction(
//         rowActionFromIntent(
//           FormIntent.OnSave(
//             uid = action.uid,
//             value = saveResult.uid,
//             valueType = action.valueType,
//           ),
//         ),
//       ),
//     null => StoreResult(
//         uid: action.uid,
//         valueStoreResult: ValueStoreResult.VALUE_HAS_NOT_CHANGED,
//       ),
//     _ => saveResult
//   };
// }

// _saveLastFocusedItem(FormCommand rowAction) => getLastFocusedTextItem()?.let {
// if (previousActionItem == null) previousActionItem = rowAction
// if (previousActionItem?.value != it.value && previousActionItem?.id == it.uid) {
// val action = rowActionFromIntent(
// FormIntent.OnSave(
// it.uid,
// it.value,
// it.valueType,
// it.fieldMask,
// it.allowFutureDates,
// ),
// )
// if (action.error != null) {
// repository.updateErrorList(action)
// StoreResult(
// rowaction.uid,
// ValueStoreResult.VALUE_HAS_NOT_CHANGED,
// )
// } else {
// checkAutoCompleteForLastFocusedItem(it)
// val result = repository.save(it.uid, it.value, action.extraData)
// repository.updateValueOnList(it.uid, it.value, it.valueType)
// repository.updateErrorList(action)
// result
// }
// } else {
// StoreResult(
// rowaction.uid,
// ValueStoreResult.VALUE_HAS_NOT_CHANGED,
// )
// }
// } ?: StoreResult(
// rowaction.uid,
// ValueStoreResult.VALUE_HAS_NOT_CHANGED,
// )
}
