import 'package:d_sdk/database/shared/shared.dart';
import 'package:equatable/equatable.dart';

// part 'repeat_group_intent.dart';

sealed class FormIntent with EquatableMixin {
  const factory FormIntent.onFinish({String? extraData}) = OnFinish;

  const factory FormIntent.onFocus(String uid, String? value) = OnFocus;

  const factory FormIntent.onNext(String uid, String? value, [int? position]) =
      OnNext;

  const factory FormIntent.onSave(
      String uid, String? value, ValueType? valueType) = OnSave;

  const factory FormIntent.onTextChange(String uid, String? value) =
      OnTextChange;

  const factory FormIntent.clearValue(String uid) = ClearValue;

  const factory FormIntent.onClear({String? extraData}) = OnClear;

  const factory FormIntent.onSection(String sectionId) = OnSection;

  const factory FormIntent.onQrCodeScanned(
      String uid, String? value, ValueType valueType) = OnQrCodeScanned;

  const factory FormIntent.onSaveDate(
      String uid, String? value, ValueType valueType,
      [bool allowFutureDates]) = OnSaveDate;

  const factory FormIntent.fetchOptions(
      String uid, String optionSetUid, String? value) = FetchOptions;
}

final class OnFinish implements FormIntent {
  const OnFinish({this.extraData});

  final String? extraData;

  @override
  List<Object?> get props => [extraData];

  @override
  bool? get stringify => true;
}

final class OnFocus implements FormIntent {
  const OnFocus(this.uid, this.value);

  final String uid;
  final String? value;

  @override
  List<Object?> get props => [uid, value];

  @override
  bool? get stringify => true;
}

final class OnNext implements FormIntent {
  const OnNext(this.uid, this.value, [this.position]);

  final String uid;
  final String? value;
  final int? position;

  @override
  List<Object?> get props => [uid, value, position];

  @override
  bool? get stringify => true;
}

final class OnSave implements FormIntent {
  const OnSave(
    this.uid,
    this.value,
    this.valueType, {
    this.fieldMask,
    this.allowFutureDates = false,
  });

  final String uid;
  final String? value;
  final ValueType? valueType;
  final String? fieldMask;
  final bool allowFutureDates;

  @override
  List<Object?> get props =>
      [uid, value, valueType, fieldMask, allowFutureDates];

  @override
  bool? get stringify => true;
}

class OnTextChange implements FormIntent {
  const OnTextChange(this.uid, this.value);

  final String uid;
  final String? value;

  @override
  List<Object?> get props => [uid, value];

  @override
  bool? get stringify => true;
}

class ClearValue implements FormIntent {
  const ClearValue(this.uid);

  final String uid;

  @override
  List<Object?> get props => [uid];

  @override
  bool? get stringify => true;
}

class OnClear implements FormIntent {
  const OnClear({this.extraData});

  final String? extraData;

  @override
  List<Object?> get props => [extraData];

  @override
  bool? get stringify => true;
}

final class OnQrCodeScanned implements FormIntent {
  const OnQrCodeScanned(this.uid, this.value, this.valueType);

  final String uid;
  final String? value;
  final ValueType valueType;

  @override
  List<Object?> get props => [uid, value, valueType];

  @override
  bool? get stringify => true;
}

final class OnSaveDate implements FormIntent {
  const OnSaveDate(this.uid, this.value, this.valueType,
      [this.allowFutureDates = true]);

  final String uid;
  final String? value;
  final ValueType valueType;
  final bool allowFutureDates;

  @override
  List<Object?> get props => [uid, value, valueType, allowFutureDates];

  @override
  bool? get stringify => true;
}

final class OnSection implements FormIntent {
  const OnSection(this.sectionUid);

  final String sectionUid;

  @override
  List<Object?> get props => [sectionUid];

  @override
  bool? get stringify => true;
}

final class FetchOptions implements FormIntent {
  const FetchOptions(this.uid, this.optionSetUid, this.value);

  final String uid;
  final String optionSetUid;
  final String? value;

  @override
  List<Object?> get props => [uid, optionSetUid, value];

  @override
  bool? get stringify => true;
}
