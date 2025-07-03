import 'package:datarunmobile/core/form/model/value_store_result.dart';
import 'package:equatable/equatable.dart';

class StoreResult with EquatableMixin {
  StoreResult(
      {required this.uid,
      required this.valueStoreResult,
      this.message});

  final String uid;
  final ValueStoreResult? valueStoreResult;
  final String? message;

  bool get contextDataChanged =>
      [
        'EVENT_REPORT_DATE_UID',
        'EVENT_ORG_UNIT_UID',
        'EVENT_COORDINATE_UID',
        'EVENT_CATEGORY_COMBO_UID'
      ].contains(uid) &&
      valueStoreResult == ValueStoreResult.valueChanged;

  StoreResult copyWith({
    String? uid,
    ValueStoreResult? valueStoreResult,
    String? message,
  }) {
    return StoreResult(
      uid: uid ?? this.uid,
      valueStoreResult: valueStoreResult ?? this.valueStoreResult,
      message:
          message ?? this.message,
    );
  }

  @override
  List<Object?> get props =>
      [uid, valueStoreResult, message];
}
