import 'package:d2_remote/modules/datarun/form/shared/validation_strategy.dart';
import 'package:datarunmobile/data/model/bottom_sheet_content_model.data.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

/// An object summarizing the validation status of the form.
sealed class DataIntegrityCheckResult with EquatableMixin {
  const factory DataIntegrityCheckResult.notSavedResult() = NotSavedResult._;

  const factory DataIntegrityCheckResult.missingMandatoryResult(
      {required IMap<String, String> mandatoryFields,
      required IList<FieldWithIssue> errorFields,
      required IList<FieldWithIssue> warningFields,
      required bool canComplete,
      String? onCompleteMessage,
      required EventResultDetails eventResultDetails,
      required bool allowDiscard}) = MissingMandatoryResult;

  const factory DataIntegrityCheckResult.fieldsWithErrorResult(
      {required IMap<String, String> mandatoryFields,
      required IList<FieldWithIssue> fieldUidErrorList,
      required IList<FieldWithIssue> warningFields,
      required bool canComplete,
      String? onCompleteMessage,
      required EventResultDetails eventResultDetails,
      required bool allowDiscard}) = FieldsWithErrorResult;

  const factory DataIntegrityCheckResult.fieldsWithWarningResult(
          {required IList<FieldWithIssue> fieldUidWarningList,
          required bool canComplete,
          String? onCompleteMessage,
          required EventResultDetails eventResultDetails}) =
      FieldsWithWarningResult;

  const factory DataIntegrityCheckResult.successfulResult(
      {String? extraData,
      required bool canComplete,
      String? onCompleteMessage,
      required EventResultDetails eventResultDetails}) = SuccessfulResult;

  const DataIntegrityCheckResult._({
    this.canComplete = false,
    this.onCompleteMessage,
    this.allowDiscard = false,
    this.eventResultDetails = const EventResultDetails(),
  });

  final bool canComplete;
  final String? onCompleteMessage;
  final bool allowDiscard;
  final EventResultDetails eventResultDetails;

  @override
  List<Object?> get props =>
      [canComplete, onCompleteMessage, allowDiscard, eventResultDetails];

  @override
  bool? get stringify => true;
}

class MissingMandatoryResult extends DataIntegrityCheckResult {
  const MissingMandatoryResult({
    required this.mandatoryFields,
    required this.errorFields,
    required this.warningFields,
    required bool canComplete,
    String? onCompleteMessage,
    required EventResultDetails eventResultDetails,
    required bool allowDiscard,
  }) : super._(
            canComplete: canComplete,
            onCompleteMessage: onCompleteMessage,
            eventResultDetails: eventResultDetails,
            allowDiscard: allowDiscard);

  final IMap<String, String> mandatoryFields;
  final IList<FieldWithIssue> errorFields;
  final IList<FieldWithIssue> warningFields;

  List<Object?> get props =>
      super.props + [mandatoryFields, errorFields, warningFields];
}

class FieldsWithErrorResult extends DataIntegrityCheckResult {
  const FieldsWithErrorResult({
    required this.mandatoryFields,
    required this.fieldUidErrorList,
    required this.warningFields,
    required bool canComplete,
    String? onCompleteMessage,
    required EventResultDetails eventResultDetails,
    required bool allowDiscard,
  }) : super._(
            canComplete: canComplete,
            onCompleteMessage: onCompleteMessage,
            eventResultDetails: eventResultDetails,
            allowDiscard: allowDiscard);

  final IMap<String, String> mandatoryFields;
  final IList<FieldWithIssue> fieldUidErrorList;
  final IList<FieldWithIssue> warningFields;

  List<Object?> get props =>
      super.props + [mandatoryFields, fieldUidErrorList, warningFields];
}

class FieldsWithWarningResult extends DataIntegrityCheckResult {
  const FieldsWithWarningResult(
      {required this.fieldUidWarningList,
      required bool canComplete,
      String? onCompleteMessage,
      required EventResultDetails eventResultDetails})
      : super._(
            canComplete: canComplete,
            onCompleteMessage: onCompleteMessage,
            eventResultDetails: eventResultDetails);

  final IList<FieldWithIssue> fieldUidWarningList;

  List<Object?> get props => super.props + [fieldUidWarningList];
}

class SuccessfulResult extends DataIntegrityCheckResult {
  const SuccessfulResult(
      {this.extraData,
      required bool canComplete,
      String? onCompleteMessage,
      required EventResultDetails eventResultDetails})
      : super._(
            canComplete: canComplete,
            onCompleteMessage: onCompleteMessage,
            eventResultDetails: eventResultDetails);

  final String? extraData;

  List<Object?> get props => super.props + [extraData];
}

class NotSavedResult extends DataIntegrityCheckResult {
  const NotSavedResult._() : super._();
}

class EventResultDetails {
  const EventResultDetails({
    this.isFinal,
    // this.eventMode,
    this.validationStrategy,
  });

  final bool? isFinal;

  // final EventMode? eventMode;
  final ValidationStrategy? validationStrategy;
}
//
// class FieldWithIssue with EquatableMixin {
//   const FieldWithIssue({
//     this.repeatGroupUid,
//     this.rowUid,
//     required this.fieldUid,
//     required this.message,
//     required this.fieldName,
//     required this.issueType,
//   });
//
//   final String? repeatGroupUid;
//   final String? rowUid;
//   final String fieldUid;
//   final String message;
//   final String fieldName;
//   final IssueType issueType;
//
//   @override
//   List<Object?> get props =>
//       [repeatGroupUid, rowUid, fieldUid, message, fieldName, issueType];
//
//   @override
//   bool? get stringify => true;
// }

// Example enums (define these according to your needs)
// enum EventStatus { active, completed, scheduled }
//
// enum EventMode { capture, view, edit }
//
// enum ValidationStrategy { strict, lenient, partial }

// part 'data_integrity_check_result.freezed.dart';
//
// @freezed
// class DataIntegrityCheckResult with _$DataIntegrityCheckResult {
//
//   const factory DataIntegrityCheckResult.missingMandatoryResult(
//       {required IMap<String, String> mandatoryFields,
//       required IList<FieldWithIssue> errorFields,
//       required IList<FieldWithIssue> warningFields,
//       @Default(false) bool canComplete,
//       String? onCompleteMessage,
//         required DataIntegrityCheckResult DataIntegrityCheckResult,
//       @Default(false) bool allowDiscard}) = MissingMandatoryResult;
//
//   const factory DataIntegrityCheckResult.fieldsWithErrorResult(
//       {required IMap<String, String> mandatoryFields,
//       required IList<FieldWithIssue> fieldUidErrorList,
//       required IList<FieldWithIssue> warningFields,
//       // override
//       @Default(false) bool canComplete,
//       String? onCompleteMessage,
//       @Default(false) bool allowDiscard}) = FieldsWithErrorResult;
//
//   const factory DataIntegrityCheckResult.fieldsWithWarningResult(
//       {required IList<FieldWithIssue> fieldUidWarningList,
//       // override
//       @Default(false) bool canComplete,
//       String? onCompleteMessage,
//       @Default(false) bool allowDiscard}) = FieldsWithWarningResult;
//
//   const factory DataIntegrityCheckResult.successfulResult(
//       {String? extraData,
//       // override
//       @Default(false) bool canComplete,
//       String? onCompleteMessage,
//   required DataIntegrityCheckResult DataIntegrityCheckResult,
//       @Default(false) bool allowDiscard}) = SuccessfulResult;
//
//   const factory DataIntegrityCheckResult.notSavedResult() = NotSavedResult;
// }
//
// final class EventResultDetails with EquatableMixin {
//   const EventResultDetails(this.isFinal, this.validationStrategy);
//
//   final bool isFinal;
//   final ValidationStrategy? validationStrategy;
//
//   @override
//   List<Object?> get props => [isFinal, validationStrategy];
// }
