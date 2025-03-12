import 'package:datarunmobile/core/form/model/value_store_result.dart';
import 'package:equatable/equatable.dart';

class StoreResult with EquatableMixin {
  StoreResult(
      {required this.uid,
      required this.valueStoreResult,
      required this.valueStoreResultMessage});

  final String uid;
  final ValueStoreResult? valueStoreResult;
  final String? valueStoreResultMessage;

  bool get contextDataChanged =>
      [
        'EVENT_REPORT_DATE_UID',
        'EVENT_ORG_UNIT_UID',
        'EVENT_COORDINATE_UID',
        'EVENT_CATEGORY_COMBO_UID'
      ].contains(uid) &&
      valueStoreResult == ValueStoreResult.VALUE_CHANGED;

  StoreResult copyWith({
    String? uid,
    ValueStoreResult? valueStoreResult,
    String? valueStoreResultMessage,
  }) {
    return StoreResult(
      uid: uid ?? this.uid,
      valueStoreResult: valueStoreResult ?? this.valueStoreResult,
      valueStoreResultMessage:
          valueStoreResultMessage ?? this.valueStoreResultMessage,
    );
  }

  @override
  List<Object?> get props =>
      [uid, valueStoreResultMessage, valueStoreResultMessage];
}
